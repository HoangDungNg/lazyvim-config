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
    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
      inlay_hints = { enabled = true },

      servers = {

        stylelint_lsp = {
          settings = {
            stylelintplus = {
              autoFixOnSave = true, -- apply stylelint --fix when you save
              validateOnSave = true, -- optional; auto-enabled by autoFixOnSave
              validateOnType = true, -- default true; keep diagnostics live
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

            -- First: find the normal project root
            local root = util.root_pattern(".git", "package.json")(fname)
            if not root then
              return nil
            end

            -- Then: if Stylelint config exists at/above root, disable cssls
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
              return nil -- prevents cssls from starting
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
              workspace = {
                checkThirdParty = false,
              },
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
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = true,
              },
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
