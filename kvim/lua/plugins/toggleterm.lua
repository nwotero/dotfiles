return {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<c-t>]],
        direction = 'float',
        winbar = {
          enabled = true,
          name_formatter = function(term) --  term: Terminal
            return term.name
          end,
        },
      }
      vim.keymap.set('n', '<leader>sT', ':TermSelect<CR>', { desc = '[S]earch [T]erminals', noremap = true, silent = true })
    end,
  },
}
