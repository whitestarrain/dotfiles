-- c++ (指不定哪天叛逃到ccls)

-- NOTE: window上偶尔，如果有^M符号，编译不会报错，但会导致lsp各种毛病。命令行模式Ctrl-v-m 可以打出这个符号
-- NOTE: 头文件搜索路径配置
-- 全局：配置CPLUS_INCLUDE_PATH,C_INCLUDE_PATH,LIBRARY_PATH 环境变量
-- 局部：配置compile_flags.txt 或者 compile_commands.json

local key_binding = require("lsp_keybing_config")

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

lspconfig.clangd.setup({
  cmd = {
    "clangd",
    -- 在后台自动分析文件（基于complie_commands)
    "--background-index",
    -- 标记compelie_commands.json文件的目录位置
    -- https://zhuanlan.zhihu.com/p/84876003
    -- "--compile-commands-dir=build",
    -- 同时开启的任务数量
    "-j=12",
    -- 告诉clangd用那个clang进行编译，路径参考which clang++的路径
    -- '--query-driver="D:/ProgramFiles/LLVM/bin/clang++.exe"',
    -- clang-tidy功能
    "--clang-tidy",
    -- 全局补全（会自动补充头文件）
    "--all-scopes-completion",
    -- 更详细的补全内容
    "--completion-style=detailed",
    -- 补充头文件的形式
    "--header-insertion=iwyu",
    -- pch优化的位置
    "--pch-storage=disk",
  },
  on_attach = key_binding.on_attach,
  --[[
    flags = {
      debounce_text_changes = 150,
    }
 ]]
})
