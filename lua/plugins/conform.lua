return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  init = function()
    -- Install the conform formatter on VeryLazy
    LazyVim.on_very_lazy(function()
      LazyVim.format.register({
        name = "conform.nvim",
        priority = 100,
        primary = true,
        format = function(buf)
          require("conform").format({ bufnr = buf })
        end,
        sources = function(buf)
          local ret = require("conform").list_formatters(buf)
          ---@param v conform.FormatterInfo
          return vim.tbl_map(function(v)
            return v.name
          end, ret)
        end,
      })
    end)
  end,
  ---@param _ any
  ---@param opts conform.setupOpts
  opts = function(_, opts)
    -- prettier는 config 파일이 없는 프로젝트에서 실행되지 않도록 설정
    vim.g.lazyvim_prettier_needs_config = true

    -- biome/prettier extras에서 누적된 formatters(require_cwd, condition 등)를 상속하면서
    -- formatters_by_ft를 stop_after_first 포함 사용자 설정으로 override
    -- biome-check: biome format + import sort + safe fixes (biome check --write)
    opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
      javascript        = { "biome-check", "prettier", stop_after_first = true },
      javascriptreact   = { "biome-check", "prettier", stop_after_first = true },
      typescript        = { "biome-check", "prettier", stop_after_first = true },
      typescriptreact   = { "biome-check", "prettier", stop_after_first = true },
      json              = { "biome-check", "prettier", stop_after_first = true },
      jsonc             = { "biome-check", "prettier", stop_after_first = true },
      css               = { "biome-check", "prettier", stop_after_first = true },
      graphql           = { "biome-check", "prettier", stop_after_first = true },
      vue               = { "biome-check", "prettier", stop_after_first = true },
      -- java
      java              = { "google-java-format" },
      -- prettier 전용 filetypes (biome 미지원)
      html              = { "prettier" },
      markdown          = { "prettier" },
      ["markdown.mdx"]  = { "prettier" },
      yaml              = { "prettier" },
      scss              = { "prettier" },
      less              = { "prettier" },
    })

    -- biome-check: biome.json 없는 프로젝트에서는 실행 안 함 → prettier fallback
    opts.formatters = opts.formatters or {}
    opts.formatters.injected = { options = { ignore_errors = true } }
    opts.formatters["biome-check"] = { require_cwd = true }

    -- 파싱 에러 있는 파일 저장 시 에러 알림 억제
    opts.notify_on_error = false

    return opts
  end,
}
