local M = {}

M.big_file_max_line = 10000
M.big_file_max_line_length = 1000

---@param file_path string
---@return boolean
function M.check_file_exist(file_path)
  local fs_stat = vim.uv.fs_lstat(file_path)
  return fs_stat ~= nil
end

---@param file_path string
---@return integer|nil
function M.get_file_size(file_path)
  local f = io.open(file_path, "rb")
  local size = nil
  if f ~= nil then
    size = f:seek("end")
    io.close(f)
  end
  return size
end

---@param url string
---@param file_path string
---@param timeout? integer
---@param proxy? string
---@return string[]
function M.get_download_file_command(url, file_path, timeout, proxy)
  timeout = timeout or 30
  local command = {
    "curl",
    "--connect-timeout",
    timeout,
    url,
    "-s",
    "-o",
    file_path,
  }
  if proxy ~= nil and proxy ~= "" then
    table.insert(command, 2, "--proxy")
    table.insert(command, 3, proxy)
  end
  return command
end

---@param dir_path string
function M.check_dir_or_create(dir_path)
  local os_type = require("wsain.utils.system").get_os()
  if os_type == "win" then
    vim.fn.system(string.format([[if not exist "%s" mkdir "%s"]], dir_path, dir_path))
    return
  end
  vim.fn.system(string.format("[[ ! -d %s ]] && mkdir -p %s", dir_path, dir_path))
end

---@param url string
---@return string|nil
function M.get_default_url_image_name(url)
  if url == nil then
    return
  end
  local param_position = string.find(url, "?", nil, true)
  if param_position ~= nil and param_position > 0 then
    url = string.sub(url, 0, param_position - 1)
  end
  local image_extension = "png"
  for _, ext_name in ipairs({ "png", "jpg", "jpeg", "gif", "bmp", "svg", "webp" }) do
    local e_start, _ = string.find(url, string.format("%%.%s$", ext_name))
    if e_start ~= nil then
      image_extension = ext_name
      break
    end
  end
  local image_name =
    string.lower(string.format("%s-%s.%s", vim.fn.expand("%:t:r"), require("wsain.utils.system").get_unique_id(), image_extension))
  return image_name
end

---@param input_proxy? boolean
---@param start_line? integer
---@param end_line? integer
function M.save_markdown_url_images(input_proxy, start_line, end_line)
  local buf_num = vim.api.nvim_get_current_buf()
  local lines
  if start_line ~= nil and end_line ~= nil then
    lines = vim.api.nvim_buf_get_lines(buf_num, start_line - 1, end_line, false)
  else
    lines = vim.api.nvim_buf_get_lines(buf_num, 0, -1, false)
  end
  if lines == nil or #lines == 0 then
    return
  end

  -- get image dir path
  local relative_path = vim.fn.expand("%:h")
  local image_dir = vim.g.mdip_imgdir or "./image"
  local relative_image_path = relative_path .. "/" .. image_dir

  -- ensure dir exist
  M.check_dir_or_create(relative_image_path)

  -- proxy
  local proxy
  if input_proxy then
    proxy = vim.fn.input("proxy: ", "127.0.0.1:7890")
  end

  for line_number, line_content in ipairs(lines) do
    line_number = ((start_line or 1) - 1) + line_number
    local line_index = line_number - 1
    if line_content == nil or line_content == "" or string.sub(line_content, 1, #"<!--") == "<!--" then
      goto continue
    end
    local _, _, md_img_url_text, url = string.find(line_content, "(!%[.-%]%((.-)%))")
    if url == nil or string.sub(url, 1, #"http") ~= "http" then
      goto continue
    end

    local image_name = M.get_default_url_image_name(url)
    local image_path = relative_image_path .. "/" .. image_name
    image_path = vim.fn.substitute(image_path, "\\", "/", "")

    vim.fn.jobstart(M.get_download_file_command(url, image_path, 10, proxy), {
      stdout_buffered = true,
      on_stdout = function()
        local image_size = M.get_file_size(image_path)
        if image_size == nil or image_size < 1024 then
          vim.notify(string.format("Download image failed, line %s", line_number))
          if image_size ~= nil then
            os.remove(image_path)
          end
          return
        end
        vim.schedule(function()
          local cur_line_content = vim.api.nvim_buf_get_lines(buf_num, line_index, line_index + 1, false)[1]
          local start_pos, end_pos = string.find(cur_line_content, url, 1, true)
          if start_pos == nil or end_pos == nil then
            vim.notify("Image url position changed")
            return
          end
          local md_img_text = string.format("![%s](%s)", image_name, image_dir .. "/" .. image_name)
          local escape_pattern = require("wsain.utils.string").escape_pattern
          local image_line_text = string.gsub(cur_line_content, escape_pattern(md_img_url_text), md_img_text)
          vim.api.nvim_buf_set_lines(buf_num, line_index, line_index + 1, false, { image_line_text })
          vim.notify(string.format("Download image success, line %s", line_number))
        end)
      end,
    })
    ::continue::
  end
end

---@param max_file_size? integer
---@param max_lines? integer
---@param max_line_length? integer
---@return fun(bufnr: integer): boolean
function M.get_check_bigfile_function(max_file_size, max_lines, max_line_length)
  return function(bufnr)
    local file_path = vim.api.nvim_buf_get_name(bufnr)
    if file_path == nil or file_path == "" then
      return false
    end
    local common_file_flag = (string.find(file_path, "://") == nil) and (string.find(file_path, ":\\\\") == nil)
    if not common_file_flag then
      return false
    end
    max_lines = max_lines or M.big_file_max_line
    max_line_length = max_line_length or M.big_file_max_line_length
    local getfsize_status, file_size = pcall(vim.fn.getfsize, file_path)
    if not getfsize_status then
      return false
    end
    max_file_size = max_file_size or 1024 * 1024
    if file_size < 0 or file_size > max_file_size then
      return true
    end
    -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
    local readfile_status, file_contents = pcall(vim.fn.readfile, file_path)
    if not readfile_status then
      return false
    end
    local file_length = #file_contents

    if file_length > max_lines then
      return true
    end

    for _, line_content in ipairs(file_contents) do
      if #line_content > max_line_length then
        return true
      end
    end
    return false
  end
end

---@param file_path string
---@return string
function M.get_file_relative_path(file_path)
  local cwd = vim.fn.getcwd()
  local escape_pattern = require("wsain.utils.string").escape_pattern
  local relative_path, _ = string.gsub(file_path, escape_pattern(cwd), ".")
  return relative_path
end

return M
