
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "css",
  "dockerfile",
  "go",
  "haskell",
  "java",
  "javascript",
  "json",
  "kotlin",
  "lua",
  "make",
  "markdown",
  "python",
  "rust",
  "toml",
  "tsx",
  "typescript",
  "verilog",
  -- "vhdl",
  "vim",
  "yaml",
}

-- Treesitter Text Objects
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@block.outer",
        ["ia"] = "@block.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["aS"] = "@statement.inner",
      },
    },
  },
}
