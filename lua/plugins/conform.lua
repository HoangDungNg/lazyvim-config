return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    -- Find config files by searching upward from the current buffer's directory
    local function has_upwards(files)
      return function(bufnr)
        local start = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
        for _, f in ipairs(files) do
          local found = vim.fs.find(f, { path = start, upward = true })[1]
          if found then
            return true, found
          end
        end
        return false
      end
    end

    opts.formatters_by_ft = opts.formatters_by_ft or {}

    -- Astro: keep LSP formatting (change if you want dprint/biome/prettier)
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
        })

        if has_dprint(bufnr) then
          return { "dprint" }
        end
        if has_biome(bufnr) then
          return { "biome" }
        end
        if has_prettier(bufnr) then
          return { "prettier" }
        end

        -- fallback
        return { "prettier" }
      end
    end
  end,
}
