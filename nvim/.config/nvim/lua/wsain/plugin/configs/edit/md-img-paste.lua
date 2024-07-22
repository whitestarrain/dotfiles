local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "ferrine/md-img-paste.vim"
plugin.loadEvent = "VeryLazy"

local function showImagePath()
  vim.api.nvim_echo({
    { "vim.g.mdip_imgdir: " .. vim.g.mdip_imgdir .. "\n", nil },
    { "vim.g.mdip_imgdir_intext: " .. vim.g.mdip_imgdir_intext, nil },
  }, true, {})
end

local function setImagePath()
  vim.ui.input({ prompt = "current is " .. vim.g.mdip_imgdir .. "\nchanged to:" }, function(path)
    if path == nil or #path == 0 then
      return
    end
    vim.g.mdip_imgdir = path
    vim.g.mdip_imgdir_intext = path
  end)
end

plugin.init = function()
  vim.g.mdip_imgdir = "./image"
  vim.g.mdip_imgdir_intext = vim.g.mdip_imgdir
end

plugin.config = function()
  require("wsain.plugin.whichkey").register({
    { "<leader>m", group = "markdown" },
    { "<leader>mm", ":call mdip#MarkdownClipboardImage()<CR>", desc = "imagePaste" },
    { "<leader>ms", setImagePath, desc = "set image path" },
    { "<leader>mp", showImagePath, desc = "print image path" },
  })
end

return plugin
