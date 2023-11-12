local status, prettier = pcall(require, "prettier")
if (not status) then return end

prettier.setup({
    bin = 'prettier',
    cli_options = {
        endofline = 'lf',
        trailingComma = "es5",
        tabWidth = 4,
        printWidth = 100,
        semi = false,
        singleQuote = true,
        bracketSameLine = true,
        arrowParens = 'always',
        htmlWhitespaceSensitivity = 'css',
        proseWrap = 'preserve',
        quoteProps = 'as-needed',
        useTabs = false,
        bracketSpacing = true,
        singleAttributePerLine = false,
        jsxSingleQuote = false
    },
    filetypes = {
        "css",
        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "scss",
        "less",
    },
    config_precedence = "prefer-file"
})
