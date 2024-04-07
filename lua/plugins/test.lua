return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "thenbe/neotest-playwright",
      "adrigzr/neotest-mocha",
    },
    keys = {
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last Test",
      },
      {
        "<leader>tL",
        function()
          require("neotest").run.run_last({ strategy = "dap" })
        end,
        desc = "Debug Last Test",
      },
      {
        "<leader>tw",
        "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
        desc = "Run Watch",
      },
    },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        })
      )
      table.insert(opts.adapters, require("neotest-vitest"))
      table.insert(
        opts.adapters,
        require("neotest-playwright").adapter({
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
          },
        })
      )
      table.insert(
        opts.adapters,
        require("neotest-mocha")({
          command = "npm test --",
          command_args = function(context)
            return {
              -- "--full-trace",
              -- "--reporter=json",
              -- "--reporter-options=output=" .. context.results_path,
              "--grep=" .. context.test_name_pattern,
              context.path,
            }
          end,
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        })
      )
    end,
  },
}
