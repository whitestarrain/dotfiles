local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")
require("wsain.plugin.whichkey").register({
  { "<leader>d", ":bp|bd #<cr>", desc = "delete buffer" },
  { "<leader>z", group = "+others" },
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
})

return plugin
