@rem 路径: HKCU\SOFTWARE\Microsoft\Command Processor
@rem 值：AutoRun
@rem 类型：REG_EXPAND_SZ
@rem 数据："path to this file"

@doskey vi=nvim -u NONE $*
@doskey vim=nvim --cmd "let g:skip_project_plugs=1" $*
