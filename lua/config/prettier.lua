local function find_package_root()
	local root = vim.fs.find("package.json", { upward = true, stop = vim.loop.os_homedir() })[1]
	return root and vim.fs.dirname(root) or nil
end

local function get_package_manager(pkg_root)
	if vim.fn.filereadable(pkg_root .. "/pnpm-lock.yaml") == 1 then
		return "pnpm"
	elseif vim.fn.filereadable(pkg_root .. "/yarn.lock") == 1 then
		return "yarn"
	elseif vim.fn.filereadable(pkg_root .. "/package-lock.json") == 1 then
		return "npm"
	else
		return nil
	end
end

local function formatter_cmd_in_project(pkg_root, formatter_name, formatter_cmd)
	-- Prefer local node_modules
	local bin_dir = pkg_root .. "/node_modules/.bin/"
	local local_bin = bin_dir .. formatter_name
	if vim.fn.executable(local_bin) == 1 then
		return bin_dir .. formatter_cmd
	end

	-- Use package manager command if available
	local manager = get_package_manager(pkg_root)
	local check_cmd = ({
		yarn = "yarn " .. formatter_name .. " --version",
		pnpm = "pnpm " .. formatter_name .. " --version",
		npm = "npx " .. formatter_name .. " --version",
	})[manager]

	if check_cmd then
		local ok = os.execute("cd " .. pkg_root .. " && " .. check_cmd .. " >/dev/null 2>&1")
		if ok == true or ok == 0 then
			return ({
				yarn = "yarn " .. formatter_cmd,
				pnpm = "pnpm " .. formatter_cmd,
				npm = "npx " .. formatter_cmd,
			})[manager]
		end
	end

	return nil
end

local function format()
	local bufname = vim.api.nvim_buf_get_name(0)
	if vim.fn.filereadable(bufname) ~= 1 then
		return
	end

	local pkg_root = find_package_root()
	if not pkg_root then
		return
	end

	local formatters = {
		prettier = "prettier --write",
		biome = "biome format"
	}

	local cmd = nil
	for name, c in pairs(formatters) do
		cmd = formatter_cmd_in_project(pkg_root, name, c)
		if cmd then
			break
		end
	end
	if not cmd then
		vim.notify("Formatter not found in project", vim.log.levels.INFO)
		return
	end

	local filepath = vim.fn.shellescape(bufname)
	local full_cmd = string.format("cd %s && PRETTIER_EXPERIMENTAL_CLI=1 %s --write %s", pkg_root, cmd, filepath)
	vim.cmd("silent !" .. full_cmd)
	vim.cmd("edit!") -- reload buffer
end

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.mjs", ".cjs" },
	callback = format,
})
