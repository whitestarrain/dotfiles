local function scandir(dir)
  local files = {}
  local handle = vim.uv.fs_scandir(dir)
  if not handle then
    return files
  end
  while true do
    local name, type = vim.uv.fs_scandir_next(handle)
    if not name then
      break
    end
    -- unable to get file type on some old file systems or nfs
    if name and not type then
      local stat = vim.uv.fs_stat(dir .. "/" .. name)
      if stat then
        type = stat.type
      end
    end
    if name ~= "_unused" then
      if type == "file" and name:match("%.lua$") then
        files[#files + 1] = dir .. "/" .. name
      elseif type == "directory" then
        local sub = scandir(dir .. "/" .. name)
        for _, f in ipairs(sub) do
          files[#files + 1] = f
        end
      end
    end
  end
  return files
end

local function load_plugins()
  local plugins = {}
  local config_dir = vim.g.absolute_config_path .. "lua/wsain/plugin/configs"
  local prefix_len = #config_dir + 1

  local files = scandir(config_dir)
  table.sort(files)

  for _, file in ipairs(files) do
    local modname = "wsain.plugin.configs." .. file:sub(prefix_len):gsub("%.lua$", ""):gsub("/", ".")
    local ok, mod = pcall(require, modname)
    if ok and mod ~= nil then
      plugins[#plugins + 1] = mod
    end
  end

  return plugins
end

return load_plugins()
