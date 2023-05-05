local Template = require("wsain.plugin.template")
local plugin = Template:new()

plugin.shortUrl = "mhinz/vim-startify"
plugin.dependencies = { "ryanoasis/vim-devicons" }
plugin.init = function()
  vim.g.startify_session_before_save = {}
  vim.g.startify_session_savecmds = {}
  vim.g.startify_change_to_dir = 0
  vim.g.startify_custom_header = {
    "                     你今天学到了什么？                   ",
    "      ____   U  ___ u  ____              _   _     ____   ",
    '   U /"___|   \\/"_ \\/ |  _"\\    ___     | \\ |"| U /"___|u ',
    '   \\| | u     | | | |/| | | |  |_"_|   <|  \\| |>\\| |  _ / ',
    "    | |/__.-,_| |_| |U| |_| |\\  | |    U| |\\  |u | |_| |  ",
    "     \\____|\\_)-\\___/  |____/ uU/| |\\u   |_| \\_|   \\____|  ",
    "    _// \\\\      \\\\     |||_.-,_|___|_,-.||   \\\\,-._)(|_   ",
    '   (__)(__)    (__)   (__)_)\\_)-   -(_/ (_")  (_/(__)__)  ',
    "   不要盲目跟风新技术，永远不要停止学习                   ",
    "                  技术没那么值钱，看的是商业模式与市场需求",
    "   注意身体健康，尽可能不要996                            ",
  }
  vim.g.startify_session_before_save = {
    'echo "Cleaning up before saving.."',
    "silent! tabonly",
  }
  vim.g.startify_session_persistence = 1
  vim.g.startify_session_savevars = {
    "g:mdip_imgdir",
    "g:mdip_imgdir_intext",
  }

  vim.g.webdevicons_enable_nerdtree = 0
  vim.g.webdevicons_enable_startify = 1

  vim.cmd([[
    function! StartifyEntryFormat()
        return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
    endfunction
  ]])
end

plugin.globalMappings = {
  { "n", "<leader>s", ":Startify<cr>", "start page" },
}

return plugin
