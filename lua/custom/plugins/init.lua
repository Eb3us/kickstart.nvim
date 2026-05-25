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
  -- Lazygit
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
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
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {}
      local Terminal = require('toggleterm.terminal').Terminal
      -- get root directory of the current buffer
      local dir = vim.fs.root(0, { 'package.json', '.git', '.gitignore' }) or vim.fn.getcwd()
      local cmdStart = '<cmd>ToggleTerm direction='
      local float = cmdStart .. 'float ' .. 'dir=' .. dir .. '<cr>'
      local horizontal = cmdStart .. 'horizontal ' .. 'dir=' .. dir .. '<cr>'
      local vertical = cmdStart .. 'vertical ' .. 'dir=' .. dir .. ' size=80<cr>'
      --Keymaps
      vim.keymap.set('n', '<leader>tf', float, { desc = 'ToggleTerm' })
      vim.keymap.set('n', '<leader>tt', horizontal, { desc = 'ToggleTerm' })
      vim.keymap.set('n', '<leader>tv', vertical, { desc = 'ToggleTerm' })
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
