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
    config = true,
    -- opts = {
    --   load = {
    --     ["core.defaults"] = {},
    --     ["core.concealer"] = {},
    --     -- ["core.dirman"] = {
    --     --   config = {
    --     --     workspaces = {
    --     --       notes = "~/notes",
    --     --     },
    --     --     default_workspace = "notes",
    --     --   },
    --     -- },
    --   },
    -- },
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
