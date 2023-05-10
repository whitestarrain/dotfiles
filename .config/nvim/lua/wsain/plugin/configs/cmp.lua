local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "hrsh7th/nvim-cmp"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",

  "onsails/lspkind-nvim",

  "hrsh7th/vim-vsnip",
  "rafamadriz/friendly-snippets",
}
plugin.init = function()
  vim.g.vsnip_snippet_dir = vim.g.absolute_config_path .. "others/.snippet"
end
plugin.config = function()
  local cmp = require("cmp")

  -- 图标设置
  local function border(hl_name)
    return {
      { "╭", hl_name },
      { "─", hl_name },
      { "╮", hl_name },
      { "│", hl_name },
      { "╯", hl_name },
      { "─", hl_name },
      { "╰", hl_name },
      { "│", hl_name },
    }
  end
  local lspkind = require("lspkind")
  lspkind.init({
    mode = "symbol",
    preset = "codicons",
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = "",
    },
  })

  local lspkind_format = {
    format = lspkind.cmp_format({
      with_text = true,
      maxwidth = 40,
      before = function(entry, vim_item)
        -- Source 显示提示来源
        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
        return vim_item
      end,
    }),
  }

  vim.o.completeopt = "menu"

  local amp_sources = {
    { name = "nvim_lsp", priority = 10 },
    { name = "path", priority = 5 },
    { name = "vsnip", priority = 4 },
  }

  cmp.setup({
    -- snippet engine
    snippet = {
      expand = function(args)
        -- For `vsnip` users.
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },

    window = {
      completion = {
        border = border("CmpBorder"),
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel",
      },
      documentation = {
        border = border("CmpDocBorder"),
        winhighlight = "Normal:CmpDoc",
      },
    },

    -- 来源
    sources = cmp.config.sources(amp_sources),

    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<A-,>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<CR>"] = cmp.mapping.confirm({
        select = true,
      }),
      -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    },
    formatting = lspkind_format,
  })

  -- Use buffer source for `/`.
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
    formatting = lspkind_format,
  })

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
    formatting = lspkind_format,
  })
end

return plugin
