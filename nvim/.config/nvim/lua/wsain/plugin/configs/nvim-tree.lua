local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")

plugin.shortUrl = "kyazdani42/nvim-tree.lua"
plugin.dependencies = { "nvim-tree/nvim-web-devicons" }
plugin.loadEvent = "VeryLazy"
local function relative_path_under_cursor()
  local node = require("nvim-tree.lib").get_node_at_cursor()
  local current_path = node.absolute_path
  if node.type == "file" then
    return node.parent.absolute_path
  end
  if current_path == nil then
    return
  end
  local cwd = vim.fn.getcwd()
  local relative_path, _ = string.gsub(current_path, utils.literalize(cwd), ".")
  return relative_path
end
local function get_current_node_path()
  local node = require("nvim-tree.lib").get_node_at_cursor()
  if node.type == "file" then
    return node.parent.absolute_path
  end
  return node.absolute_path
end
local onAttach = function(bufnr)
  local api = require("nvim-tree.api")
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
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

  vim.keymap.set("n", "T", function()
    -- get current window buffers' paths
    local buf_ids = vim.fn.tabpagebuflist()
    local win_ids = vim.api.nvim_tabpage_list_wins(0)
    local dir_paths = {}
    for _,win_id in ipairs(win_ids) do
      table.insert(dir_paths, vim.fn.getcwd(win_id))
    end
    for _, buf_id in ipairs(buf_ids) do
      local ft = vim.api.nvim_buf_get_option(buf_id, "ft")
      if ft ~= "NvimTree" then
        local path = vim.fn.expand(string.format("#%d:p:h", buf_id))
        if path ~= nil and path ~= "" then
          table.insert(dir_paths, path)
        end
      end
    end
    dir_paths = utils.list_unique(dir_paths)
    if #dir_paths > 1 then
      vim.ui.select(dir_paths, { prompt = "Select path to change root" }, function(choice)
        require("nvim-tree.api").tree.change_root(choice)
      end)
    else
      require("nvim-tree.api").tree.change_root(dir_paths[1])
    end
  end, opts("Toggle root"))

  vim.keymap.set("n", "ff", function()
    local relative_path = relative_path_under_cursor()
    local status, telescope_builtin = pcall(require, "telescope.builtin")
    if not status then
      return
    end
    telescope_builtin.find_files({
      prompt_title = "find file under: " .. relative_path,
      cwd = relative_path,
      hidden = true,
      no_ignore = true,
      file_ignore_patterns = {},
    })
  end, opts("Find file"))

  vim.keymap.set("n", "fg", function()
    local relative_path = relative_path_under_cursor()
    local status, telescope_builtin = pcall(require, "telescope.builtin")
    if not status then
      return
    end
    telescope_builtin.live_grep({
      prompt_title = "grep under: " .. relative_path,
      cwd = relative_path,
      preview = true,
      hidden = true,
      no_ignore = true,
    })
  end, opts("Live grep"))

  vim.keymap.set("n", "F", function()
    if vim.g.loaded_floaterm ~= 1 then
      return
    end
    local relative_path = relative_path_under_cursor()
    vim.cmd("FloatermNew --cwd=" .. relative_path .. " " .. "--title=" .. relative_path)
  end, opts("Floaterm"))
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
  sync_root_with_cwd = false,
  disable_netrw = false,
  hijack_netrw = false,
  view = {
    adaptive_size = false,
  },
  on_attach = onAttach,
}
plugin.config = function()
  require("nvim-tree").setup(plugin.opts)
  require("wsain.utils").addCommandBeforeSaveSession("silent! NvimTreeClose")

  local api = require("nvim-tree.api")

  require("wsain.plugin.whichkey").register({
    {
      "<leader>v",
      function()
        api.tree.find_file({ open = true, focus = true })
      end,
      desc = "NvimTreeFindFile",
      mode = "n",
    },
  })
end

vim.keymap.set("n", "<C-n>", function()
  require("nvim-tree.api").tree.toggle({
    -- path = vim.fn.getcwd(),
    find_file = false,
    update_root = false,
    focus = true,
  })
end, { silent = true, noremap = true })

return plugin
