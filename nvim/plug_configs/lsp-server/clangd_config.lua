-- c++ (指不定哪天叛逃到ccls)

-- NOTE: window上偶尔，如果有^M符号，编译不会报错，但会导致lsp各种毛病。命令行模式Ctrl-v-m 可以打出这个符号
-- NOTE: 头文件搜索路径配置
  -- 全局：配置CPLUS_INCLUDE_PATH,C_INCLUDE_PATH,LIBRARY_PATH 环境变量
  -- 局部：配置compile_flags.txt 或者 compile_commands.json

local key_binding = require('lsp_keybing_config')

require'lspconfig'.clangd.setup{
  on_attach = key_binding.on_attach,
--[[
    flags = {
      debounce_text_changes = 150,
    }
 ]]
}
