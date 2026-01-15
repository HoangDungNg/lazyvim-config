return {
  "NvChad/nvim-colorizer.lua",
  event = "VeryLazy",
  config = function()
    require("colorizer").setup({
      filetypes = { "*" },
      user_default_options = {
        RGB      = true;       -- #RGB hex
        RRGGBB   = true;       -- #RRGGBB hex
        RRGGBBAA = true;       -- #RRGGBBAA hex
        names    = false;      -- 🔥 disable CSS color name matching
        rgb_fn   = true;       -- enable rgb()/rgba()
        hsl_fn   = true;       -- enable hsl()/hsla()
        css      = true;
        mode     = "background";
      },
    })
  end,
}

