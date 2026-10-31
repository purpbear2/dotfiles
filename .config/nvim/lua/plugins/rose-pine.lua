return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      styles = {
        transparency = true,
      },
    })

    vim.cmd("colorscheme rose-pine")

    for _, group in ipairs({
      "SpellBad",
      "SpellCap",
      "SpellLocal",
      "SpellRare",
    }) do
      vim.api.nvim_set_hl(0, group, {
        undercurl = true,
        sp = "#eb6f92",
      })
    end
  end,
}
