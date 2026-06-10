local function local_conf_handler()
  local local_dir = vim.g.absolute_config_path .. ".local"
  if vim.fn.isdirectory(local_dir) == 1 then
    for _, f in ipairs(vim.fn.glob(local_dir .. "/*.lua", false, true)) do
      dofile(f)
    end
  end
end

vim.defer_fn(local_conf_handler, 100)
