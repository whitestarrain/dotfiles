local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "stevearc/oil.nvim"
plugin.dependencies = {
  "nvim-tree/nvim-web-devicons",
}
plugin.config = function()
  require("oil").setup({
    columns = {
      "icon",
      "permissions",
      "size",
      "mtime",
    },
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },
    delete_to_trash = false,
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = { "actions.show_help", mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },
      ["gx"] = "actions.open_external",
      ["g."] = { "actions.toggle_hidden", mode = "n" },
      ["g\\"] = { "actions.toggle_trash", mode = "n" },
      ["<CR>"] = "actions.select",
      -- ["<C-s>"] = { "actions.select", opts = { vertical = true } },
      -- ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
      ["<C-t>"] = { "actions.select", opts = { tab = true } },
      ["<C-p>"] = "actions.preview",
      ["q"] = {
        function()
          require("oil").close({ exit_if_last_buf = true })
        end,
        mode = "n",
      },
      ["<C-l>"] = "actions.refresh",
      ["-"] = { "actions.parent", mode = "n" },
      ["_"] = { "actions.open_cwd", mode = "n" },
      ["`"] = {
        function()
          require("oil").open("/")
        end,
        mode = "n",
      },
      ["~"] = {
        function()
          require("oil").open("~")
        end,
        mode = "n",
      },
    },
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, _bufnr)
        local m = name:match("^%.")
        return m ~= nil
      end,
      is_always_hidden = function(_name, _bufnr)
        return false
      end,
      natural_order = "fast",
      case_insensitive = false,
      sort = {
        { "type", "asc" },
        { "name", "asc" },
      },
      highlight_filename = function(_entry, _is_hidden, _is_link_target, _is_link_orphan)
        return nil
      end,
    },
  })
end

require("wsain.plugin.whichkey").register({
  {
    "<leader>e",
    function()
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
      require("oil").open(path)
    end,
    desc = "open file dir",
  },
  {
    "<leader>E",
    function()
      require("oil").open(vim.fn.getcwd())
    end,
    desc = "open pwd",
  },
})
return plugin
