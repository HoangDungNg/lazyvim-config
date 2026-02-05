return {
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,

      -- Reordered template: AUTHOR • DATE • SHA • SUMMARY
      message_template = " <author> • <date> • <sha> • <summary>",

      date_format = "%Y-%m-%d %H:%M",
      virtual_text_column = 1,
      display_virtual_text = true,

      -- Optional: truncate long summaries (from plugin README)
      max_commit_summary_length = 50,
    },
    keys = {
      { "gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle Git Blame", mode = "n" },
    },
  },
}
