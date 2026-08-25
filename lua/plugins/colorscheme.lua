return {
  {
    "datsfilipe/vesper.nvim",
    lazy = false,
    priority = 1000,

    opts = {
      -- 1. Enable transparency here
      transparent = true,

      italics = {
        comments = true,
        keywords = true,
        functions = true,
        strings = true,
        variables = true,
      },

      overrides = {
        -- Neo-tree: calm / low-contrast
        NeoTreeNormal = {
          fg = "#8A8A8A",
          bg = "none", -- 2. Set to "none" so the sidebar is also transparent
        },
        NeoTreeNormalNC = {
          fg = "#707070",
          bg = "none", -- 3. Set to "none" here as well
        },
        NeoTreeDirectoryName = {
          fg = "#8A9A96",
        },
        NeoTreeDirectoryIcon = {
          fg = "#65736F",
        },
        NeoTreeFileName = {
          fg = "#888888",
        },
        NeoTreeFileIcon = {
          fg = "#707070",
        },
        NeoTreeRootName = {
          fg = "#A0A0A0",
          bold = true,
        },
        NeoTreeIndentMarker = {
          fg = "#333333",
        },
        NeoTreeExpander = {
          fg = "#555555",
        },
        NeoTreeCursorLine = {
          bg = "#1C1C1C", -- This is fine to keep as it only highlights the current line
        },
        NeoTreeGitIgnored = {
          fg = "#505050",
        },

        -- Indent guides
        SnacksIndent = {
          fg = "#282828",
        },
        -- Current scope / bracket nesting guide
        SnacksIndentScope = {
          fg = "#484848",
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vesper",
    },
  },
}
