return {
  {
    "svermeulen/vim-easyclip",
    dependencies = {
      "tpope/vim-repeat",
    },

    init = function()
      -- These must be set before EasyClip loads.
      vim.g.EasyClipUseYankDefaults = 1
      vim.g.EasyClipUsePasteDefaults = 1
      vim.g.EasyClipUsePasteToggleDefaults = 1
    end,
  },
}
