return {
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      timeout = vim.o.timeoutlen,
      default_mappings = false, -- turn off defaults so you control everything
      mappings = {
        i = {
          j = {
            k = "<Esc>", -- jk -> Esc
            j = "<Esc>", -- jj -> Esc (optional)
          },
        },
      },
    },
  },
}
