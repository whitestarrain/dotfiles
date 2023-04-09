vim.cmd([[
  Plug 'kyazdani42/nvim-tree.lua'
]])

require("au")["User LoadPluginConfig"] = function()
  local status, nvimTree = pcall(require, "nvim-tree")
  if not status then
    return
  end

  vim.cmd([[
    noremap <silent><C-n> :NvimTreeToggle<CR>
    nnoremap <silent><leader>v :NvimTreeFindFile<cr>
    let g:which_key_map.v = 'NvimTreeFindFile'

    " starify，seesion关闭时执行操作
    if exists("g:startify_session_before_save")
      let g:startify_session_before_save +=  ['silent! NvimTreeClose']
    endif

    " 自动打开侧边栏
    if exists("g:startify_session_savecmds")
      " let g:startify_session_savecmds += ["silent! NvimTreeOpen"]
    endif

  ]])

  nvimTree.setup({
    git = {
      ignore = false,
      timeout= 1000,
    },
    filters = {
      dotfiles = false,
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
    },
    update_cwd = true,
    sort_by = "case_sensitive",
    view = {
      adaptive_size = false,
      mappings = {
        list = {
          { key = { "O" }, action = "edit" },
          { key = { "<CR>", "o", "l" }, action = "edit_no_picker" },
          { key = "<C-e>", action = "edit_in_place" },
          -- { key = {"<C-]>"},                      action = "cd" },
          { key = "<C-v>", action = "vsplit" },
          { key = "<C-s>", action = "split" },
          { key = "t", action = "tabnew" },
          { key = "<", action = "prev_sibling" },
          { key = ">", action = "next_sibling" },
          { key = "p", action = "parent_node" },
          { key = { "h", "x" }, action = "close_node" },
          { key = "<Tab>", action = "preview" },
          { key = "<C-k>", action = "first_sibling" },
          { key = "J", action = "last_sibling" },
          { key = "I", action = "toggle_git_ignored" },
          { key = ".", action = "toggle_dotfiles" },
          { key = "r", action = "refresh" },
          { key = "a", action = "create" },
          { key = "D", action = "trash" },
          { key = "<C-r>", action = "full_rename" },
          { key = "R", action = "rename" },
          { key = "X", action = "cut" },
          { key = "C", action = "copy" },
          { key = "P", action = "paste" },
          { key = "D", action = "remove" },
          { key = "y", action = "copy_name" },
          { key = "Y", action = "copy_path" },
          { key = "gy", action = "copy_absolute_path" },
          { key = "[c", action = "prev_git_item" },
          { key = "]c", action = "next_git_item" },
          { key = "-", action = "dir_up" },
          { key = { "s", "S" }, action = "system_open" },
          { key = "q", action = "close" },
          { key = "?", action = "toggle_help" },
          { key = "W", action = "collapse_all" },
          -- { key = "S",                            action = "search_node" },
          { key = "K", action = "toggle_file_info" },
          -- { key = ".",                            action = "run_file_command" }
        },
      },
    },
  })
end
