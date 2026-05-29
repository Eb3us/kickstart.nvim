-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  -- Noice
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    'NachoNievaG/atac.nvim',
    keys = {
      { '<leader>at', '<cmd>Atac<cr>', desc = 'Atac' },
    },
    dependencies = { 'akinsho/toggleterm.nvim' },
    config = function()
      vim.env.ATAC_KEY_BINDINGS = '~/.config/atac/callixto/vim_key_bindings.toml'
      require('atac').setup {
        dir = '~/.config/atac/callixto/', -- By default, the dir will be set as /tmp/atac
      }
    end,
  },
  {
    'Exafunction/windsurf.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    cond = function() return vim.env.CODEIUM == 'enabled' end,
    event = 'BufEnter',
    config = function()
      require('codeium').setup {
        virtual_text = {
          enabled = true,
          key_bindings = {
            accept = '<C-a>',
            accept_word = '<C-w>',
            accept_line = '<C-s>',
          },
        },
      }
    end,
  },
}
