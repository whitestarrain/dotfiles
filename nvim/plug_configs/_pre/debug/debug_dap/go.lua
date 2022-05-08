-- DEPN: 安装依赖：
-- Install delve
  -- go install github.com/go-delve/delve/cmd/dlv@latest
  -- or via package manager (pacman -S delve)
  -- Install vscode-go
-- git clone https://github.com/golang/vscode-go
  -- cd vscode-go
  -- npm install
  -- npm run compile

local dap = require('dap')

dap.adapters.go = {
  type = 'executable';
  command = 'node';
  args = {"D:/learn/githubRepo/vscode-go/dist/debugAdapter.js"};
}
dap.configurations.go = {
  {
    type = 'go';
    name = 'Debug';
    request = 'launch';
    showLog = false;
    program = "${file}";
		externalConsole = false,
    dlvToolPath = vim.fn.exepath('dlv')  -- Adjust to where delve is installed
  },
}
