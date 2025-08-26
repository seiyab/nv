return {
	{
		'github/copilot.vim',
		tag = 'v1.53.0',
		lazy = false,
		config = function()
			vim.g.copilot_no_tab_map = true

			vim.keymap.set('n', '<Leader>cp', '<cmd>Copilot panel<cr>', { desc = '[C]opilot [P]anel' })
			vim.keymap.set('i', '<C-\\>cp', '<cmd>Copilot panel<cr>', { desc = '[C]opilot [P]anel' })
			vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
				desc = 'Copilot Accept',
				expr = true,
				replace_keycodes = false,
			})
		end,
		-- keys = {
			-- {
			-- 	'<Leader>cp',
			-- 	'<cmd>Copilot panel<cr>',
			-- 	desc = '[C]opilot [P]anel',
			-- 	mode = { 'n' },
			-- },
			-- {
			-- 	'<C-\\>cp',
			-- 	'<cmd>Copilot panel<cr>',
			-- 	desc = '[C]opilot [P]anel',
			-- 	mode = { 'i' },
			-- },
			-- {
			-- 	'<C-j>',
			-- 	'copilot#Accept("\\<CR>")',
			-- 	desc = 'Copilot Accept',
			-- 	mode = { 'i' },
			-- 	expr = true,
			-- 	replace_keycodes = false,
			-- },
		-- },
	},
}
