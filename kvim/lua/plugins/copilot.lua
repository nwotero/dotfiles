return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    config = function()
      require('CopilotChat').setup {
        chat = {
          keymaps = {
            close = '<C-c>',
          },
        },
        window = {
          layout = 'float',
          width = 0.8,
          height = 0.8,
          border = 'rounded',
        },
        auto_insert_mode = true,
      }
      vim.keymap.set({ 'n', 'v' }, '<leader>cc', '<cmd>CopilotChat<cr>', { desc = '[C]opilot [C]hat' })
      vim.keymap.set({ 'n', 'v' }, '<leader>cd', '<cmd>CopilotChat Docs<cr>', { desc = '[C]opilot Add [D]ocs' })
      vim.keymap.set({ 'n', 'v' }, '<leader>ce', '<cmd>CopilotChat Explain<cr>', { desc = '[C]opilot [E]xplain' })
      vim.keymap.set({ 'n', 'v' }, '<leader>cf', '<cmd>CopilotChat Fix<cr>', { desc = '[C]opilot [F]ix' })
      vim.keymap.set({ 'n', 'v' }, '<leader>co', '<cmd>CopilotChat Optimize<cr>', { desc = '[C]opilot [O]ptimize' })
      vim.keymap.set({ 'n', 'v' }, '<leader>cr', '<cmd>CopilotChat Review<cr>', { desc = '[C]opilot [R]eview' })
      vim.keymap.set({ 'n', 'v' }, '<leader>ct', '<cmd>CopilotChat Tests<cr>', { desc = '[C]opilot Add [T]ests' })
    end,
  },
}
