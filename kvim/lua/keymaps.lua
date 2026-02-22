-- Setup WhichKey groups.
local wk = require 'which-key'
wk.add {
  { '<leader>c', group = '[C]opilot' },
  { '<leader>d', group = '[D]ebug' },
  { '<leader>l', group = '[L]sp' },
  { '<leader>q', group = '[Q]uickfix' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>u', group = '[U]ser Interface' },
}

-- Utility function to help with normal mode keymaps.
local nmap = function(keys, cmd, desc)
  vim.keymap.set('n', keys, cmd, { desc = desc })
end

-- Clear highlights on search when pressing <Esc> in normal mode
nmap('<Esc>', '<cmd>nohlsearch<CR>')
nmap('<C-c>', '<cmd>nohlsearch<CR>')

-- Quickfix keymaps
local toggle_qfl = function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and 'cclose' or 'copen'
  vim.cmd('botright ' .. action)
end
nmap('<leader>qq', toggle_qfl, 'Toggle [Q]uickfix list')
nmap('<leader>qn', '<cmd>cnext<CR>', '[N]ext Quickfix list item')
nmap('<leader>qp', '<cmd>cprev<CR>', '[P]revious Quickfix list item')
nmap('<leader>qd', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')

-- Exit terminal mode in the builtin terminal.
-- -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
nmap('<C-h>', '<C-w><C-h>', 'Move focus to the left window')
nmap('<C-l>', '<C-w><C-l>', 'Move focus to the right window')
nmap('<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
nmap('<C-k>', '<C-w><C-k>', 'Move focus to the upper window')

-- File tree keymaps.
nmap('-', '<cmd>Oil<CR>', 'Open Oil File Explorer')
nmap('<C-s>', '<cmd>update<CR>', 'Save Buffer')

-- Toggle LSP diagnostic lines for the current line and for the whole buffer.
nmap('<leader>ul', function()
  local current_config = vim.diagnostic.config()
  if current_config ~= nil and current_config.virtual_lines == true then
    vim.diagnostic.config {
      virtual_lines = {
        current_line = true,
      },
    }
  else
    vim.diagnostic.config { virtual_lines = true }
  end
end, 'Toggle LSP Lines')

-- Toggle line numbers.
nmap('<leader>un', function()
  if vim.wo.number then
    vim.wo.number = false
    vim.wo.relativenumber = false
  else
    vim.wo.number = true
  end
end, 'Toggle Line Numbers')
