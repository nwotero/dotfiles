return {
  'LunarVim/breadcrumbs.nvim',
  dependencies = {
    {
      'SmiteshP/nvim-navic',
      config = function()
        require('nvim-navic').setup {
          highlight = true,
          separator = '  ',
          depth_limit = 5,
          depth_limit_indicator = '..',
          icons = {
            File = ' ',
            Module = ' ',
            Namespace = ' ',
            Package = ' ',
            Class = ' ',
            Method = ' ',
            Property = ' ',
            Field = ' ',
            Constructor = ' ',
            Enum = ' ',
            Interface = ' ',
            Function = ' ',
            Variable = ' ',
            Constant = ' ',
            String = ' ',
            Number = ' ',
            Boolean = ' ',
            Array = ' ',
            Object = ' ',
            Key = ' ',
            Null = ' ',
            EnumMember = ' ',
            Struct = ' ',
            Event = ' ',
            Operator = ' ',
            TypeParameter = ' ',
          },
          lsp = {
            auto_attach = true,
            preference = nil,
          },
          click = true,
        }
      end,
    },
  },
  config = function()
    require('breadcrumbs').setup()
  end,
}
