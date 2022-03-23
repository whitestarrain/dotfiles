-- c++ (指不定哪天叛逃到ccls)

-- NOTE: window上偶尔，如果有^M符号，编译不会报错，但会导致lsp各种毛病。命令行模式Ctrl-v-m 可以打出这个符号
-- NOTE: 另外需要配置CPLUS_INCLUDE_PATH,C_INCLUDE_PATH,LIBRARY_PATH 环境变量，为头文件搜索路径。具体搜索路径可以查笔记看一下

local key_binding = require('lsp_keybing_config')

require'lspconfig'.clangd.setup{
  on_attach = key_binding.on_attach,
--[[
    flags = {
      debounce_text_changes = 150,
    }
 ]]
}
