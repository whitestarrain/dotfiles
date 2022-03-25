local dap = require('dap')
dap.adapters.codelldb = function(on_adapter)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  -- CHANGE THIS!
  local cmd = 'D:/MyRepo/dotfiles/debug_dap_exe/codelldb/extension/adapter/codelldb.exe'

  local handle, pid_or_err
  local opts = {
    stdio = {nil, stdout, stderr},
    detached = true,
  }
  handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
    stdout:close()
    stderr:close()
    handle:close()
    if code ~= 0 then
      print("codelldb exited with code", code)
    end
  end)
  assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      local port = chunk:match('Listening on port (%d+)')
      if port then
        vim.schedule(function()
          on_adapter({
            type = 'server',
            host = '127.0.0.1',
            port = port
          })
        end)
      else
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end
  end)
  stderr:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
end

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
      return "D:\\MyRepo\\c_learn\\main.exe"
    end,
    -- program = "${fileDirname}\\${fileBasenameNoExtension}.exe",
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
		externalConsole = false,
    runInTerminal = false,
		MIMode = 'gdb',
		MIDebuggerPath = 'gdb.exe',
  },
}

-- If you want to use this for rust and c, add something like this:
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp


