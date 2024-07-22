local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")

plugin.shortUrl = "mfussenegger/nvim-dap"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "nvim-neotest/nvim-nio",
}

local default_launch_json_path = "./.vscode/dap.json"

local function cmdWrap(cmd)
  if utils.getOs() == "win" then
    return cmd .. ".cmd"
  end
  return cmd
end

local function ensureDepWrap()
  if package.loaded["nvim-dap-virtual-text"] == nil then
    require("nvim-dap-virtual-text").setup()
  end
end

local function executableSuffix()
  if utils.getOs() == "win" then
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
      args = function()
        return utils.str_split(vim.fn.input("execute args: "))
      end,
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

local function setupDebugPy()
  local dap = require("dap")
  dap.adapters.python = function(cb, config)
    print(cmdWrap("debugpy-adapter"))
    if config.request == "attach" then
      ---@diagnostic disable-next-line: undefined-field
      local port = (config.connect or config).port
      ---@diagnostic disable-next-line: undefined-field
      local host = (config.connect or config).host or "127.0.0.1"
      cb({
        type = "server",
        port = assert(port, "`connect.port` is required for a python `attach` configuration"),
        host = host,
        options = {
          source_filetype = "python",
        },
      })
    else
      cb({
        type = "server",
        port = "${port}",
        executable = {
          command = cmdWrap("debugpy-adapter"),
          args = { "--port", "${port}" },
        },
      })
    end
  end
  dap.configurations.python = {
    {
      name = "default launch file",
      type = "python",
      request = "launch",
      program = "${file}",
      pythonPath = "python",
      justMyCode = false,
      console = "integratedTerminal",
    },
    {
      type = "python",
      request = "launch",
      name = "default flask",
      module = "flask",
      env = {
        FLASK_APP = "run.py",
      },
      args = {
        "run",
        "-p",
        "8088",
        "--with-threads",
        "--debugger",
        "--no-reload",
        "--host=0.0.0.0",
      },
      pythonPath = "python",
      jinja = true,
      justMyCode = false,
      console = "integratedTerminal",
    },
  }
end

local function load_vscode_config()
  local load_launchjs = require("dap.ext.vscode").load_launchjs
  load_launchjs(default_launch_json_path, { cppdbg = { "c", "cpp" } })
end

plugin.config = function()
  vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
  vim.fn.sign_define("DapLogPoint", { text = "󰌑", texthl = "DiagnosticHint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

  ensureDepWrap()
  setupCodelldb()
  setupDebugPy()
end
plugin.globalMappings = {
  {
    "n",
    "<leader>D",
    name = "dap",
  },
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
        vim.cmd([[vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>]])
      end
      load_vscode_config()
      require("dapui").toggle({ reset = true })
    end,
    "dap ui",
  },
}
return plugin
