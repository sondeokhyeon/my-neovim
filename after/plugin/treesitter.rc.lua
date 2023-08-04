local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = true,
        disable = {},
    },
    ensure_installed = {
        "toml",
        "json",
        "yaml",
        "swift",
        "css",
        "html",
        "typescript",
        "javascript",
        "tsx",
        "lua",
        "svelte",
        "dart",
        "markdown",
        "markdown_inline",
        "dot",
    },
    autotag = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
        config = {
            javascript = {
                jsx_element = '{/* %s */}',
                jsx_fragment = '{/* %s */}',
                jsx_attribute = '// %s',
                comment = '// %s',
            },
            typescript = {
                tsx_element = '{/* %s */}',
                tsx_fragment = '{/* %s */}',
                tsx_attribute = '// %s',
                comment = '// %s',
            },
        }
    },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
