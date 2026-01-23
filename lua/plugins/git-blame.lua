return {
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true, -- enable the blame messages
      message_template = " <summary> • <date> • <author> • <<sha>>",
      date_format = "%Y-%m-%d %H:%M", -- customize date format
      virtual_text_column = 1, -- where virtual blame text shows
      display_virtual_text = true, -- show blame inline
    },
    keys = {
      {
        "gb",
        "<cmd>GitBlameToggle<cr>",
        desc = "Toggle Git Blame",
        mode = "n",
      },
    },
  },
}
