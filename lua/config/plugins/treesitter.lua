return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- tag = 'v0.10.0',
		commit = '23502d650a851599428ca51f418e96960ea68f52',
		config = function ()
			require('nvim-treesitter.parsers').moonbit = {
				install_info = {
					url = "https://github.com/moonbitlang/tree-sitter-moonbit",
					commit = "93355c9084ac7fb1f9d94e0d369ea854e017de8e",
					branch = "main",
					files = { 'src/parser.c', 'src/scanner.c' },
					queries = "queries",
				},
			}

			require('nvim-treesitter').setup {
				ensure_installed = {
					"lua",
					"markdown",
					"typescript",
					"tsx",
					"javascript",
					"go",
					"json",
					"moonbit",
				},
			}
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		tag = 'v1.0.0',
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require('treesitter-context').setup {
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiline_threshold = 6, -- Maximum number of lines to collapse for a single context line
			}
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		commit = 'a0e182ae21fda68c59d1f36c9ed45600aef50311',
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		init = function()
			-- Disable entire built-in ftplugin mappings to avoid conflicts.
			-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
			vim.g.no_plugin_maps = true
		end,
		config = function ()
			require("nvim-treesitter-textobjects").setup {
				select = {
					lookahead = false,
				},
			}
			vim.keymap.set({ "x", "o" }, "af", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "if", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
			end)
		end
	},
}
