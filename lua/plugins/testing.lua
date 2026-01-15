-- Quick running Vitest tests with Neotest --
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
    opts = {
    adapters = {
    	["neotest-vitest"] = {},
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          if require("lazyvim.util").has("trouble.nvim") then
            require("trouble").open({ mode = "quickfix", focus = false })
          else
            vim.cmd("copen")
          end
        end,
      },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            return diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          end,
        },
      }, neotest_ns)

      require("neotest").setup(opts)
    end,
    keys = {
      { ";tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { ";tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { ";tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
      { ";tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
      { ";ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { ";to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { ";tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { ";tS", function() require("neotest").run.stop() end, desc = "Stop" },
    },
  },
}

