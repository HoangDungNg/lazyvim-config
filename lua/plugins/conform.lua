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
    opts.formatters_by_ft.lua = { "stylua" }

    -- Ensure format_on_save exists and uses LSP fallback
    opts.format_on_save = opts.format_otrue

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
      -- optional but nice to detect Astro formatting support explicitly:
      "astro.config.mjs",
      "astro.config.ts",
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

    -- ✅ Astro: prefer real formatter if available, else rely on LSP fallback
    opts.formatters_by_ft.astro = function(bufnr)
      -- If you want Astro to follow the same formatter selection logic:
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
  end,
}
