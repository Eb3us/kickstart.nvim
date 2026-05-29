---@module 'lazy'
---@type LazySpec
return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {}
      -- Config
      local Terminal = require('toggleterm.terminal').Terminal
      local dir = vim.fs.root(0, { 'package.json', '.git', '.gitignore' }) or vim.fn.getcwd()
      local cmd = '<cmd>'
      local tT = 'ToggleTerm'
      local direction = 'direction='
      local firstSegment = cmd .. tT .. ' ' .. direction
      local dirSeg = 'dir=' .. dir
      local lastSegment = dirSeg .. '<cr>'
      local float = firstSegment .. 'float ' .. lastSegment
      local horizontal = firstSegment .. 'horizontal' .. ' ' .. lastSegment
      local vertical = firstSegment .. 'vertical' .. ' ' .. 'size=80 ' .. lastSegment
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

      vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true, desc = 'LazyGit' })
    end,
  },
}
