return {
  "zbirenbaum/copilot.lua",
  init = function()
    vim.g.copilot_no_tab_map = true
  end,
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = true, auto_trigger = true },
      panel = { enabled = true },
    })
  end,
}
