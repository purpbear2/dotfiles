return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    -- Recursively copy the rose-pine lualine theme, then swap normal with insert
    local theme = vim.deepcopy(require("lualine.themes.rose-pine"))

    for _, section in ipairs({ "a", "b" }) do
      theme.normal[section], theme.insert[section] = theme.insert[section], theme.normal[section]
    end

    require("lualine").setup({
      options = { theme = theme },
      sections = {
        lualine_a = {
          {
            "mode",
            color = { fg = "#26233a" },
          },
        },

        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 2,
          },
        },

        lualine_y = {
          {
            "progress",
            color = { bg = "#6e6a86" },
          },
        },

        lualine_z = {
          {
            "location",
            color = { fg = "#26233a" },
          },
        },
      },
    })
  end,
}
