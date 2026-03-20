return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      local spring_boot_ok, spring_boot = pcall(require, "spring_boot")
      if not spring_boot_ok then
        return opts
      end
      local spring_jars = spring_boot.java_extensions()
      -- opts.jdtls를 함수로 설정하여 기존 config(DAP/test bundles 포함)에 spring-boot JAR 추가
      local orig_jdtls = opts.jdtls
      opts.jdtls = function(config)
        if orig_jdtls then
          if type(orig_jdtls) == "function" then
            config = orig_jdtls(config) or config
          else
            config = vim.tbl_deep_extend("force", config, orig_jdtls)
          end
        end
        local bundles = config.init_options and config.init_options.bundles or {}
        vim.list_extend(bundles, spring_jars)
        config.init_options = config.init_options or {}
        config.init_options.bundles = bundles
        return config
      end
      return opts
    end,
  },
}
