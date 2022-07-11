local M = {}

local buffer_to_string = function()
  local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
  return table.concat(content, "")
end

local get_svg = function(content)
  local svg_match = string.match(content, "<svg>.*</svg>")
  return svg_match
end

return M
