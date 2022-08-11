"------------------------------------theme-------------------------------------
" Using Vim-Plug
" Plug 'overcache/NeoSolarized'
" Plug 'cocopon/iceberg.vim'

Plug 'joshdick/onedark.vim' " 原版onedark，不支持cmp

" Plug 'ful1e5/onedark.nvim' " 支持cmp，但是风格改变太大了吧
" Plug 'glepnir/zephyr-nvim' " based on nvim-treesitter
" ------------------------------------theme-------------------------------------

" cmp 支持

autocmd User LoadPluginConfig call PlugConfigTheme()

function! PlugConfigTheme()

  " 自动补全颜色显示
  highlight CmpItemAbbrDeprecated  gui=strikethrough guifg=#5c6370
  highlight CmpItemAbbrDeprecatedDefault  guifg=#8992a1
  highlight CmpItemAbbrMatch  guifg=#75c8ff
  highlight CmpItemAbbrMatchDefault  guifg=#abb2bf
  highlight CmpItemAbbrMatchFuzzyDefault  guifg=#abb2bf
  highlight CmpItemKindColorDefault  guifg=#f65866
  highlight CmpItemKindConstantDefault  guifg=#e5c07b
  highlight CmpItemKindDefault  guifg=#9197A3
  highlight CmpItemKindFileDefault  guifg=#d19a66
  highlight CmpItemKindFunctionDefault  guifg=#c678dd
  highlight CmpItemKindKeywordDefault  guifg=#56b6c2
  highlight CmpItemKindOperatorDefault  guifg=#56b6c2
  highlight CmpItemKindPropertyDefault  guifg=#56b6c2
  highlight CmpItemKindSnippetDefault  guifg=#98c379
  highlight CmpItemKindVariableDefault  guifg=#e06c75
  highlight link CmpItemAbbr     CmpItemAbbrDefault
  highlight link CmpItemAbbrDefault  CmpItemAbbrDeprecatedDefault
  highlight link CmpItemAbbrMatchFuzzy  CmpItemAbbrMatch
  highlight link CmpItemKindClass  CmpItemKindClassDefault
  highlight link CmpItemKindClassDefault  CmpItemKindVariableDefault
  highlight link CmpItemKindColor  CmpItemKindColorDefault
  highlight link CmpItemKindConstant  CmpItemKindConstantDefault
  highlight link CmpItemKindConstructor  CmpItemKindConstructorDefault
  highlight link CmpItemKindConstructorDefault  CmpItemKindFunctionDefault
  highlight link CmpItemKindEnum  CmpItemKindEnumDefault
  highlight link CmpItemKindEnumDefault  CmpItemKindVariableDefault
  highlight link CmpItemKindEnumMember  CmpItemKindEnumMemberDefault
  highlight link CmpItemKindEnumMemberDefault  CmpItemKindOperatorDefault
  highlight link CmpItemKindEvent  CmpItemKindEventDefault
  highlight link CmpItemKindField  CmpItemKindFieldDefault
  highlight link CmpItemKindFieldDefault  CmpItemKindKeywordDefault
  highlight link CmpItemKindFile  CmpItemKindFileDefault
  highlight link CmpItemKindFolder  CmpItemKindFolderDefault
  highlight link CmpItemKindFolderDefault  CmpItemKindFileDefault
  highlight link CmpItemKindFunction  CmpItemKindFunctionDefault
  highlight link CmpItemKindInterface  CmpItemKindInterfaceDefault
  highlight link CmpItemKindInterfaceDefault  CmpItemKindVariableDefault
  highlight link CmpItemKindKeyword  CmpItemKindKeywordDefault
  highlight link CmpItemKindMethod  CmpItemKindMethodDefault
  highlight link CmpItemKindMethodDefault  CmpItemKindFunctionDefault
  highlight link CmpItemKindModule  CmpItemKindModuleDefault
  highlight link CmpItemKindModuleDefault  CmpItemKindConstantDefault
  highlight link CmpItemKindOperator  CmpItemKindOperatorDefault
  highlight link CmpItemKindProperty  CmpItemKindPropertyDefault
  highlight link CmpItemKindReference  CmpItemKindReferenceDefault
  highlight link CmpItemKindReferenceDefault  CmpItemKindOperatorDefault
  highlight link CmpItemKindSnippet  CmpItemKindSnippetDefault
  highlight link CmpItemKindStruct  CmpItemKindStructDefault
  highlight link CmpItemKindStructDefault  CmpItemKindConstantDefault
  highlight link CmpItemKindText  CmpItemKindTextDefault
  highlight link CmpItemKindTextDefault  CmpItemKindVariableDefault
  highlight link CmpItemKindTypeParameter  CmpItemKindOperatorDefault
  highlight link CmpItemKindTypeParameterDefault  CmpItemKindConstantDefault
  highlight link CmpItemKindUnit  CmpItemKindUnitDefault
  highlight link CmpItemKindUnitDefault  CmpItemKindKeywordDefault
  highlight link CmpItemKindValue  CmpItemKindValueDefault
  highlight link CmpItemKindValueDefault  CmpItemKindKeywordDefault
  highlight link CmpItemKindVariable  CmpItemKindVariableDefault
  highlight link CmpItemMenu     CmpItemMenuDefault
  highlight link CmpItemMenuDefault  CmpItemKindDefault

endfunction
