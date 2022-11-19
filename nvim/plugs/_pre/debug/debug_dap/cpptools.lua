local dap = require("dap")

dap.adapters.cpptools = {
  type = "executable",
  command = vim.g.absolute_config_path
    .. "../debug_dap_exe/vscode-cpptool/extension/debugAdapters/bin/OpenDebugAD7.exe",
  -- command = "D:/FromC/.vscode/extensions/ms-vscode.cpptools-1.5.1/debugAdapters/bin/OpenDebugAD7.exe",

  --[[ command = "cmd",
  args={
    "/C",
    "start",
    vim.g.absolute_config_path  .. '../debug_dap_exe/vscode-cpptool/extension/debugAdapters/bin/OpenDebugAD7.exe',
    "1>nul 2>nul"
  }, ]]

  name = "cpptools",
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "cpptools",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "\\", "file")
    end,
    -- program = "${fileDirname}\\${fileBasenameNoExtension}.exe",
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    externalConsole = false,
    runInTerminal = false,
    MIMode = "gdb",
    MIDebuggerPath = "gdb.exe",
  },
}

-- If you want to use this for rust and c, add something like this:
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
