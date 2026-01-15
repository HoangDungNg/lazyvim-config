return {
  "mg979/vim-visual-multi",
  branch = "master",
  lazy = false, -- ensure it's loaded immediately
  init = function()
    vim.g.VM_default_mappings = 0 -- turn off defaults to avoid conflicts
    vim.g.VM_maps = {
      ["Find Under"]         = "<C-n>",
      ["Find Subword Under"] = "<C-n>",
      ["Add Cursor Down"]    = "w<Down>",
      ["Add Cursor Up"]      = "w<Up>",
    }
  end,
}



