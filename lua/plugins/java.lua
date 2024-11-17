return {
  "nvim-java/nvim-java",
  config = function()
    local lspConfig = require("lspconfig")
    local java = require("java")
    java.setup()
    lspConfig.jdtls.setup({})
  end,
}
