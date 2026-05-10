-- Discover JDKs installed by mise and turn them into JDTLS runtimes.
-- New JDKs picked up automatically on next nvim restart.
local function discover_runtimes()
  local mise_java = vim.fn.expand("~/.local/share/mise/installs/java")
  local entries = {}
  local handle = (vim.uv or vim.loop).fs_scandir(mise_java)
  if not handle then
    return {}
  end
  while true do
    local name, ftype = (vim.uv or vim.loop).fs_scandir_next(handle)
    if not name then
      break
    end
    -- Skip mise's symlinks ('latest', '26', '26.0'); keep real install dirs.
    if ftype == "directory" then
      local major = tonumber(name:match("^(%d+)"))
      if major then
        local home = mise_java .. "/" .. name
        if vim.fn.isdirectory(home .. "/Contents/Home") == 1 then
          home = home .. "/Contents/Home"
        end
        table.insert(entries, { major = major, path = home })
      end
    end
  end
  table.sort(entries, function(a, b)
    return a.major < b.major
  end)
  local runtimes = {}
  for i, e in ipairs(entries) do
    local rt = {
      name = (e.major == 8) and "JavaSE-1.8" or ("JavaSE-" .. e.major),
      path = e.path,
    }
    if i == #entries then
      rt.default = true
    end
    table.insert(runtimes, rt)
  end
  return runtimes
end

return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          configuration = {
            runtimes = discover_runtimes(),
          },
        },
      })

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
