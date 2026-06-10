---@module 'lazy'
---@type LazySpec
return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        float_opts = { height = 28 },
      }
      -- Config
      local Terminal = require('toggleterm.terminal').Terminal
      local dir = vim.fs.root(0, { 'package.json', '.git', '.gitignore' }) or vim.fn.getcwd()
      local cmd = '<cmd>'
      local tT = 'ToggleTerm'
      local direction = 'direction='
      local firstSegment = cmd .. tT .. ' ' .. direction
      local dirSeg = 'dir=' .. dir
      local lastSegment = dirSeg .. '<cr>'
      local float = firstSegment .. 'float' .. ' ' .. lastSegment
      local horizontal = firstSegment .. 'horizontal' .. ' ' .. lastSegment
      local vertical = firstSegment .. 'vertical' .. ' ' .. 'size=80' .. ' ' .. lastSegment
      local count = 1
      local function new_term()
        local command = count .. tT .. ' ' .. direction .. 'float' .. ' ' .. dirSeg
        count = count + 1
        vim.cmd(command)
      end
      --Keymaps
      vim.keymap.set('n', '<leader>tf', float, { desc = 'Floating terminal' })
      vim.keymap.set('n', '<leader>tt', horizontal, { desc = 'Horizontal terminal' })
      vim.keymap.set('n', '<leader>tv', vertical, { desc = 'Vertical terminal' })
      vim.keymap.set('n', '<leader>tn', new_term, { desc = 'New Terminal' })
      vim.keymap.set('n', '<leader>ts', '<cmd>TermSelect<CR>', { desc = 'Select terminal' })

      --Custom terminal configs
      -- Lazygit
      local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }
      function _lazygit_toggle() lazygit:toggle() end
      vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>lua _lazygit_toggle()<CR>', {
        noremap = true,
        silent = true,
        desc = '[L]azy[G]it',
      })

      -- Gemini
      local gemini =
        Terminal:new { cmd = 'gemini', hidden = true, direction = 'float', highlights = { NormalFloat = { link = 'Normal' } }, shade_terminals = false }
      function _gemini_toggle() gemini:toggle() end
      vim.keymap.set('n', '<leader>aig', '<cmd>lua _gemini_toggle()<CR>', { noremap = true, silent = true, desc = '[G]emini' })

      -- Antigravity
      local antigravity = Terminal:new { cmd = 'agy', hidden = true, direction = 'float' }
      function _antigravity_toggle() antigravity:toggle() end
      vim.keymap.set('n', '<leader>aia', '<cmd>lua _antigravity_toggle()<CR>', { noremap = true, silent = true, desc = '[A]ntigravity' })

      -- Opencode
      local opencode = Terminal:new { cmd = 'opencode', hidden = true, direction = 'float' }
      function _opencode_toggle() opencode:toggle() end
      vim.keymap.set('n', '<leader>aio', '<cmd>lua _opencode_toggle()<CR>', { noremap = true, silent = true, desc = '[O]pencode' })

      -- Opencode general
      local opencode_chat = Terminal:new { cmd = 'opencode', hidden = true, direction = 'float', dir = '~/.opencode-chats' }
      function _opencode_chat_toggle() opencode_chat:toggle() end
      vim.keymap.set('n', '<leader>aic', '<cmd>lua _opencode_chat_toggle()<CR>', { noremap = true, silent = true, desc = '[Chat] (opencode)' })

      -- Opencode nvim
      local opencode_nvim = Terminal:new { cmd = 'opencode', hidden = true, direction = 'float', dir = '~/.config/nvim' }
      function _opencode_nvim_toggle() opencode_nvim:toggle() end
      vim.keymap.set('n', '<leader>ain', '<cmd>lua _opencode_nvim_toggle()<CR>', { noremap = true, silent = true, desc = '[N]vim (opencode)' })

      -- Atac
      local atac_callixto = Terminal:new {
        cmd = 'atac -d ~/.config/atac/callixto',
        hidden = true,
        direction = 'float',
        env = { ATAC_KEY_BINDINGS = '~/.config/atac/callixto/vim_key_bindings.toml' },
      }
      local cwd = vim.uv.cwd() or vim.fn.getcwd() or ''
      if cwd:find('callixto-api', 1, true) then
        function _atac_toggle() atac_callixto:toggle() end
        vim.keymap.set('n', '<leader>at', '<cmd>lua _atac_toggle()<CR>', { noremap = true, silent = true, desc = 'Atac' })
      end
    end,
  },
}
