Plug 'Pocco81/AutoSave.nvim'

autocmd User LoadPluginConfig call PlugConfigAutoSave()
function! PlugConfigAutoSave()
lua << EOF

  local autosave = require("autosave")

  autosave.setup(
      {
          enabled = true,
          execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
          events = {"InsertLeave", "TextChanged"},
          conditions = {
              exists = true,
              filename_is_not = {},
              filetype_is_not = {},
              modifiable = true
          },
          write_all_buffers = false,
          on_off_commands = true,
          clean_command_line_interval = 0,
          debounce_delay = 135
      }
  )

EOF
endfunction
