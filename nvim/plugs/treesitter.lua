-- NOTE: 最好不要使用:PlugUpdate进行更新，手动最好git pull

vim.cmd([[
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'p00f/nvim-ts-rainbow'
]])

require("au")["User LoadPluginConfig"] = function()
  require("nvim-treesitter.configs").setup({
    -- 安装 language parser。默认不自动安装
    -- :TSInstallInfo 命令查看支持的语言
    -- DEPN: :TSInstall <lang>
    -- markdown不要装，尽管disable了，但也会调用parse，导致拖慢速度。

    -- 禁止自动安装解析器
    auto_install = false,

    -- 是否同时和vim的高亮一起使用
    additional_vim_regex_highlighting = false,

    -- 启用代码高亮功能
    highlight = {
      enable = true,
      disable = { "markdown", "help" },
      additional_vim_regex_highlighting = false,
    },

    -- 启用增量选择
    incremental_selection = {
      enable = true,
      disable = { "markdown" },
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        node_decremental = "<BS>",
        -- scope_incremental = '<TAB>',
      },
    },

    -- 启用缩进
    indent = {
      enable = true,
      disable = { "markdown", "html", "php", "python" },
    },

    -- 启用彩虹括号
    rainbow = {
      enable = true,
      disable = { "markdown" },
      -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
    },
  })

  -- 启用folding
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
  -- 默认不要折叠 (https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file)
  vim.wo.foldlevel = 99
end
