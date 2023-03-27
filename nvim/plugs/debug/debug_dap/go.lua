local status, dap = pcall(require, "dap")
if not status then
  return
end

dap.adapters.go = {
  type = "executable",
  command = "node",
  args = { "go-debug-adapter.cmd" },
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
