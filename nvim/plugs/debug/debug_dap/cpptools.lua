local dap = require("dap")

dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = "OpenDebugAD7.cmd",
  options = {
    detached = false,
  },
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "\\", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    environment = {},
    externalConsole = false,
    MIMode = "gdb",
    miDebuggerPath = "D:\\ProgramFiles\\mingw64\\bin\\gdb.exe",
  },
}

-- If you want to use this for rust and c, add something like this:
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
