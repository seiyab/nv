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
				vim.keymap.set("n", "<leader>gp", "<Cmd>Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" }),
				vim.keymap.set("n", "]g", "<Cmd>Gitsigns nav_hunk next<CR>"),
				vim.keymap.set("n", "[g", "<Cmd>Gitsigns nav_hunk prev<CR>"),
			})
		end,
	},
}
