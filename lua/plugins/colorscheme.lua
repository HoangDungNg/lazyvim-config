return {
  -- {
  -- 	"sainnhe/sonokai",
  -- 	priority = 1000,
  -- 	config = function()
  -- 		vim.g.sonokai_transparent_background = "1"
  -- 		vim.g.sonokai_enable_italic = "1"
  -- 		vim.g.sonokai_style = "andromeda"
  -- 		vim.cmd.colorscheme("sonokai")
  -- 	end,
  -- },
  --
  {
    "tiagovla/tokyodark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        identifiers = { italic = true },
        functions = { italic = true },
        variables = { italic = true },
      },
    },
    config = function(_, opts)
      require("tokyodark").setup(opts)
    end,
  },
}
