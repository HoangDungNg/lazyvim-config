return {
  {
    "svermeulen/vim-easyclip",
    config = function()
      -- Enable default mappings
      vim.g.EasyClipEnableDefaultMappings = 1

      -- Optional: enable system clipboard integration
      vim.g.EasyClipUseSystemClipboard = 1

      -- Optional: better paste behavior
      vim.g.EasyClipUsePasteToggleDefaults = 1
    end,
  },
}
