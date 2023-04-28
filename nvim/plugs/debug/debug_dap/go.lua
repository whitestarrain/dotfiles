local status, dap = pcall(require, "dap")
if not status then
  return
end

local command = "go-debug-adapter"
if vim.fn.has("win32") == 1 then
  command = command .. ".cmd"
end

dap.adapters.go = {
  type = "executable",
  command = command,
}
dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    showLog = false,
    program = "${file}",
    externalConsole = false,
    dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
  },
}
