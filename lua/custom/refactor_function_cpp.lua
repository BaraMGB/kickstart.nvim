local M = {}

M.insertDoubleColonAtCursor = function()
    local current_buf = vim.api.nvim_get_current_buf()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local current_line = cursor_pos[1]
    local current_col = cursor_pos[2] + 1 -- lua 1 based, vim is 0 based
    local line_content = vim.api.nvim_buf_get_lines(current_buf, current_line - 1, current_line, false)[1]    
    local new_line_content = line_content:sub(1, current_col - 1) .. "::" .. line_content:sub(current_col)

    -- swap line with new line
    vim.api.nvim_buf_set_lines(current_buf, current_line - 1, current_line, false, {new_line_content})
end

M.deleteLinesToRegister = function(start_line, end_line)
    local current_buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(current_buf, start_line - 1, end_line, false)
    
    for i, line in ipairs(lines) do
        lines[i] = line:gsub("override", "")
    end
  
    local text_to_save = table.concat(lines, "\n")

    vim.fn.setreg('"', text_to_save)

    vim.api.nvim_buf_set_lines(current_buf, start_line - 1, end_line, false, {})
end

M.moveFunctionToCpp = function()
    local current_buf = vim.api.nvim_get_current_buf()
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    local line_content = vim.api.nvim_buf_get_lines(current_buf, current_line - 1, current_line, false)[1]
    local saved_cursor_pos = vim.api.nvim_win_get_cursor(0)

    local modified_line_content = line_content .. ";"
    vim.api.nvim_buf_set_lines(current_buf, current_line, current_line, false, {line_content})
    vim.api.nvim_buf_set_lines(current_buf, current_line - 1, current_line, false, {modified_line_content})
    vim.cmd('normal! [{')
    vim.fn.search("class", 'bW')
    vim.cmd('normal! wyw')
    vim.api.nvim_win_set_cursor(0, saved_cursor_pos)
    vim.cmd('normal! j^f ')
    vim.cmd('normal! p')
    M.insertDoubleColonAtCursor()
    vim.cmd('normal! Vj]}<<')
    local first = vim.api.nvim_win_get_cursor(0)[1];
    vim.cmd('normal! j]}')
    local last = vim.api.nvim_win_get_cursor(0)[1];
    M.deleteLinesToRegister(first, last)
end

return M
