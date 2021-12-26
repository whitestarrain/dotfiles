-- 前端lsp：
-- { "aspnetcorerazor", "astro", "astro-markdown", "blade", "django-html", "edge",
-- "eelixir", "ejs", "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", 
-- "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", 
-- "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus",
-- "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte" }

local key_binding = require('lsp_keybing_config')

require'lspconfig'.tailwindcss.setup{
    on_attach = key_binding.on_attach,
    flags = {
      debounce_text_changes = 150,
    }
}