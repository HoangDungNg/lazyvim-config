return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    -- Find config files by searching upward from the current buffer's directory

    local function has_upwards(files)
      return function(bufnr)
        local start = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
        for _, f in ipairs(files) do
          -- pick the NEAREST match
          local found = vim.fs.find(f, { path = start, upward = true })[1]
          if found then
            return true, found
          end
        end
        return false
      end
    end

    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.lua = { "stylua" }

    opts.format_on_save = opts.format_on_save or true

    local has_dprint = has_upwards({ "dprint.json" })
    local has_biome = has_upwards({ "biome.json", "biome.jsonc" })
    local has_prettier = has_upwards({
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
      "astro.config.mjs",
      "astro.config.ts",
    })

    local has_stylelint = has_upwards({
      "stylelint.config.js",
      "stylelint.config.cjs",
      "stylelint.config.mjs",
      "stylelint.config.ts",
      ".stylelintrc",
      ".stylelintrc.json",
      ".stylelintrc.yaml",
      ".stylelintrc.yml",
      ".stylelintrc.js",
      ".stylelintrc.cjs",
      ".stylelintrc.mjs",
    })
    local function pick_js_formatter(bufnr)
      if has_dprint(bufnr) then
        return { "dprint" }
      end
      if has_biome(bufnr) then
        return { "biome" }
      end
      if has_prettier(bufnr) then
        return { "prettier" }
      end
      -- No config found -> still okay; prettier as default
      return { "prettier" }
    end

    opts.formatters_by_ft.astro = function(bufnr)
      return pick_js_formatter(bufnr)
      -- OR if you truly want "LSP only", do:
      -- return {}
    end

    local js_like = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "jsonc",
    }

    for _, ft in ipairs(js_like) do
      opts.formatters_by_ft[ft] = pick_js_formatter
    end

    local function pick_css_formatter(bufnr)
      local use_lsp = has_stylelint(bufnr)

      -- Prefer dprint when available
      if has_dprint(bufnr) then
        if use_lsp then
          -- Stylelint (LSP) first, then dprint
          return { "dprint", lsp_format = "first" }
        end
        return { "dprint" }
      end

      -- Fallback to prettier when available
      if has_prettier(bufnr) then
        if use_lsp then
          -- Stylelint (LSP) first, then prettier
          return { "prettier", lsp_format = "first" }
        end
        return { "prettier" }
      end

      -- Optional: if only stylelint exists, still allow LSP-only formatting
      if use_lsp then
        return { lsp_format = "first" }
      end

      return {}
    end

    opts.formatters_by_ft.css = pick_css_formatter
    opts.formatters_by_ft.scss = pick_css_formatter
    opts.formatters_by_ft.less = pick_css_formatter
  end,
}
