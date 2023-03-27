--DEPN: npm install -g emmet-ls

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end
lspconfig.emmet_ls.setup({
  filetypes = { "javascript.jsx", "typescript.tsx", "vue", "html" },
})
