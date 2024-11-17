return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript",
        "css-lsp",
        "tsx",
        "typescript",
        "vim",
      },
    },

    -- lsp servers
    {
      "neovim/nvim-lspconfig",
      ---@class PluginLspOpts
      -- dependencies = {
      --   "mfussenegger/nvim-jdtls", -- or nvim-java, nvim-lspconfig
      -- },
      -- config = function()
      -- local lspConfig = require("lspconfig")
      -- local java = require("java")
      -- java.setup()
      -- lspConfig.jdtls.setup({})
      -- end,
      opts = {
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
          },
          severity_sort = true,
        },
        inlay_hints = {
          enabled = true,
        },
        -- add any global capabilities here
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        -- LSP Server Settings
        servers = {
          lua_ls = {
            -- keys = {},
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          },
          -- lua_ls
          cssls = {},
          -- cssls
          tailwindcss = {
            root_dir = function(...)
              return require("lspconfig.util").root_pattern(".git")(...)
            end,
          },
          --tailwindcss
          tsserver = {
            root_dir = function(...)
              return require("lspconfig.util").root_pattern(".git")(...)
            end,
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
            },
            -- cmd = { "typescript-language-server", "--stdio" },
            init_options = {
              preferences = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
                importModuleSpecifierPreference = "non-relative",
              },
            },
            single_file_support = true,
          },
          -- tsserver
          html = {},
          -- html
          emmet_ls = {
            filetypes = {
              "html",
              "javascript",
              "typescript",
              "typescriptreact",
              "javascriptreact",
              "css",
              "sass",
              "scss",
              "less",
            },
            init_options = {
              html = {
                options = {
                  -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                  ["bem.enabled"] = true,
                },
              },
            },
          },
          -- emmet_ls
          yamlls = {
            settings = {
              yaml = {
                schemas = {
                  ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
                  ["https://json.schemastore.org/ansible-stable-2.9.json"] = "/*.ansible.yaml",
                  ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                  -- schemas = {
                  --   kubernetes = "/*.k8s.yaml",
                  --   ansible = "/*.ansible.yaml",
                  --   github = "/.github/workflows/*",
                  -- },
                },
              },
            },
          },
          -- yamlls
          docker_compose_language_service = {
            cmd = { "docker-compose-language-server", "--stdio" },
            filetypes = { "yaml.docker-compose" },
            root_pattern = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },
            single_file_support = true,
          },
          -- docker_compose_language_service
          dockerls = {
            cmd = { "docker-langserver", "--stdio" },
            filetypes = { "dockerfile" },
            root_pattern = { "Dockerfile" },
            single_file_support = true,
          },
          -- dockerls end
          kotlin_language_server = {
            cmd = { "kotlin-language-server", "--stdio" },
            filetypes = { "kotlin" },
          },
        }, -- servers
      }, -- opts
    },
  },
}
