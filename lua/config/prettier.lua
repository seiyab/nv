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

local function prettier_cmd_in_project(pkg_root)
  -- Prefer local node_modules
  local local_bin = pkg_root .. "/node_modules/.bin/prettier"
  if vim.fn.executable(local_bin) == 1 then
    return local_bin
  end

  -- Use package manager command if available
  local manager = get_package_manager(pkg_root)
  local check_cmd = ({
    yarn = "yarn prettier --version",
    pnpm = "pnpm prettier --version",
    npm = "npx prettier --version",
  })[manager]

  if check_cmd then
    local ok = os.execute("cd " .. pkg_root .. " && " .. check_cmd .. " >/dev/null 2>&1")
    if ok == true or ok == 0 then
      return ({
        yarn = "yarn prettier",
        pnpm = "pnpm prettier",
        npm  = "npx prettier",
      })[manager]
    end
  end

  return nil
end

local function format_with_prettier()
  local bufname = vim.api.nvim_buf_get_name(0)
  if vim.fn.filereadable(bufname) ~= 1 then return end

  local pkg_root = find_package_root()
  if not pkg_root then return end

  local prettier = prettier_cmd_in_project(pkg_root)
  if not prettier then
    vim.notify("Prettier not found in project", vim.log.levels.INFO)
    return
  end

  local filepath = vim.fn.shellescape(bufname)
  local full_cmd = string.format("cd %s && PRETTIER_EXPERIMENTAL_CLI=1 %s --write %s", pkg_root, prettier, filepath)
  vim.cmd("silent !" .. full_cmd)
  vim.cmd("edit!") -- reload buffer
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
  callback = format_with_prettier,
})

