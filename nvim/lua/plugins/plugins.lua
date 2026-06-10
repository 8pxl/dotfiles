--luacheck: globals Difft
return {
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
      -- include a picker of your choice, see picker section for more details
      "nvim-lua/plenary.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      ---@type lc.lang
      lang = "python",
    },
  },
  {
    "dhruvasagar/vim-table-mode",
  },
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "nvim-neorg/neorg",
    lazy = false,
    -- dependencies = { "nvim-lua/plenary.nvim" },
    -- version = "false",
    version = "*",
    dependencies = {
      -- Work around a lazy.nvim load-order/runtimepath issue where Neorg
      -- can't see the compiled parsers from the luarocks install.
      "nvim-neorg/tree-sitter-norg",
      "nvim-neorg/tree-sitter-norg-meta",
    },
    init = function()
      local data = vim.fn.stdpath("data")

      local function maybe_prepend(dir)
        if (vim.uv or vim.loop).fs_stat(dir) then
          vim.opt.rtp:prepend(dir)
        end
      end

      -- Make `parser/norg(.so)` discoverable via runtimepath.
      maybe_prepend(data .. "/lazy-rocks/tree-sitter-norg/lib/lua/5.1")
      maybe_prepend(data .. "/lazy-rocks/tree-sitter-norg-meta/lib/lua/5.1")
    end,
    config = true,
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.keybinds"] = {},
        ["core.highlights"] = {
          config = {
            highlights = {
              links = {
                file = {
                  [""] = "+@markup.link.url",
                },
                description = {
                  [""] = "+@markup.link.url",
                },
                location = {
                  generic = {
                    [""] = "+@markup.link.url",
                    prefix = "+@markup.link.url",
                  },
                },
              },
            },
          },
        },
      },
    },
    keys = {
      { "<leader>N", "<Plug>(neorg.dirman.new-note)", desc = "Neorg: New Note", ft = "norg" },
      { "<C-a>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", desc = "Neorg: Toggle Todo", ft = "norg" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
    -- config = function()
    --     require("nvim-surround").setup({
    --         -- Put your configuration here
    --     })
    -- end
  },

  { "akinsho/git-conflict.nvim", version = "*", config = true },
  -- {
  --   "ahkohd/difft.nvim",
  --   keys = {
  --     {
  --       "<leader>d",
  --       function()
  --         if Difft.is_visible() then
  --           Difft.hide()
  --         else
  --           Difft.diff()
  --         end
  --       end,
  --       desc = "Toggle Difft",
  --     },
  --   },
  --   config = function()
  --     require("difft").setup({
  --       command = "jj diff --no-pager", -- or "GIT_EXTERNAL_DIFF='difft --color=always' git diff"
  --       layout = "float", -- nil (buffer), "float", or "ivy_taller"
  --     })
  --   end,
  -- },
}
