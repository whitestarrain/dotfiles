-- 通用的lint lsp。提供lint和format功能

-- DEPN: go install github.com/mattn/efm-langserver@latest

-- bash
  -- DEPN: scoop install shellcheck
  -- DEPN: go install mvdan.cc/sh/v3/cmd/shfmt@latest

local key_binding = require('lsp_keybing_config')
--
--[[
local isort = {formatCommand = "isort --quiet -", formatStdin = true}
local clangf = {formatCommand = "clang-format", formatStdin = true}
local yapf = {formatCommand = "yapf --quiet", formatStdin = true}
local luaf = {
    formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb",
    formatStdin = true
}
local latexindent = {formatCommand = "latexindent", formatStdin = true}
local cmakef = {formatCommand = 'cmake-format', formatStdin = true}
local prettier = {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true} 
]]

local shellcheck = {LintCommand = 'shellcheck -f gcc -x', lintFormats = {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}}
local shfmt = {formatCommand = 'shfmt -ci -s -bn', formatStdin = true}

require"lspconfig".efm.setup {
  on_attach = key_binding.on_attach,
  cmd = {"efm-langserver"},
  init_options = {documentFormatting = true, codeAction = false},
  filetypes = {
    "sh",
    --[[ "tex",
    "lua",
    "python",
    "cpp",
    "json",
    "yaml",
    "css",
    "html" ]]
  },
  settings = {
    rootMarkers = {".git/"},
    languages = {
      sh = {shellcheck, shfmt},
      --[[ python = {isort, yapf},
      lua = {luaf},
      tex = {latexindent},
      cmake = {cmakef},
      html = {prettier},
      css = {prettier},
      json = {prettier},
      yaml = {prettier},
      cpp = {clangf} ]]
    }
  }
}
