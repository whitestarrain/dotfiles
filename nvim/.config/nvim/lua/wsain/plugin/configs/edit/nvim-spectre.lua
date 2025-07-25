local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "nvim-pack/nvim-spectre"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  require("spectre").setup({
    mapping = {
        ['tab'] = {
            map = '<Tab>',
            cmd = "<cmd>lua require('spectre').tab()<cr>",
            desc = 'next query'
        },
        ['shift-tab'] = {
            map = '<S-Tab>',
            cmd = "<cmd>lua require('spectre').tab_shift()<cr>",
            desc = 'previous query'
        },
        ['toggle_line'] = {
            map = "t",
            cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
            desc = "toggle item"
        },
        ['enter_file'] = {
            map = "o",
            cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
            desc = "open file"
        },
        ['enter_file_2'] = {
            map = "<cr>",
            cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
            desc = "open file"
        },
        ['send_to_qf'] = {
            map = ",q",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "send all items to quickfix"
        },
        ['replace_cmd'] = {
            map = ",c",
            cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
            desc = "input replace command"
        },
        ['show_option_menu'] = {
            map = ",o",
            cmd = "<cmd>lua require('spectre').show_options()<CR>",
            desc = "show options"
        },
        ['change_view_mode'] = {
            map = ",v",
            cmd = "<cmd>lua require('spectre').change_view()<CR>",
            desc = "change result view mode"
        },
        ['run_current_replace'] = {
          map = ",r",
          cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
          desc = "replace current line"
        },
        ['run_replace'] = {
            map = ",R",
            cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
            desc = "replace all"
        },
        ['change_replace_sed'] = {
          map = ",trs",
          cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
          desc = "use sed to replace"
        },
        ['change_replace_oxi'] = {
          map = ",tro",
          cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
          desc = "use oxi to replace"
        },
        ['toggle_live_update']={
          map = ",tu",
          cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
          desc = "update when vim writes to file"
        },
        ['toggle_ignore_case'] = {
          map = ",ti",
          cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
          desc = "toggle ignore case"
        },
        ['toggle_ignore_hidden'] = {
          map = ",th",
          cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
          desc = "toggle search hidden"
        },
        ['resume_last_search'] = {
          map = ",l",
          cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
          desc = "repeat last search"
        },
        ['quit'] = {
          map = "q",
          cmd = ":q<cr>",
          desc = "quit"
        },
    },
  })
end

return plugin
