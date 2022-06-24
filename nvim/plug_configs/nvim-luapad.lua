vim.cmd([[
  Plug 'rafcamlet/nvim-luapad'
]])

-- Luapad - which open interactive scratch buffer with real time evaluation.
-- LuaRun - which run content of current buffer as lua script in new scope. You do not need to write file to disc or have to worry about overwriting functions in global scope.

vim.cmd([[
  command! LuapadToggle lua require('luapad').toggle()
]])

--[[
WARNING!!!
Luapad evaluates every code that you put in it, so be careful what you type in
specially if it's system calls, file operations etc.
Also calling functions like nvim_open_win isn't good idea, 
because every single change in buffer is evaluated (you will get new window with every typed char :D).

Luapad was designed to mess with small nvim lua code chunks.
It probably will not work well with big "real" / "production" scripts.

All thoughts or/and error reports are welcome.

Don't use `:e` if the pad is open
close pad if you get it by toggling before you close the buf
]]
