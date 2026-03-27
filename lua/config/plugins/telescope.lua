local M = {}

function M.commits()
	local builtin = require("telescope.builtin")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	builtin.git_commits({
		prompt_title = "Recent commits → changed files to quickfix",

		attach_mappings = function(prompt_bufnr, map)
			local function to_qflist()
				local entry = action_state.get_selected_entry()
				if not entry then
					return
				end

				-- git_commits entries normally keep the commit hash as `value`
				-- and display one-line commit text in `ordinal` / `display`.
				local sha = entry.value
				if type(sha) ~= "string" or sha == "" then
					vim.notify("Could not read commit hash from Telescope entry", vim.log.levels.ERROR)
					return
				end

				-- Find repo root for stable paths
				local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
				if vim.v.shell_error ~= 0 or not root or root == "" then
					vim.notify("Not inside a git repository", vim.log.levels.ERROR)
					return
				end

				-- List files changed by the selected commit.
				-- For merge commits, -m makes Git report per-parent diffs too.
				local files = vim.fn.systemlist({
					"git",
					"-C",
					root,
					"diff-tree",
					"--no-commit-id",
					"--name-only",
					"-r",
					"-m",
					sha,
				})

				if vim.v.shell_error ~= 0 then
					vim.notify("Failed to get changed files for commit " .. sha, vim.log.levels.ERROR)
					return
				end

				local items = {}
				for _, file in ipairs(files) do
					if file ~= "" then
						table.insert(items, {
							filename = root .. "/" .. file,
							lnum = 1,
							col = 1,
							text = sha,
						})
					end
				end

				actions.close(prompt_bufnr)

				vim.fn.setqflist({}, " ", {
					title = "Changed files: " .. sha,
					items = items,
				})

				vim.cmd("copen")
			end

			-- Keep prompt focus initially; Esc/C-[ switches to list (normal mode)
			map("i", "<Esc>", function()
				vim.cmd("stopinsert")
			end)
			map("i", "<C-[>", function()
				vim.cmd("stopinsert")
			end)

			-- Enter sends changed files to quickfix instead of checkout
			map("i", "<CR>", to_qflist)
			map("n", "<CR>", to_qflist)

			return true
		end,
	})
end

return {
	'nvim-telescope/telescope.nvim',
	event = 'VimEnter',
	tag = 'v0.2.0',
	config = function ()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope diagnostics' })
		vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Telescope marks' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		vim.keymap.set("n", "<leader>gc", M.commits, { desc = "Commits → changed files to qflist" })
	end
}
