# Environment and editor configuration
export BAT_THEME="rose-pine"
export EDITOR="nvim"
export LANG="en_US.UTF-8"
export LESS='-iMRFX'
export LESSHISTFILE="-"
export MANPAGER="nvim +Man!"
export PATH="$HOME/.local/bin:$PATH"
export SUDO_EDITOR="nvim"
export VISUAL="nvim"
export WGETRC="$HOME/.config/wgetrc"

# History
HISTFILE="$HOME/.config/zsh/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history

# General shell options
setopt extendedglob

# Completion
zstyle ':completion:' menu select
zstyle ':completion:' matcher-list 'm:{a-zA-Z}={A-Za-z}'

autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Vi key bindings
bindkey -e
export KEYTIMEOUT=5

# FZF configuration
if (( $+commands[fd] )); then
  export FZF_ALT_C_COMMAND='fd -H --type d'
  export FZF_CTRL_T_COMMAND='fd -H --type f'
  export FZF_DEFAULT_COMMAND='fd -H --type f'
else
  export FZF_ALT_C_COMMAND='find . -type d'
  export FZF_CTRL_T_COMMAND='find . -type f'
  export FZF_DEFAULT_COMMAND='find . -type f'
fi

export FZF_DEFAULT_OPTS='
  --color bg+:#403d52
  --color bg:-1
  --color fg+:#e0def4
  --color fg:#e0def4
  --color header:#9ccfd8
  --color hl+:#eb6f92
  --color hl:#eb6f92
  --color info:#c4e7f7
  --color marker:#eb6f92
  --color pointer:#c4a7e7
  --color prompt:#ebbcba
  --color spinner:#eb6f92
  --height 80%
  --layout=reverse
'

# Plugins
if [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -r /usr/share/fzf/completion.zsh ]]; then
  source /usr/share/fzf/completion.zsh
fi

if [[ -r /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
fi

# Syntax highlighting
if [[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Tool integrations
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

# Aliases
alias ad='age -d -o'
alias ae='age -p -o'
alias cat='bat -p'
alias catraw='command cat'
alias clr='wl-copy -c'
alias diff='diff --color'
alias ls='eza -l -g --hyperlink --group-directories-first --icons -t modified'
alias lsa='eza -a -l -g --hyperlink --group-directories-first --icons -t modified'
alias mc="watch -n 1 \"grep '^[c]pu MHz' /proc/cpuinfo\""
alias nt='nvim "$HOME/Documents/linuxnotes"'
alias rs='ripgrep-search'
alias rup='remove-unneeded-packages'
alias sbk='sync-backup'
alias tp='watch -n 1 sensors'
alias v='nvim'
alias wf='sudo systemctl stop NetworkManager.service'
alias wo='sudo systemctl start NetworkManager.service'

# Functions
dg() {
  command git \
    --git-dir="$HOME/.dotfiles" \
    --work-tree="$HOME" \
    "$@"
}

# Fuzzy search and launch
f() {
  local file
  local preview_cmd="
    if file -b --mime-type '{}' | grep -q '^text/'; then
      bat --style=numbers,changes --color=always --line-range=:500 -- '{}'
    else
      echo 'Binary file'
    fi
  "
  file=$(fzf --preview="$preview_cmd" --preview-window=up:40%) || return 0

  handlr open -- "$file" >/dev/null 2>&1 &!
  builtin exit
}

# Change to current working directory when exiting yazi
r() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"

  command yazi "$@" --cwd-file="$tmp"

  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true

  command rm -f -- "$tmp"
}

if [[ -n "$LAUNCH_YAZI" ]]; then
  unset LAUNCH_YAZI
  r
fi

# Prevent Unicode issues in raw TTYs
if [[ "$(tty)" == */pts/* ]]; then
  eval "$(starship init zsh)"

  # Only show fastfetch on the initial parent shell
  if [[ $SHLVL -eq 1 ]]; then
    fastfetch
  fi
else
  # Fallback prompt for non-graphical TTYs
  PROMPT='%F{green}%n@%m%f %F{yellow}%~%f %# '
fi
