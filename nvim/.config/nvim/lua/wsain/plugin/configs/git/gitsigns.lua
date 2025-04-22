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
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged = {
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged_enable = true,
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  auto_attach = true,
  current_line_blame_formatter = "     <author>, <author_time:%R> - <summary>",
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "goto next change" })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "goto prev change" })

    -- Actions
    map("n", "<leader>hs", gs.stage_hunk, { desc = "stage hunk" })
    map("n", "<leader>hr", gs.reset_hunk, { desc = "reset hunk" })
    map("v", "<leader>hs", function()
      gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "stage hunk" })
    map("v", "<leader>hr", function()
      gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "reset hunk" })
    map("n", "<leader>hS", gs.stage_buffer, { desc = "stage buffer" })
    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage buffer" })
    map("n", "<leader>hR", gs.reset_buffer, { desc = "reset buffer" })
    map("n", "<leader>hp", gs.preview_hunk, { desc = "preview hunk" })
    map("n", "<leader>hb", function()
      gs.blame_line({ full = true })
    end, { desc = "blame line" })
    map("n", "<leader>htb", gs.toggle_current_line_blame, { desc = "toggle show line blame" })
    map("n", "<leader>hd", gs.diffthis, { desc = "diff" })
    map("n", "<leader>hD", function()
      gs.diffthis("~")
    end, { desc = "diff staged" })
    map("n", "<leader>htd", gs.toggle_deleted, { desc = "toggle show deleted" })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
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
}
plugin.config = function()
  require("gitsigns").setup(plugin.opts)
  require("wsain.plugin.whichkey").register({
    { "<leader>h", group = "git hunk" },
    { "<leader>hf", ":Gitsigns<cr>", desc = "functions" },
    { "<leader>ht", group = "toggle" },
    { "<leader>h", group = "git hunk", mode = "v" },
  })
end

return plugin
