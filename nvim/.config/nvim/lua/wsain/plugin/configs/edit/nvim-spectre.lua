local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "nvim-pack/nvim-spectre"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  require("spectre").setup({
    find_engine = {
      ["rg"] = {
        cmd = "rg",
        -- default args
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        options = {
          ["ignore-case"] = {
            value = "--ignore-case",
            icon = "[I]",
            desc = "ignore case",
          },
          ["hidden"] = {
            value = "--hidden",
            desc = "hidden file",
            icon = "[H]",
          },
        },
      },
    },
    mapping = {
      ["quit"] = {
        map = "q",
        cmd = ":q<cr>",
        desc = "quit",
      },
    },
  })
  require("spectre.search.rg").get_path_args = function(_, paths)
    if #paths == 0 then
      return {}
    end

    local args = {}
    for _, path in ipairs(paths) do
      table.insert(args, "--no-ignore")
      table.insert(args, "--hidden")
      table.insert(args, "-g")
      table.insert(args, path)
    end
    return args
  end
end

return plugin
