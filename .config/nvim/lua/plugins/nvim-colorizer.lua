return {
  "catgoose/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      -- Highlight all filetypes (use specific list for better performance)
      filetypes = { "*" },

      -- Optional: Exclude certain filetypes
      -- exclude_filetypes = { "markdown", "vim" },

      -- Color format options
      RGB = true,       -- #RGB
      RRGGBB = true,    -- #RRGGBB
      RRGGBBAA = true,  -- #RRGGBBAA
      AARRGGBB = true,  -- 0xAARRGGBB
      names = true,     -- "red", "blue", etc.
      rgb_fn = true,    -- rgb(255, 255, 255)
      hsl_fn = true,    -- hsl(360, 100%, 50%)
      css = true,       -- Enable CSS-specific features
      css_fn = true,    -- Enable CSS functions like `hsl()`, `rgb()`
      tailwind = true,  -- Enable Tailwind CSS color classes (recommended if you use Tailwind)
    })
  end,
}
