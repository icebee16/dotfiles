return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- Provider設定（ChatGPT / OpenAI）
    provider = "openai",
    providers = {
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        api_key = os.getenv("OPENAI_API_KEY"),
        extra_request_body = {
          temperature = 0.75,
          max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
          --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        },
      },
    },

    -- 出力/UI挙動の調整
    buffer_reuse = true, -- avoid redundant buffer creation
    output_mode = "replace",
    snacks = {
      echo = false,      -- suppress echo-line duplication
      history = {
        enabled = false, -- avoid reprinting history
      },
    },
    hints = { enabled = false },

    -- UIウィンドウ挙動の最適化（バッファの再利用/冗長抑制の狙い）
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = true,
      support_paste_from_clipboard = true,
      minimize_diff = true,
    },

    windows = {
      position = "right",
      wrap = true,
      width = 30,
      ask = {
        floating = false,
        start_insert = true,
        border = "rounded",
        focus_on_apply = "ours",
      },
    },
    system_prompt = "返答は必ず日本語で行ってください。",
    rules = {
      project_dir = ".avante/rules",
      global_dir = "~/.config/avante/rules"
    }
  },

  config = function(_, opts)
    require("avante").setup(opts)
  end,

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    -- "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    -- "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = {
          -- "markdown",
          "Avante"
        },
      },
      ft = {
        -- "markdown",
        "Avante"
      },
    },
  },
}
