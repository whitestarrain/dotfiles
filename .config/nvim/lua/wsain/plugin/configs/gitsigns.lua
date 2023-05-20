local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "lewis6991/gitsigns.nvim"
plugin.loadEvent = "VeryLazy"
plugin.branch = "main"
plugin.dependencies = {
  "junegunn/gv.vim",
  "tpope/vim-fugitive",
}
plugin.opts = {
  signs = {
    -- │ or ┃
    add = { hl = "GitSignsAdd", text = "┃", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "┃", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "┃", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  keymaps = {
    ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'" },
    ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'" },

    ["n <leader>hs"] = "<cmd>Gitsigns stage_hunk<CR>",
    ["v <leader>hs"] = ":Gitsigns stage_hunk<CR>",
    ["n <leader>hu"] = "<cmd>Gitsigns undo_stage_hunk<CR>",
    ["n <leader>hr"] = "<cmd>Gitsigns reset_hunk<CR>",
    ["v <leader>hr"] = ":Gitsigns reset_hunk<CR>",
    ["n <leader>hR"] = "<cmd>Gitsigns reset_buffer<CR>",
    ["n <leader>hp"] = "<cmd>Gitsigns preview_hunk<CR>",
    ["n <leader>hb"] = ":Gitsigns blame_line<CR>",
    ["n <leader>hS"] = "<cmd>Gitsigns stage_buffer<CR>",
    ["n <leader>hU"] = "<cmd>Gitsigns reset_buffer_index<CR>",

    -- Text objects
    ["o ih"] = ":<C-U>Gitsigns select_hunk<CR>",
    ["x ih"] = ":<C-U>Gitsigns select_hunk<CR>",
  },
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 300,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  preview_config = {
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
}
plugin.config = function()
  require("gitsigns").setup(plugin.opts)
end

return plugin
