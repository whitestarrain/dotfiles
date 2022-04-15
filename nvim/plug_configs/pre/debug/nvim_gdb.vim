Plug 'cpiger/NeoDebug' " NOTE: windows，确保没有sed命令(scoop gow包可装一些linux命令)。否则会非常费cpu

let g:neodbg_keymap_continue           = '<F5>'         " run or continue
let g:neodbg_keymap_stop_debugging     = '<C-S-F5>'     " stop debugging (kill)
let g:neodbg_keymap_toggle_console_win = '<F6>'         " toggle console window
let g:neodbg_keymap_step_into          = '<F7>'         " step into
let g:neodbg_keymap_step_out           = '<F8>'         " setp out
let g:neodbg_keymap_toggle_breakpoint  = '<F9>'         " toggle breakpoint on current line
let g:neodbg_keymap_next               = '<F10>'        " next
let g:neodbg_keymap_run_to_cursor      = '<C-F10>'      " run to cursor (tb and c)
let g:neodbg_keymap_jump               = '<C-S-F10>'    " set next statement (tb and jump)
let g:neodbg_keymap_print_variable     = '<F12>'             " view variable under the cursor
let g:neodbg_keymap_terminate_debugger = '<C-C>'        " terminate debugger

" 编译程序：gcc -g test.c -o test.exe
" vim内开启 :NeoDebug a.exe
" gdb开始调试：start

" <F5> 	- run or continue
" <S-F5> 	- stop debugging (kill)
" <F6> 	- toggle console window
" <F10> 	- next
" <F11> 	- step into
" <S-F11> - step out (finish)
" <C-F10>	- run to cursor (tb and c)
" <F9> 	- toggle breakpoint on current line
" <C-S-F10> - set next statement (tb and jump)
" <C-P> 	- view variable under the cursor
" <TAB>   - trigger complete 

" packadd termdebug
