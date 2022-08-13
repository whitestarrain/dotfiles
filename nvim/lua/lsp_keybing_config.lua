-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- code action，具体由lsp来定
	buf_set_keymap("n", "<leader>ca", '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
	-- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

	-- code action，针对选定的部分代码
	buf_set_keymap("v", "<leader>ca", ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>', opts)
	-- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)

	-- hover显示文档
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) -- 两次K可以跳进popup 中，q键可以关闭popup
	-- buf_set_keymap('n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts) -- [lspsaga] 无法正常展示转义字符，使用原生的

	-- lspsaga翻页用，不是太好用
	-- buf_set_keymap('n', '<C-f>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opts)
	-- buf_set_keymap('n', '<C-b>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', opts)

	-- 跳转到declaration
	buf_set_keymap("n", "<leader>cD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)

	-- 跳转到definition
	buf_set_keymap("n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

	-- go to definition 快捷键设置
	vim.cmd([[
        autocmd BufEnter *.lua nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.java nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.js nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.jsx nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.ts nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.tsx nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.html nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.css nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.sass nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.go nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.c nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.cpp nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.cc nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.py nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.sh nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.vue nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.tex nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
        autocmd BufEnter *.vim nnoremap <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
    ]])

	-- 查看definition，不跳转
	buf_set_keymap("n", "<leader>cp", '<cmd>lua require"lspsaga.provider".preview_definition()<CR>', opts)

	-- 跳转到implementation
	buf_set_keymap("n", "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

	-- 查看引用该元素的位置
	-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap("n", "<leader>cr", '<cmd>lua require"lspsaga.provider".lsp_finder()<CR>', opts) -- [lspsaga] definition 和 references都会显示

	-- 显示方法参数，普通模式和插入模式。lspsaga无法跳转到提示里面，所以不使用
	buf_set_keymap("n", "<leader>cs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- buf_set_keymap('n', '<leader>cs', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)  -- [lspsaga] 无法通过<c-f>,<c-b>scroll
	buf_set_keymap("i", "<c-p>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) -- 两次<C-p>可以进去hover
	-- buf_set_keymap('i', '<c-p>', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts) -- [lspsaga] 无法通过<c-f>,<c-b>scroll

	-- 重命名，lspsaga
	-- buf_set_keymap('n', '<leader>cR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap("n", "<leader>cR", '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)

	-- 显示当前行的诊断报告
	-- buf_set_keymap('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap("n", "<leader>ce", '<cmd>lua require"lspsaga.diagnostic".show_line_diagnostics()<CR>', opts)

	-- 诊断问题代码前后跳转，文档中没有加border的说明，需要看底层代码调用
	buf_set_keymap("n", "[e", '<cmd>lua vim.diagnostic.goto_prev({float = {border = "single"}})<CR>', opts)
	-- buf_set_keymap('n', 'gp', '<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<CR>', opts) -- [lspsaga]有nil报错
	buf_set_keymap("n", "]e", '<cmd>lua vim.diagnostic.goto_next({float = {border = "single"}})<CR>', opts)
	-- buf_set_keymap('n', 'gn', '<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_next()<CR>', opts) -- [lspsaga]有nil报错

	-- 代码格式化
	buf_set_keymap("n", "<space>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	-- workspace相关，不太清楚干什么的
	-- buf_set_keymap('n', '<leader>cwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	-- buf_set_keymap('n', '<leader>cwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	-- buf_set_keymap('n', '<leader>cwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

	-- 不太清楚干什么的
	-- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

	-- 用trouble插件代替
	-- buf_set_keymap('n', 'gl', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

return {
	on_attach = on_attach,
}
