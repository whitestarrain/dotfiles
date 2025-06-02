local utils = require("wsain.utils")

local get_option_index_and_value = function(options, option_pair)
  if option_pair == nil or option_pair == "" then
    return nil, nil
  end
  for index, option in ipairs(options) do
    if string.match(option_pair, option) then
      local value = string.sub(option_pair, string.find(option_pair, "=", nil, true) + 1, -1)
      return index, value
    end
  end
  return nil, nil
end

local md_save_image_options = {
  "--proxy=",
}
vim.api.nvim_create_user_command("MdSaveImage", function(opts)
  local fargs = opts["fargs"]
  local _, use_proxy_value = get_option_index_and_value(md_save_image_options, fargs[1])
  local use_proxy = (use_proxy_value == "true")
  local start_line, end_line
  if opts["range"] ~= nil and opts["range"] ~= 0 then
    start_line = opts["line1"]
    end_line = opts["line2"]
  end
  utils.save_markdown_url_images(use_proxy, start_line, end_line)
end, {
  desc = "save markdown image",
  range = 2,
  nargs = "*",
  complete = function(arg_lead, _, _)
    local index, _ = get_option_index_and_value(md_save_image_options, arg_lead)
    if index ~= nil then
      return {}
    end
    return md_save_image_options
  end,
})

vim.api.nvim_create_user_command("MdSaveBase64Image", function(_)
  local base64_line_content = vim.fn.substitute(vim.api.nvim_get_current_line(), "\\s\\+", "", "g")
  local relative_path = vim.fn.expand("%:h")
  local image_dir = vim.g.mdip_imgdir or "./image"
  local relative_image_path = relative_path .. "/" .. image_dir
  utils.check_dir_or_create(relative_image_path)
  local image_name = string.format("%s-%s.%s", vim.fn.expand("%:t:r"), utils.get_unique_id(), "png")
  local image_path = relative_image_path .. "/" .. image_name
  vim.fn.system("base64 -d > " .. image_path, base64_line_content)
  local md_img_text = string.format("![%s](%s)", image_name, image_dir .. "/" .. image_name)
  vim.api.nvim_set_current_line(md_img_text)
end, {
  desc = "convert base64 string to image",
})
