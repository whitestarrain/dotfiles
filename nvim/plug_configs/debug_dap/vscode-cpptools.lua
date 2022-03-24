local dap = require('dap')

local exec_file = vim.g.absolute_config_path  .. "../debug_dap_exe/vscode-cpptool/extension/debugAdapters/bin/OpenDebugAD7.exe"

dap.adapters.cpp = {
    type = 'executable',
    command = exec_file ,
    name = "lldb"
  }
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "cpp",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      args = {},
      stopAtEntry = false,
      externalConsole = false,
      MIMode = "gdb",
      miDebuggerPath = "gdb.exe",
      preLaunchTask = "compile",
    }
  }
dap.configurations.c = dap.configurations.cpp
