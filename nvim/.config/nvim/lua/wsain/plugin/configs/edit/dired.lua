local utils = require("wsain.utils")
if utils.getOs() == "win" then
  return nil
end

local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "whitestarrain/dired.nvim"
plugin.dependencies = {
  "MunifTanjim/nui.nvim",
}
plugin.config = function()
  require("dired").setup({
    path_separator = "/",
    show_banner = true,
    show_icons = false,
    show_hidden = true,
    show_dot_dirs = true,
    show_colors = true,
    quit_when_no_buffer = true,
    keybinds = {
      dired_enter = { "<cr>", "o" },
      dired_back = "-",
      dired_up = "_",
      dired_rename = "R",
      dired_create = "a",
      dired_delete = "D",
      dired_delete_range = "D",
      dired_copy = "C",
      dired_copy_range = "C",
      dired_copy_marked = "MC",
      dired_move = "X",
      dired_move_range = "X",
      dired_move_marked = "MX",
      dired_paste = "P",
      dired_mark = "M",
      dired_mark_range = "M",
      dired_delete_marked = "MD",
      dired_toggle_hidden = ".",
      dired_toggle_sort_order = ",",
      dired_toggle_icons = "*",
      dired_toggle_colors = "+",
      dired_toggle_hide_details = "(",
      dired_quit = "q",
    },
  })
end

require("wsain.plugin.whichkey").register({
  {
    "<leader>e",
    function()
      local filename = vim.fn.expand("%:t")
      local path_separator = "/"
      local file_path = vim.fn.expand("%")
      local file_stat = vim.uv.fs_lstat(file_path)
      local pwd = vim.fn.getcwd() .. path_separator
      local path
      if file_stat == nil then
        path = pwd
      else
        if file_stat.type == "directory" then
          path = file_path
        else
          path = vim.fn.expand("%:h")
        end
      end
      require("dired.display").goto_filename = filename
      require("dired").open(path)
    end,
    desc = "edit file",
  },
})
return plugin
