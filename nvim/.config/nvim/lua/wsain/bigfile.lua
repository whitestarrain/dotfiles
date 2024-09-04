-- https://github.com/LunarVim/bigfile.nvim/blob/main/lua/bigfile/features.lua

local M = {}

local is_ts_configured = false

local function configure_treesitter()
  local status_ok, ts_config = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

  local disable_cb = function(_, buf)
    local success, detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
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

function M.disable_treesitter(buf)
  if not is_ts_configured then
    configure_treesitter()
  end

  vim.api.nvim_buf_set_var(buf, "bigfile_disable_treesitter", 1)
end

function M.disable_illuminate(bufnr)
  pcall_wrap("illuminate.engine", function(m)
    m.stop_buf(bufnr)
  end)
end

function M.disable_vimopts()
  vim.opt_local.swapfile = false
  vim.opt_local.foldmethod = "manual"
  vim.opt_local.undolevels = 10
  vim.opt_local.undoreload = 0
  vim.opt_local.list = false
end

function M.disable_syntax()
  vim.cmd("syntax clear")
  vim.opt_local.syntax = "OFF"
end

function M.disable_filetype()
  vim.opt_local.filetype = ""
end

function M.enable_treesitter_highlight(_bufnr)
  pcall_wrap("nvim-treesitter", function()
    vim.cmd("TSBufEnable highlight")
  end)
end

function M.enable_rainbow(bufnr)
  pcall_wrap("rainbow-delimiters", function(m)
    m.enable(bufnr)
  end)
end

function M.enable_indent_blankline(bufnr)
  pcall_wrap("ibl", function(m)
    m.setup_buffer(bufnr, { enabled = true })
  end)
end

return M
