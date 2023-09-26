local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

    -- formatting

    if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
       group = vim.api.nvim_create_augroup("Format", { clear = true }),
       buffer = bufnr,
       callback = function()
            vim.lsp.buf.format()
        end
    })
    end
end

protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(
--   vim.lsp.protocol.make_client_capabilities()
-- )
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


nvim_lsp.tsserver.setup {
    capabilities = capabilities,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
    single_file_support = true
}

nvim_lsp.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

nvim_lsp.tailwindcss.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

nvim_lsp.cssls.setup {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss" },
    single_file_support = true,
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        css = {
            validate = true
        },
        scss = {
            validate = true
        },
    },
}

nvim_lsp.html.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

nvim_lsp.emmet_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    init_options = {
        html = {
            options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ["bem.enabled"] = true,
            },
        },
    }
})

nvim_lsp.prismals.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
nvim_lsp.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

nvim_lsp.dartls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    default_config = {
--         -- cmd = { "dart", analysis_server_snapshot_path(), "--protocol=lsp" };
--         cmd = { "dart", "/opt/homebrew/Cellar/dart-sdk/2.18.5/libexec/bin/snapshots/analysis_server.dart.snapshot",
--             "--client-id my-editor.my-plugin --client-version 1.2", "--protocol=lsp" };
        filetypes = { "dart" };
        root_dir = nvim_lsp.util.root_pattern("pubspec.yaml");
        init_options = {
            onlyAnalyzeProjectsWithOpenFiles = "false",
            suggestFromUnimportedLibraries = "true",
            closingLabels = "true",
            outline = "true",
            fluttreOutline = "false"
        };
    };
    docs = {
        vscode = "Dart-Code.dart-code";
        description = [[
            https://github.com/dart-lang/sdk/tree/master/pkg/analysis_server/tool/lsp_spec
            Language server for dart.
        ]];
        default_config = {
            root_dir = [[root_pattern("pubspec.yaml")]];
        };
    };
})


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
}
)

local configs = require 'lspconfig.configs'

if not configs.ls_emmet then
    configs.ls_emmet = {
        default_config = {
            cmd = { 'ls_emmet', '--stdio' },
            filetypes = {
                'html',
                'css',
                'scss',
                'javascriptreact',
                'typescriptreact',
                'javascript',
                'typescript',
                'haml',
                'xml',
                'xsl',
                'pug',
                'slim',
                'sass',
                'stylus',
                'less',
                'sss',
                'hbs',
                'handlebars',
                'dart',
            },
            root_dir = function(fname)
                return vim.loop.cwd()
            end,
            settings = {},
        },
    }
    nvim_lsp.ls_emmet.setup { capabilities = capabilities }
end
-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


vim.diagnostic.config({
    virtual_text = {
        prefix = '●'
    },
    update_in_insert = true,
    float = {
        source = "always", -- Or "if_many"
    },
})
