local M = {}
local new_opts = {}

local get_default_options = function()
  local default_opts={
    browser = "Google Chrome",
    args = true,
  }
  return default_opts
end

function M.setup(user_opts)
  local opts = user_opts or {}
  new_opts = vim.tbl_extend('force', get_default_options(), opts)
end
M.setup()

local open_cmd = function()
  local cmd = "open -a " .. "'" .. new_opts.browser .. "'"
  if new_opts.args then
    cmd = cmd .. " --args"
  end
  return cmd
end

local buffer_to_string = function()
  local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
  return table.concat(content, "")
end

local get_svg = function(content)
  local svg_match = content:match "<svg.*>.*</svg>"

  if svg_match then
    if string.find(svg_match, "stroke") then
      svg_match = svg_match:gsub("stroke=[\"'{].-[\"'}]", "stroke=\"black\"")
    else
      svg_match = svg_match:gsub("fill=[\"'{].-[\"'}]", "fill=\"black\"")
    end
  else
    error("No svg tag in this file")
  end

  return svg_match
end

-- This function was found in
-- https://stackoverflow.com/questions/41310742/how-to-start-browser-with-html-string-with-lua

local function show_html(html_in_string)
  local encoder_table = {}
  for _, chars in ipairs{'==', 'AZ', 'az', '09', '++', '//'} do
     for ascii = chars:byte(), chars:byte(2) do
        table.insert(encoder_table, string.char(ascii))
     end
  end

  local function tobase64(str)
     local result, pos = {}, 1
     while pos <= #str do
        local last3 = {str:byte(pos, pos+2)}
        local padded = 3 - #last3
        for j = 1, padded do
           table.insert(last3, 0)
        end
        local codes = {
           math.floor(last3[1] / 4),
           last3[1] % 4 * 16 + math.floor(last3[2] / 16),
           last3[2] % 16 * 4 + math.floor(last3[3] / 64),
           last3[3] % 64
        }
        for j = 1, 4 do
           codes[j] = encoder_table[j+padded > 4 and 1 or 2+codes[j]]
        end
        pos = pos + 3
        table.insert(result, table.concat(codes))
     end
     return table.concat(result)
  end

  vim.fn.systemlist(open_cmd() .. " 'data:text/html;charset=utf-8;base64," ..tobase64(html_in_string) .. "'")
end


function M.preview_svg()
  local content = buffer_to_string()
  local matching_svg = get_svg(content)
  show_html(matching_svg)
end

return M
