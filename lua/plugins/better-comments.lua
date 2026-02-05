-- lua/plugins/better-comments.lua
return {
  {
    "Djancyp/better-comments.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- required by this plugin
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("better-comment").Setup({
        tags = {
          -- keep/adjust what you want for other tags...
          { name = "TODO", fg = "white", bg = "#0a7aca", bold = true, virtual_text = "" },
          { name = "FIX", fg = "white", bg = "#f44747", bold = true, virtual_text = "Fix this" },
          { name = "WARNING", fg = "#FFA500", bold = false, virtual_text = "Careful" },

          -- ✅ Make comments that start with "*" green (VS Code-like)
          -- Pick any green; here are two common choices:
          --   Catppuccin-ish green: "#a6e3a1"
          --   One Dark-ish green (matches README default vibe): "#98C379"
          { name = "*", fg = "#a6e3a1", bold = false, virtual_text = "" },
        },
      })
    end,
  },
}
