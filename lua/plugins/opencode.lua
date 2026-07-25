local cmd = "opencode --port"

local terminal_opts = {
  cwd = LazyVim.root(),
  win = {
    position = "right",
    width = 55,
    enter = true,
    keys = {
      term_normal = {
        "<Esc>",
        "<C-\\><C-n>",
        mode = "t",
      },

      interrupt = {
        "<C-g>",
        function()
          local job_id = vim.b.terminal_job_id

          if job_id then
            vim.api.nvim_chan_send(job_id, "\27")
          end
        end,
        mode = "t",
        desc = "Interrupt OpenCode",
      },
    },
  },
}

return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    dependencies = { "folke/snacks.nvim" },

    init = function()
      vim.o.autoread = true

      vim.g.opencode_opts = {
        server = {
          start = function()
            Snacks.terminal.open(cmd, terminal_opts)
          end,
        },
      }
    end,

    keys = {
      {
        "<leader>oc",
        function()
          Snacks.terminal.toggle(cmd, terminal_opts)
        end,
        desc = "Toggle OpenCode",
      },
      {
        "<leader>oa",
        function()
          require("opencode").ask("@this: ")
        end,
        mode = { "n", "x" },
        desc = "Ask OpenCode",
      },
    },
  },
}
