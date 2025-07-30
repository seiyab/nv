-- https://lazy.folke.io/installation

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    {
      'nvim-telescope/telescope.nvim',
      event = 'VimEnter',
      tag = '0.1.8',
    },
    { 'neoclide/coc.nvim', branch = 'release' },
    { 'tpope/vim-surround', tag = 'v2.2' },
    {
      'stevearc/oil.nvim',
      tag = 'v2.15.0',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      dependencies = { "nvim-tree/nvim-web-devicons", tag = 'v0.100' },
      lazy = false, -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
