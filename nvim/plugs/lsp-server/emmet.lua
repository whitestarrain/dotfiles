--DEPN: npm install -g emmet-ls

require'lspconfig'.emmet_ls.setup{
    filetypes = { "javascript.jsx", "typescript.tsx", "vue", "html"},
}
-- 不用配置键位
