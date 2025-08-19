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
	require("config.gitsigns"),
    {
      'nvim-telescope/telescope.nvim',
      event = 'VimEnter',
      tag = '0.1.8',
    },
	require("config.lsp"),
	require("config.blink-cmp"),
    { 'tpope/vim-surround', tag = 'v2.2' },
    {
      'stevearc/oil.nvim',
      tag = 'v2.15.0',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      lazy = false, -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    },
	{
		'juacker/git-link.nvim',
		commit = '3022840bff0ce5e0f22ed62dc45e2c5273bb34a4',
		keys = {
			{
				"<leader>cl",
				function() require("git-link.main").copy_line_url() end,
				desc = "[C]opy code [l]ink to clipboard",
				mode = { "n", "x" }
			},
		},
	},
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
