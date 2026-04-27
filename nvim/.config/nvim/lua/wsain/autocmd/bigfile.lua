-- https://github.com/LunarVim/bigfile.nvim/blob/main/lua/bigfile/features.lua
local utils = require("wsain.utils")

local M = {}

local bigfile_check_flag = "wsain_bigfile_check_flag"

local function check_bigfile(bufnr, max_file_size, max_lines, max_line_length)
  local status_ok, flag = pcall(vim.api.nvim_buf_get_var, bufnr, bigfile_check_flag)
  if status_ok and flag ~= nil then
    return flag
  end
  local is_bigfile = utils.get_check_bigfile_function(max_file_size, max_lines, max_line_length)(bufnr)
  vim.api.nvim_buf_set_var(bufnr, bigfile_check_flag, is_bigfile)
  return is_bigfile
end

local function pcall_wrap(model_name, callback)
  local status, lua_model = pcall(require, model_name)
  if not status then
    return
  end
  callback(lua_model)
end

local features = {
  disable_illuminate = function(bufnr)
    pcall_wrap("illuminate.engine", function(m)
      m.stop_buf(bufnr)
    end)
  end,

  disable_vimopts = function()
    vim.opt_local.swapfile = false
    vim.opt_local.foldmethod = "manual"
    vim.opt_local.undolevels = 10
    vim.opt_local.undoreload = 0
    vim.opt_local.list = false
  end,
}

local defer_features = {
  enable_indent_blankline = function(bufnr)
    pcall_wrap("ibl", function(m)
      m.setup_buffer(bufnr, { enabled = true })
    end)
  end,

  enable_treesitter = function(bufnr)
    pcall(vim.treesitter.start, bufnr)
  end,

  disable_syntax = function()
    vim.cmd("syntax clear")
    vim.opt_local.syntax = "OFF"
  end,

  disable_filetype = function()
    vim.opt_local.filetype = ""
  end,
}

-- bigfile autocmd
function M.bigfile_handler(bufnr)
  if not vim.bo.buflisted then
    return
  end

  local flist = {}
  local defer_flist = {}

  local function get_features()
    local is_bigfile
    local expand_name = vim.fn.expand("%:e")
    if expand_name == "markdown" or expand_name == "md" then
      -- markdown, I often edit large markdown files, so just skip
      is_bigfile = false
    else
      -- check big file
      is_bigfile = check_bigfile(bufnr)
    end

    if is_bigfile then
      -- bigfile, disable some feature
      table.insert(flist, features.disable_vimopts)
      table.insert(flist, features.disable_illuminate)
    else
      -- small file, enable some feature
      table.insert(defer_flist, defer_features.enable_indent_blankline)
    end
  end

  get_features()

  for _, feature in ipairs(flist) do
    feature(bufnr)
  end

  vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    callback = vim.schedule_wrap(function()
      for _, feature in ipairs(defer_flist) do
        feature(bufnr)
      end
    end),
    buffer = bufnr,
    once = true,
  })
end

return M
