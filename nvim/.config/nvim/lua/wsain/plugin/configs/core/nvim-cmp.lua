local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "hrsh7th/nvim-cmp"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  -- "hrsh7th/cmp-nvim-lsp-signature-help",
  "saadparwaiz1/cmp_luasnip",
  "lukas-reineke/cmp-under-comparator",
  "onsails/lspkind-nvim",
  "rcarriga/cmp-dap",
  {
    "L3MON4D3/LuaSnip",
    -- make sure build env is prepared
    build = function()
      vim.notify("(luasnip)please run: make install_jsregexp")
    end,
    dependencies = { "rafamadriz/friendly-snippets", "honza/vim-snippets" },
  },
}
plugin.config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  --load friendly-snippets
  require("luasnip.loaders.from_vscode").lazy_load()
  -- load vim-snippets
  require("luasnip.loaders.from_snipmate").lazy_load({ exclude = { "markdown" } })
  -- load custom snippets
  require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.absolute_config_path .. "others/.snippet" })
  -- can't load vscode snippets without install_jsregexp
  -- require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.absolute_config_path .. "others/.snippet" })

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
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = "",
    },
  })

  local lspkind_format = {
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format({
      mode = "symbol",
      with_text = true,
      maxwidth = 50,
      ellipsis_char = "…",
      before = function(_entry, vim_item)
        vim_item.menu = "(" .. (vim_item.kind or "Other") .. ")"
        return vim_item
      end,
    }),
  }

  local amp_sources = {
    { name = "nvim_lsp", priority = 10 },
    { name = "path", priority = 5 },
    { name = "luasnip", priority = 4 },
    { name = "nvim_lsp_signature_help" },
  }

  local has_words_before = function()
    local unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local toggle_complete = function(_callback)
    if cmp.visible() then
      cmp.abort()
    else
      cmp.complete()
    end
  end

  ---@diagnostic disable-next-line: redundant-parameter
  cmp.setup({
    enabled = function()
      return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
    end,
    -- snippet engine
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },

    window = {
      completion = {
        border = border("CmpBorder"),
        winhighlight = "CursorLine:Visual",
        scrollbar = true,
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
      ["<A-.>"] = cmp.mapping(toggle_complete, { "i", "c" }),
      ["<CR>"] = cmp.mapping.confirm({
        select = false,
        behavior = cmp.ConfirmBehavior.Insert,
      }),
      -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      -- ['<C-y>'] = cmp.config.disable,
      ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif cmp.visible() then
          cmp.select_next_item()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },

    formatting = lspkind_format,

    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        require("cmp-under-comparator").under,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  })

  local cmdline_mapping = {
    -- disable <tab> <s-tab> mapping for wildmenu
    ["<C-n>"] = {
      c = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
    },
    ["<C-p>"] = {
      c = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
    },
    ["<Tab>"] = {
      c = function(_fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "tn", false)
        end
      end,
    },
  }
  cmdline_mapping["<A-.>"] = cmp.mapping(toggle_complete, { "c" })

  -- Use buffer source for `/` `?`.
  cmp.setup.cmdline("/", {
    mapping = cmdline_mapping,
    sources = {
      { name = "buffer" },
    },
    formatting = lspkind_format,
  })
  cmp.setup.cmdline("?", {
    mapping = cmdline_mapping,
    sources = {
      { name = "buffer" },
    },
    formatting = lspkind_format,
  })

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline(":", {
    mapping = cmdline_mapping,
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
    formatting = lspkind_format,
    ignore_cmds = { "!", "man", "Man" },
  })

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline("@", {
    mapping = cmdline_mapping,
    sources = {},
  })

  cmp.setup.filetype({ "dap-repl", "dapui_watches" }, {
    sources = {
      { name = "dap" },
    },
  })

  cmp.setup.filetype({ "markdown", "text", "gitcommit", "" }, {
    completion = {
      autocomplete = false,
      completeopt = "menu,menuone,noinsert",
    },
    mapping = {
      ["<CR>"] = cmp.mapping.confirm({
        select = true,
        behavior = cmp.ConfirmBehavior.Insert,
      }),
    },
  })
end

return plugin
