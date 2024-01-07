local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "LunarVim/bigfile.nvim"

local common_pattern = function(max_length, max_line_length, excluede_file_types)
  return function(bufnr)
    local file_path = vim.api.nvim_buf_get_name(bufnr)
    if file_path == nil or file_path == "" then
      return false
    end
    local common_file_flag = (string.find(file_path, "://") == nil) and (string.find(file_path, ":\\\\") == nil)
    if not common_file_flag then
      return false
    end
    max_length = max_length or 10000
    max_line_length = max_line_length or 1000
    excluede_file_types = excluede_file_types or {}

    local current_file_type = vim.filetype.match({ buf = bufnr })
    local expand_name = vim.fn.expand("%:e")
    for _, file_type in ipairs(excluede_file_types) do
      if current_file_type == file_type then
        return false
      end
      if expand_name == file_type then
        return false
      end
    end

    -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
    local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
    local file_length = #file_contents

    if file_length > max_length then
      return true
    end

    for _, line_content in ipairs(file_contents) do
      if #line_content > max_line_length then
        return true
      end
    end
  end
end

plugin.config = function()
  local features = {
    "indent_blankline",
    "illuminate",
    "lsp",
    "treesitter",
    "syntax",
    "vimopts",
    "filetype",
  }
  -- if disable `matchparen` in win, may not be able to view files
  if require("wsain.utils").getOs() ~= "win" then
    table.insert(features, "matchparen")
  end
  require("bigfile").setup({
    -- detect long python files
    filesize = 5, -- size of the file in MiB, the plugin round file sizes to the closest MiB
    pattern = common_pattern(10000, 1000, { "markdown", "text", "fugitive", "NvimTree", "msnumber" }),
    features = features,
  })
end

return plugin
