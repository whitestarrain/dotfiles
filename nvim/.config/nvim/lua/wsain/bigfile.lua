-- https://github.com/LunarVim/bigfile.nvim/blob/main/lua/bigfile/features.lua
local utils = require("wsain.utils")

local M = {}

local special_file_types = {
  "NvimTree",
  "TelescopePrompt",
  "checkhealth",
  "dirbuf",
  "dirvish",
  "floaterm",
  "floaterm",
  "fugitive",
  "help",
  "leadf",
  "lspinfo",
  "man",
  "msnumber",
  "packer",
  "startify",
}

local bigfile_check_flag = "wsain_bigfile_check_flag"
local bigfile_disable_treesitter = "wsain_bigfile_disable_treesitter"
local is_ts_configured = false

local function check_bigfile(bufnr, max_file_size, max_lines, max_line_length)
  local status_ok, flag = pcall(vim.api.nvim_buf_get_var, bufnr, bigfile_check_flag)
  if status_ok and flag ~= nil then
    return flag
  end
  local is_bigfile = utils.get_check_bigfile_function(max_file_size, max_lines, max_line_length)(bufnr)
  vim.api.nvim_buf_set_var(bufnr, bigfile_check_flag, is_bigfile)
  return is_bigfile
end

local function configure_treesitter()
  local status_ok, ts_config = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

  local disable_cb = function(_, buf)
    local success, detected = pcall(vim.api.nvim_buf_get_var, buf, bigfile_disable_treesitter)
    return success and detected
  end

  for _, mod_name in ipairs(ts_config.available_modules()) do
    local module_config = ts_config.get_module(mod_name) or {}
    local old_disabled = module_config.disable
    module_config.disable = function(lang, buf)
      return disable_cb(lang, buf)
        or (type(old_disabled) == "table" and vim.tbl_contains(old_disabled, lang))
        or (type(old_disabled) == "function" and old_disabled(lang, buf))
    end
  end

  is_ts_configured = true
end

local function pcall_wrap(model_name, callback)
  local status, lua_model = pcall(require, model_name)
  if not status then
    return
  end
  callback(lua_model)
end

local features = {
  disable_treesitter = function(buf)
    if not is_ts_configured then
      configure_treesitter()
    end

    vim.api.nvim_buf_set_var(buf, bigfile_disable_treesitter, 1)
  end,

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
  enable_treesitter_highlight = function(_bufnr)
    pcall_wrap("nvim-treesitter", function()
      vim.cmd("TSBufEnable highlight")
    end)
  end,

  enable_rainbow = function(bufnr)
    pcall_wrap("rainbow-delimiters", function(m)
      m.enable(bufnr)
    end)
  end,

  enable_indent_blankline = function(bufnr)
    pcall_wrap("ibl", function(m)
      m.setup_buffer(bufnr, { enabled = true })
    end)
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
    -- markdown
    local expand_name = vim.fn.expand("%:e")
    if expand_name == "markdown" or expand_name == "md" then
      table.insert(defer_flist, defer_features.enable_indent_blankline)
      if not check_bigfile(bufnr, nil, 2000, nil) then
        table.insert(defer_flist, defer_features.enable_treesitter_highlight)
      end
      return
    end

    local is_bigfile = check_bigfile(bufnr)
    -- bigfile
    if is_bigfile then
      table.insert(flist, features.disable_treesitter)
      table.insert(flist, features.disable_vimopts)
      table.insert(flist, features.disable_illuminate)
      return
    end

    -- common file
    table.insert(defer_flist, defer_features.enable_treesitter_highlight)
    table.insert(defer_flist, defer_features.enable_rainbow)
    table.insert(defer_flist, defer_features.enable_indent_blankline)
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
