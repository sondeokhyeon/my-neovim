return {
	-- tools
	"mason-org/mason.nvim",
	"mason-org/mason-lspconfig.nvim",
	-- { "mason-org/mason.nvim", version = "0.11.0" },
	-- { "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
	-- { "mason-org/mason.nvim", version = "^1.0.0" },
	-- { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
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
				emmet_language_server = {},
				-- emmet ls
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
				-- kotlin_language_server = {
				--   cmd = { "kotlin-language-server", "--stdio" },
				--   filetypes = { "kotlin" },
				-- },
			}, -- servers
		}, -- opts
	},
}
