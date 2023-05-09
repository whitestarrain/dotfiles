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

plugin.globalMappings = {
  { "n", "<leader>m", name = "markdown" },
  { "n", "<leader>mm", ":call mdip#MarkdownClipboardImage()<CR>", "imagePaste" },
  { "n", "<leader>ms", setImagePath, "set image path" },
  { "n", "<leader>mp", showImagePath, "print image path" },
}

return plugin
