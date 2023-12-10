return {
  {
    enabled = false,
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {
      search = {
        forward = true,
        multi_window = false,
        wrap = false,
        incremental = true,
      },
    },
  },
  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
    },
  },
  {
    "kessejones/git-blame-line.nvim",
    opts = {
      git = {
        default_message = "Not committed yet",
        blame_format = "%an - %ar - %s", -- see https://git-scm.com/docs/pretty-formats
      },
      view = {
        left_padding_size = 5,
        enable_cursor_hold = false,
      },
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    opts = {
      "*",
    },
  },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  },
}
