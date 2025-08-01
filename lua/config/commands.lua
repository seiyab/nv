local function close_hidden_buffers()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf)
			and vim.fn.buflisted(buf) == 1
			and vim.api.nvim_buf_get_option(buf, "modified") == false
			and #vim.fn.win_findbuf(buf) == 0 then
				vim.api.nvim_buf_delete(buf, {})
		end
	end
end
vim.api.nvim_create_user_command("CloseHiddenBuffers", close_hidden_buffers, {})

local function copy_permanent_url()
 vim.api.nvim_exec2("CocCommand git.copyPermalink", {}) 
end
vim.api.nvim_create_user_command("CopyPermanentUrl", copy_permanent_url, {})

vim.api.nvim_create_user_command("CopyRelativePath", function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

