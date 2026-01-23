return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      ensure_installed = {
        "javascript",
        "typescript",
        "css",
        "gitignore",
        "graphql",
        "http",
        "json",
        "scss",
        "sql",
        "vim",
        "lua",
        "tsx",
        "html",
        "astro",
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      build = ":TSUpdate",
      branch = "master",
    },
  },
}
