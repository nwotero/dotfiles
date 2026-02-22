return {
  'smoka7/hop.nvim',
  version = '*',
  config = function()
    local hop = require 'hop'
    hop.setup {
      keys = 'aoeuidhtnspyfgcrjkbmw',
      uppercase_labels = true,
    }
    vim.keymap.set({ 'n', 'v' }, 'W', hop.hint_words, {})
  end,
}
