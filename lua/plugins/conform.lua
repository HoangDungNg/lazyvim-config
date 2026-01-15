return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    local function has_file(files)
      return function(ctx)
        local root = ctx.root or vim.fn.getcwd()
        for _, f in ipairs(files) do
          if vim.uv.fs_stat(root .. "/" .. f) then
            return true
          end
        end
        return false
      end
    end

    -- Prefer Biome if biome config exists; otherwise use Prettier if prettier config exists
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.astro = { "lsp_format" }

    local js_like = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "jsonc",
    }

    for _, ft in ipairs(js_like) do
      opts.formatters_by_ft[ft] = function(bufnr)
        local ctx = require("conform").get_formatter_info("prettier", bufnr)
        ctx = ctx or { root = vim.fs.root(bufnr, { ".git" }) or vim.fn.getcwd() }

        if has_file({ "biome.json", "biome.jsonc" })(ctx) then
          return { "biome" }
        end

        if
          has_file({
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.mjs",
            "prettier.config.js",
            "prettier.config.cjs",
            "prettier.config.mjs",
          })(ctx)
        then
          return { "prettier" }
        end

        -- fallback
        return { "prettier" }
      end
    end
  end,
}
