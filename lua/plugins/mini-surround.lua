return {
  "nvim-mini/mini.surround",
  version = false, -- always use latest
  event = "VeryLazy",
  opts = {
    mappings = {
      add = "sa", -- Add surrounding
      delete = "sd", -- Delete surrounding
      replace = "sr", -- Replace surrounding
      find = "sf", -- Find surrounding (to the right)
      find_left = "sF", -- Find surrounding (to the left)
      highlight = "sh", -- Highlight surrounding
      update_n_lines = "sn", -- Update `n_lines`
    },
  },
  config = function(_, opts)
    require("mini.surround").setup(opts)

    -- Remove LazyVim defaults so your keys take over cleanly
    pcall(vim.keymap.del, "n", "gsa")
    pcall(vim.keymap.del, "n", "gsd")
    pcall(vim.keymap.del, "n", "gsr")
    pcall(vim.keymap.del, "n", "gsf")
    pcall(vim.keymap.del, "n", "gsF")
    pcall(vim.keymap.del, "n", "gsh")
    pcall(vim.keymap.del, "n", "gsn")
  end,
}
