return {
  -- tools
  { "mason-org/mason.nvim", opts = {} },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "eslint",
        "cssls",
        "tailwindcss",
        "html",
        "ts_ls",
        "biome",
        "stylelint_lsp",
      },
      -- automatic_enable = true, -- default is enabled
    },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "prettier",
        "biome",
        -- If you want Lua formatting via stylua instead of lua_ls:
        -- "stylua",
      },
    },
  },

  -- lsp servers

  {
    "neovim/nvim-lspconfig",

    init = function()
      local configs = require("lspconfig.configs")
      local util = require("lspconfig.util")

      if not configs.oxlint then
        configs.oxlint = {
          default_config = {
            cmd = { "oxc_language_server" }, -- recommended for other editors [1](https://packagecontrol.io/packages/LSP-stylelint)[2](https://github.com/neovim/nvim-lspconfig/issues/3426)
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            root_dir = util.root_pattern(".oxlintrc.json", "oxlintrc.json", "package.json", ".git"),
            settings = {
              oxc = {
                disableNestedConfig = false,
                typeAware = false,
              },
            },
          },
        }
      end
    end,

    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
      inlay_hints = { enabled = true },

      servers = {

        oxlint = {
          -- You can override defaults here if desired. Leaving empty uses default_config.
          -- Example: enable type-aware (requires your project setup)
          -- settings = { oxc = { typeAware = true } },

          -- Optional: add a command to apply "fix all" (Oxlint supports `oxc.fixAll`)
          on_attach = function(client, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, "OxlintFixAll", function()
              client:exec_cmd({
                title = "Apply Oxlint fixes",
                command = "oxc.fixAll",
                arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
              }, { bufnr = bufnr })
            end, { desc = "Oxlint: apply all auto-fixable fixes" }) -- [4](https://deepwiki.com/rmvaldesd/config_files/2.6-git-integration)
          end,
        },

        stylelint_lsp = {
          settings = {
            stylelintplus = {
              autoFixOnSave = true,
              validateOnSave = true,
              validateOnType = true,
            },
          },
        },

        eslint = {
          root_dir = function(...)
            local util = require("lspconfig.util")
            return util.root_pattern(
              ".eslintrc",
              ".eslintrc.js",
              ".eslintrc.cjs",
              ".eslintrc.json",
              ".eslintrc.yaml",
              ".eslintrc.yml",
              "eslint.config.js",
              "eslint.config.mjs",
              "eslint.config.cjs"
            )(...)
          end,
          settings = {
            workingDirectory = { mode = "auto" },
          },
        },

        biome = {
          root_dir = function(...)
            local util = require("lspconfig.util")
            return util.root_pattern("biome.json", "biome.jsonc")(...)
          end,
        },

        cssls = {
          root_dir = function(fname)
            local util = require("lspconfig.util")

            local root = util.root_pattern(".git", "package.json")(fname)
            if not root then
              return nil
            end

            local has_stylelint = util.root_pattern(
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
              ".stylelintrc.mjs"
            )(fname)

            if has_stylelint then
              return nil
            end

            return root
          end,

          settings = {
            css = { validate = false },
            scss = { validate = false },
            less = { validate = false },
          },
        },

        tailwindcss = {
          settings = {
            tailwindCSS = {
              includeLanguages = {
                eelixir = "html-eex",
                elixir = "html-eex",
                eruby = "erb",
                heex = "html-eex",
                htmlangular = "html",
                templ = "html",
                typescriptreact = "javascript",
                javascriptreact = "javascript",
                typescript = "javascript",
                javascript = "javascript",
              },
            },
          },
        },

        ts_ls = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },

        html = {},

        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                groupSeverity = { strong = "Warning", strict = "Warning" },
                unusedLocalExclude = { "_*" },
              },
              format = { enable = true },
            },
          },
        },
      },
    },
  },

  {
    "nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
}
