vim.cmd([[
 Plug 'jose-elias-alvarez/null-ls.nvim'
]])

local au = require("au")
au["User LoadPluginConfig"] = function()
  if vim.g.code_language_list == nil then
    return
  end

  local status, null_ls = pcall(require, "null-ls")
  if not status then
    return
  end

  local null_ls_source = {}
  for _, code_lanuage in ipairs(vim.g.code_language_list) do
    if code_lanuage == "lua" then
      -- DEPN: stylua
      table.insert(null_ls_source, null_ls.builtins.formatting.stylua)
    end
    if code_lanuage == "python" then
      -- DEPN: pylint
      table.insert(null_ls_source, null_ls.builtins.diagnostics.pylint)
    end
    if code_lanuage == "bash" then
      -- DEPN: shfmt,shellcheck
      table.insert(null_ls_source, null_ls.builtins.formatting.shfmt)
      table.insert(null_ls_source, null_ls.builtins.code_actions.shellcheck)
      table.insert(
        null_ls_source,
        null_ls.builtins.diagnostics.shellcheck.with({
          diagnostics_format = "#{m}\n  https://www.shellcheck.net/wiki/SC#{c}",
        })
      )
    end
    if code_lanuage == "front" then
      table.insert(
        null_ls_source,
        null_ls.builtins.formatting.prettier.with({
          disabled_filetypes = { "markdown" },
        })
      )
    end
  end

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == "null-ls"
      end,
      bufnr = bufnr,
    })
  end

  null_ls.setup({
    sources = null_ls_source,
    on_attach = function(client, bufnr)
    end,
  })
end
