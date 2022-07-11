local M = {}

local bufferToString = function()
  local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
  return table.concat(content, "")
end

local getSvg = function(content)
  local svgMatch = string.match(content, "<svg>.*</svg>")
  return svgMatch
end

return M
