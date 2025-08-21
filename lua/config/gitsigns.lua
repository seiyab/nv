return {
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		tag = "v1.0.2",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
		config = function()
			require("gitsigns").setup({
				on_attach = function()
					local gitsigns = require("gitsigns")
					vim.keymap.set('n', ']c', function()
						if vim.wo.diff then
							vim.cmd.normal({']c', bang = true})
						else
							gitsigns.nav_hunk('next')
						end
					end)
					vim.keymap.set('n', '[c', function()
						if vim.wo.diff then
							vim.cmd.normal({'[c', bang = true})
						else
							gitsigns.nav_hunk('prev')
						end
					end)
				end
			})
		end,
		on_attach = function()
		end,
	},
}
