local status, prettier = pcall(require, "prettier")
if (not status) then return end

prettier.setup({
  bin = 'prettier',
  cli_options = {
    trailingComma= "es5",
    tabWidth= 4,
    printWidth= 100,
    semi= false,
    singleQuote= true,
    bracketSameLine= true
  },
  filetypes = {
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "scss",
    "less"
  },
  -- config_precedence = "prefer-file"
})
