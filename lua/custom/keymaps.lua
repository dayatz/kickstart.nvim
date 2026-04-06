-- Personal keymaps and text transformations

-- Transform visually selected lines into a quoted list:
--   JAN123        ['JAN123',
--   JAN456   =>    'JAN456',
--   JAN789         'JAN789',]
vim.keymap.set('v', '<leader>ql', function()
  -- Exit visual mode to set '< '> marks, then get range
  vim.cmd 'normal! \27'
  local start_line = vim.fn.line "'<"
  local end_line = vim.fn.line "'>"
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  local result = {}
  for i, line in ipairs(lines) do
    local trimmed = vim.trim(line)
    if trimmed ~= '' then
      if i == 1 then
        table.insert(result, "['" .. trimmed .. "',")
      elseif i == #lines then
        table.insert(result, " '" .. trimmed .. "',]")
      else
        table.insert(result, " '" .. trimmed .. "',")
      end
    end
  end

  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, result)
end, { desc = '[Q]uote [L]ist: wrap lines in a quoted list' })

-- Transform space-separated words on one line into a quoted list:
--   JAN123 JAN456 JAN789  =>  ['JAN123', 'JAN456', 'JAN789']
vim.keymap.set('n', '<leader>qL', function()
  local line = vim.api.nvim_get_current_line()
  local words = {}
  for word in line:gmatch '%S+' do
    table.insert(words, "'" .. word .. "'")
  end
  if #words > 0 then
    local result = '[' .. table.concat(words, ', ') .. ']'
    vim.api.nvim_set_current_line(result)
  end
end, { desc = '[Q]uote [L]ist: single-line words to quoted list' })

-- Copy file path with line number(s) to clipboard
-- Normal mode: path:42 | Visual mode: path:42-50
local function copy_path_with_line(relative)
  return function()
    local path = relative and vim.fn.expand '%' or vim.fn.expand '%:p'
    local mode = vim.fn.mode()
    local result
    if mode == 'v' or mode == 'V' or mode == '\22' then
      vim.cmd 'normal! \27' -- exit visual to set '< '>
      local start_line = vim.fn.line "'<"
      local end_line = vim.fn.line "'>"
      if start_line == end_line then
        result = path .. ':' .. start_line
      else
        result = path .. ':' .. start_line .. '-' .. end_line
      end
    else
      result = path .. ':' .. vim.fn.line '.'
    end
    vim.fn.setreg('+', result)
    vim.notify(result, vim.log.levels.INFO)
  end
end

vim.keymap.set({ 'n', 'v' }, '<leader>cp', copy_path_with_line(true), { desc = '[C]opy relative [P]ath:line' })
vim.keymap.set({ 'n', 'v' }, '<leader>cP', copy_path_with_line(false), { desc = '[C]opy absolute [P]ath:line' })
