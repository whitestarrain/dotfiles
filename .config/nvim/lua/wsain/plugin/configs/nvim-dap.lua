local plugin = require("wsain.plugin.template"):new()
plugin.shortUrl = "mfussenegger/nvim-dap"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "rcarriga/nvim-dap-ui",
}

local function cmdWrap(cmd)
  if require("wsain.utils").getOs() == "win" then
    return cmd .. ".cmd"
  end
  return cmd
end

local function executableSuffix()
  if require("wsain.utils").getOs() == "win" then
    return ".exe"
  end
  return ""
end

local function setupCppdbg()
  local dap = require("dap")
  dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = cmdWrap("OpenDebugAD7"),
    options = {
      detached = false,
    },
  }
  -- nvim-dap-ui make cppdbg can't work correct
  -- issue: https://github.com/rcarriga/nvim-dap-ui/issues/162
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "cppdbg",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      environment = {},
      externalConsole = false,
      MIMode = "gdb",
      miDebuggerPath = "gdb",
    },
  }
  -- If you want to use this for rust and c, add something like this:
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end

local function setupCodelldb()
  local dap = require("dap")
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = cmdWrap("codelldb"),
      args = { "--port", "${port}" },
      detached = false,
    },
  }

  dap.configurations.cpp = {
    {
      name = "select launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
    {
      name = "launch output",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.getcwd() .. "/" .. "output/" .. vim.fn.expand("%:r") .. executableSuffix()
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }

  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end

plugin.config = function()
  vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
  vim.fn.sign_define("DapLogPoint", { text = "󰌑", texthl = "DiagnosticHint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

  setupCodelldb()
end
plugin.globalMappings = {
  {
    "n",
    "<leader>DD",
    function()
      require("dap").toggle_breakpoint()
    end,
    "toggle_breakpoint",
  },
  {
    "n",
    "<leader>DC",
    function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end,
    "condition breakpoint",
  },
  {
    "n",
    "<leader>DL",
    function()
      require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end,
    "log breakpoint",
  },
  {
    "n",
    "<leader>Du",
    function()
      if package.loaded["dapui"] == nil then
        require("dapui").setup()
      end
      require("dapui").toggle()
    end,
    "dap ui",
  },
}
return plugin
