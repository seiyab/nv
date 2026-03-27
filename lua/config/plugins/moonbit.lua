return {
	{
		'moonbit-community/moonbit.nvim',
		commit = '5c7bb920f096b4e210e4c5a4597c43ab1e9a6150',
		ft = { 'moonbit' },
		opts = {
			mooncakes = {
			  virtual_text = true,   -- virtual text showing suggestions
			  use_local = true,      -- recommended, use index under ~/.moon
			},
			-- optionally disable the treesitter integration
			treesitter =  {
				enabled = false,
				auto_install = false,
			},
			-- configure the language server integration
			-- set `lsp = false` to disable the language server integration
			lsp = {
			  -- provide an `on_attach` function to run when the language server starts
			  on_attach = function(client, bufnr) end,
			  -- provide client capabilities to pass to the language server
			  capabilities = vim.lsp.protocol.make_client_capabilities(),
			},
			-- configure jsonls schema integration (enabled by default)
			-- set `jsonls = false` to disable
			jsonls = {
			  -- optional extra jsonls settings to merge
			  settings = {},
			},
		},
	},
	{
		"nvim-neotest/neotest",
		tag = "v5.13.4",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"moonbit-community/moonbit.nvim",
		},
		opts = function(_, opts)
			if not opts.adapters then opts.adapters = {} end
			table.insert(opts.adapters, require("neotest-moonbit"))
		end,
	},
}
