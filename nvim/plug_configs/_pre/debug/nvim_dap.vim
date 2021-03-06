" 配置成功：go

Plug 'mfussenegger/nvim-dap'
Plug 'theHamsta/nvim-dap-virtual-text' " 内联文本
Plug 'rcarriga/nvim-dap-ui' " UI界面

autocmd User LoadPluginConfig call PlugConfigDap()
function! PlugConfigDap()
lua << EOF

  -- --------------- 内联文本 -------------------

  require("nvim-dap-virtual-text").setup()

  -- --------------- dap-ui ---------------------

  local dap = require("dap")
  local dapui = require("dapui")

  -- 初始化调试界面
  dapui.setup(
      {
          sidebar = {
              -- dapui 的窗口设置在右边
              position = "right"
          }
      }
  )

  -- 如果开启或关闭调试，则自动打开或关闭调试界面
  dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
      dap.repl.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
      dap.repl.close()
  end

  -- 显示或隐藏调试界面
  vim.api.nvim_set_keymap("n", "<leader>Du", "<cmd>lua require'dapui'.toggle()<CR>", {silent = true})


  -- --------------- dap -------------------

  -- https://github.com/mfussenegger/nvim-dap

  -- DEPN: dap 手动下载调试器
  -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

  local dap = require("dap")

  -- 设置断点样式
  vim.fn.sign_define("DapBreakpoint", {text = "⊚", texthl = "TodoFgFIX", linehl = "", numhl = ""})

  -- 打断点
  vim.api.nvim_set_keymap("n", "<leader>Db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", {silent = true})
  -- 开启调试或到下一个断点处
  vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", {silent = true})
  -- 单步进入执行（会进入函数内部，有回溯阶段）
  vim.api.nvim_set_keymap("n", "<F6>", "<cmd>lua require'dap'.step_into()<CR>", {silent = true})
  -- 单步跳过执行（不进入函数内部，无回溯阶段）
  vim.api.nvim_set_keymap("n", "<F7>", "<cmd>lua require'dap'.step_over()<CR>", {silent = true})
  -- 步出当前函数
  vim.api.nvim_set_keymap("n", "<F8>", "<cmd>lua require'dap'.step_out()<CR>", {silent = true})
  -- 重启调试
  vim.api.nvim_set_keymap("n", "<F9>", "<cmd>lua require'dap'.run_last()<CR>", {silent = true})
  -- 退出调试（关闭调试，关闭 repl，关闭 ui，清除内联文本）
  vim.api.nvim_set_keymap(
      "n",
      "<F10>",
      "<cmd>lua require'dap'.close()<CR><cmd>lua require'dap.repl'.close()<CR><cmd>lua require'dapui'.close()<CR><cmd>DapVirtualTextForceRefresh<CR>",
      {silent = true}
  )


  -- dap/python:
  -- 
  -- return {
  --     adapters = {
  --         type = "executable",
  --         command = "python3",
  --         args = {"-m", "debugpy.adapter"}
  --     },
  --     configurations = {
  --         {
  --             type = "python",
  --             request = "launch",
  --             name = "Launch file",
  --             program = "${file}",
  --             pythonPath = function()
  --                 return vim.g.python_path
  --             end
  --         }
  --     }
  -- }
  -- 
  -- -- 加载调试器配置
  -- local dap_config = {
  --     python = require("dap.python"),
  --     -- go = require("dap.go")
  -- }

  -- -- 设置调试器
  -- for dap_name, dap_options in pairs(dap_config) do
  --     dap.adapters[dap_name] = dap_options.adapters
  --     dap.configurations[dap_name] = dap_options.configurations
  -- end


EOF
endfunction
