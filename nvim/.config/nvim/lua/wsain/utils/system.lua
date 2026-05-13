local M = {}

---@return "mac"|"win"|"wsl"|"linux"
function M.get_os()
  if vim.fn.has("macunix") == 1 then
    return "mac"
  end
  if vim.fn.has("win32") == 1 then
    return "win"
  end
  if vim.fn.has("wsl") == 1 then
    return "wsl"
  end
  return "linux"
end

---@return { cmd: string, args: string[] }
function M.get_open_command()
  local os_type = M.get_os()
  if os_type == "win" then
    return { cmd = "cmd", args = { "/c", "start" } }
  end
  if os_type == "mac" then
    return { cmd = "open", args = {} }
  end
  return { cmd = "xdg-open", args = {} }
end

---@param link string
function M.system_open(link)
  local open_cmd = M.get_open_command()
  local process = {
    cmd = open_cmd.cmd,
    args = open_cmd.args,
    errors = "\n",
    stderr = vim.loop.new_pipe(false),
  }
  table.insert(process.args, link)
  process.handle, process.pid = vim.loop.spawn(
    process.cmd,
    { args = process.args, stdio = { nil, nil, process.stderr }, detached = true },
    function(code)
      process.stderr:read_stop()
      process.stderr:close()
      process.handle:close()
      if code ~= 0 then
        vim.notify(string.format("system_open failed with return code %d: %s", code, process.errors))
      end
    end
  )
  if not process.handle then
    vim.notify(string.format("system_open failed to spawn command '%s': %s", process.cmd, process.pid))
    return
  end
  vim.loop.read_start(process.stderr, function(err, data)
    if err then
      return
    end
    if data then
      process.errors = process.errors .. data
    end
  end)
  vim.loop.unref(process.handle)
end

---@return string
function M.get_unique_id()
  return string.format("%s-%s", os.date("%Y%m%d%H%M%S"), math.floor((os.clock() % 1) * 1000000))
end

function M.open_file_under_cursor()
  local file_path = vim.fn.expand("<cfile>")
  if file_path == nil or string.len(file_path) < 1 then
    return
  end
  local resolve_path
  if string.len(file_path) > 4 and string.sub(file_path, 1, 4) == "http" then
    resolve_path = file_path
  else
    local current_file_path = vim.fn.expand("%:p")
    resolve_path = string.sub(current_file_path, 1, string.len(current_file_path) - string.len(vim.fn.expand("%:t")) - 1)
    resolve_path = resolve_path .. "/" .. file_path
    resolve_path = vim.fn.substitute(resolve_path, "\\", "/", "")
    resolve_path = vim.fn.substitute(resolve_path, "\\", "/", "")
  end
  M.system_open(resolve_path)
end

function M.open_current_file()
  local file_path = vim.fn.expand("%:p")
  if file_path == nil or string.len(file_path) < 1 then
    return
  end
  M.system_open(file_path)
end

return M
