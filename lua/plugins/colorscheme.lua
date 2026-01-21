return {
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- Nordic options
      transparent = {
        bg = true, -- transparent editor background
        float = true, -- transparent floating windows
      },
      italic_comments = true,

      -- Make functions/variables/identifiers/comments italic
      on_highlight = function(highlights, _palette)
        local function italic(group)
          highlights[group] = highlights[group] or {}
          highlights[group].italic = true
        end

        -- Vim highlight groups
        italic("Function")
        italic("Identifier")
        italic("Variable") -- some setups use this group
        italic("Comment")

        -- Treesitter groups (common)
        italic("@function")
        italic("@function.call")
        italic("@function.method")
        italic("@method")
        italic("@identifier")
        italic("@variable")
        italic("@variable.member")
        italic("@property")
        italic("@comment")

        -- LSP semantic token groups (common)
        italic("@lsp.type.function")
        italic("@lsp.type.method")
        italic("@lsp.type.variable")
        italic("@lsp.type.parameter")
        italic("@lsp.type.property")
      end,
    },
    config = function(_, opts)
      require("nordic").setup(opts)
      -- either of these works; load() is recommended by nordic's README
      require("nordic").load()
      -- vim.cmd([[colorscheme nordic]])
    end,
  },
}
