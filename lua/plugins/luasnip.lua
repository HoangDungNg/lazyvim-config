return {
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      local luasnip = require("luasnip")
      -- Force TypeScript React files to inherit Javascript/JSX snippets
      luasnip.filetype_extend("typescript", { "javascript" })
      luasnip.filetype_extend("typescriptreact", { "javascriptreact", "javascript" })
    end,
  },
}
