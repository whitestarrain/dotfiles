local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")
require("wsain.plugin.whichkey").register({
  { "<leader>d", ":bp|bd #<cr>", desc = "delete buffer" },
  { "<leader>z", group = "+others", mode = "n" },
  { "<leader>z", group = "+others", mode = "v" },
  { "<leader>zp", ":syntax sync fromstart<cr>", desc = "syntax sync" },
  { "<leader>zl", ":%s/\\v(\\n\\s*){2,}/\\r\\r/<cr> :/jkjk<cr>", desc = "compress blank line" },
  { "<leader>zf", ':echo expand("%:p")<cr>', desc = "show file path" },
  { "<leader>zu", require("wsain.utils").openFileUnderCursor, desc = "open file under cursor" },
  { "<leader>zo", require("wsain.utils").openCurrentFile, desc = "open current file" },
  { "<leader>m", group = "markdown" },
  { "<leader>md", group = "download" },
  {
    "<leader>mdi",
    function()
      utils.save_markdown_url_images()
    end,
    desc = "download images",
  },
  {
    "<leader>mdI",
    function()
      utils.save_markdown_url_images(true)
    end,
    desc = "download images using proxy",
  },
  {
    "<leader>e",
    function()
      local path_separator = "/"
      if utils.getOs() == "win" then
        path_separator = "\\"
      end
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
      vim.cmd(":e " .. path)
    end,
    desc = "edit file",
  },
  {
    "<leader>zs",
    [[:s/[^\x00-\xff]\zs\ze\w\|\w\zs\ze[^\x00-\xff]/ /g<CR>]],
    desc = "wrap english word with space",
    mode = "v",
  },
  {
    "<leader>zr",
    function()
      local reg_0 = vim.fn.getreg("0")
      local reg_local = vim.fn.getreg("+")
      if reg_0 == nil or reg_0 == "" then
        vim.notify("register 0 is empty")
        return
      end
      if reg_local == nil or reg_local == "" then
        vim.notify("register + is empty")
        return
      end
      vim.api.nvim_feedkeys(":sno/" .. reg_0 .. "/" .. reg_local .. "/g", "n", "false")
    end,
    desc = "replace {reg_0} by {reg_local}",
    mode = "v",
  },
})

return plugin
