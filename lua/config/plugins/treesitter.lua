return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		tag = 'v0.10.0',
		config = function ()
			require('nvim-treesitter.configs').setup {
				ensure_installed = { "lua", "markdown", "typescript", "go", "json" },
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
		commit = '71385f191ec06ffc60e80e6b0c9a9d5daed4824c',
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function ()
			require('nvim-treesitter.configs').setup {
				textobjects = {
					select = {
						enable = true,
						lookahead = false,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
						},
					},
				},
			}
		end
	},
}
