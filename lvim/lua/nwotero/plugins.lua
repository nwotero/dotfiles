-- Additional Plugins
lvim.plugins = {
  {
    "rcarriga/nvim-dap-ui",
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "easymotion/vim-easymotion",
  },
  {
    "ptzz/lf.vim",
  },
  {
    "voldikss/vim-floaterm",
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup{
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      } end
  },
  {
    "nvim-telescope/telescope-project.nvim",
    event = "BufWinEnter",
    setup = function()
      vim.cmd [[packadd telescope.nvim]]
    end,
  },
  {
    "ahmedkhalf/lsp-rooter.nvim",
    event = "BufRead",
    config = function()
      require("lsp-rooter").setup()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require "lsp_signature".setup()
    end
  },
  -- {
  --   "monaqa/dial.nvim",
  --   event = "BufRead",
  --   config = function()
  --     local dial = require "dial"
  --     vim.cmd [[
  --     nmap <C-a> <Plug>(dial-increment)
  --       nmap <C-x> <Plug>(dial-decrement)
  --       vmap <C-a> <Plug>(dial-increment)
  --       vmap <C-x> <Plug>(dial-decrement)
  --       vmap g<C-a> <Plug>(dial-increment-additional)
  --       vmap g<C-x> <Plug>(dial-decrement-additional)
  --     ]]

  --     dial.augends["custom#boolean"] = dial.common.enum_cyclic {
  --       name = "boolean",
  --       strlist = { "true", "false" },
  --     }
  --     table.insert(dial.config.searchlist.normal, "custom#boolean")

  --     -- For Languages which prefer True/False, e.g. python.
  --     dial.augends["custom#Boolean"] = dial.common.enum_cyclic {
  --       name = "Boolean",
  --       strlist = { "True", "False" },
  --     }
  --     table.insert(dial.config.searchlist.normal, "custom#Boolean")
  --   end,
  -- },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
      vim.g.indent_blankline_buftype_exclude = {"terminal"}
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = false
    end
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
    require('neoscroll').setup({
          -- All these keys will be mapped to their corresponding default scrolling animation
          mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
          hide_cursor = true,          -- Hide cursor while scrolling
          stop_eof = true,             -- Stop at <EOF> when scrolling downwards
          use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
          respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
          cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
          easing_function = nil,        -- Default easing function
          pre_hook = nil,              -- Function to run before the scrolling animation starts
          post_hook = nil,              -- Function to run after the scrolling animation ends
          })
    end
  },
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit", "gitrebase", "svn", "hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
  {
    "folke/persistence.nvim",
      event = "BufReadPre", -- this will only start session saving when an actual file was opened
      module = "persistence",
      config = function()
        require("persistence").setup {
          dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
          options = { "buffers", "curdir", "tabpages", "winsize" },
        }
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  { "tpope/vim-repeat" },
  {
    "tpope/vim-surround",
    keys = {"c", "d", "y"}
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects"
  },
  {
    "stevearc/dressing.nvim"
  },
  {
    "mfussenegger/nvim-dap"
  },
  {
    "Pocco81/dap-buddy.nvim"
  }
}
