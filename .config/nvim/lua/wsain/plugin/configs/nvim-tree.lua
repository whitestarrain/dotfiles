local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "kyazdani42/nvim-tree.lua"
plugin.dependencies = { "kyazdani42/nvim-web-devicons" }
plugin.loadEvent = "VeryLazy"
local onAttach = function(bufnr)
  local api = require("nvim-tree.api")
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set("n", "O", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "<CR>", api.node.open.no_window_picker, opts("Open: No Window Picker"))
  vim.keymap.set("n", "o", api.node.open.no_window_picker, opts("Open: No Window Picker"))
  vim.keymap.set("n", "l", api.node.open.no_window_picker, opts("Open: No Window Picker"))
  vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
  vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
  vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
  vim.keymap.set("n", "p", api.node.navigate.parent, opts("Parent Directory"))
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "x", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
  vim.keymap.set("n", "<C-k>", api.node.navigate.sibling.first, opts("First Sibling"))
  vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
  vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
  vim.keymap.set("n", ".", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
  vim.keymap.set("n", "r", api.tree.reload, opts("Refresh"))
  vim.keymap.set("n", "a", api.fs.create, opts("Create"))
  vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
  vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
  vim.keymap.set("n", "R", api.fs.rename, opts("Rename"))
  vim.keymap.set("n", "X", api.fs.cut, opts("Cut"))
  vim.keymap.set("n", "C", api.fs.copy.node, opts("Copy"))
  vim.keymap.set("n", "P", api.fs.paste, opts("Paste"))
  vim.keymap.set("n", "D", api.fs.remove, opts("Delete"))
  vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
  vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
  vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
  vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
  vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
  vim.keymap.set("n", "S", api.node.run.system, opts("Run System"))
  vim.keymap.set("n", "q", api.tree.close, opts("Close"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
  vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
  vim.keymap.set("n", "K", api.node.show_info_popup, opts("Info"))
end
plugin.opts = {
  git = {
    ignore = false,
    timeout = 1000,
  },
  filters = {
    dotfiles = false,
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
  },
  sort_by = "case_sensitive",
  sync_root_with_cwd = true,
  view = {
    adaptive_size = false,
  },
  on_attach = onAttach,
}
plugin.config = function()
  require("nvim-tree").setup(plugin.opts)
  local tmp = vim.g.startify_session_before_save or {}
  table.insert(tmp, "silent! NvimTreeClose")
  vim.g.startify_session_before_save = tmp
end
plugin.globalMappings = {
  { "n", "<C-n>", ":NvimTreeToggle<CR>" },
  { "n", "<leader>v", ":NvimTreeFindFile<cr>", "NvimTreeFindFile" },
}

return plugin
