local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "LunarVim/bigfile.nvim"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  require("bigfile").setup({
    -- detect long python files
    pattern = function(bufnr, filesize_mib)
      -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
      local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
      local file_length = #file_contents
      local filetype = vim.filetype.match({ buf = bufnr })
      if filetype == "markdown" then
        return false
      end

      if file_length > 10000 then
        return true
      end

      for _, line_content in ipairs(file_contents) do
        if #line_content > 1000 then
          return true
        end
      end
    end,
  })
end

return plugin
