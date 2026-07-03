local codex_config = {
    split = 'float',
    float = {
        width = 0.85,
        height = 0.85,
        border = 'rounded',
        row = 0.05,
        col = nil,
        title = 'Codex',
    },
    codex_cmd = {
        '/bin/zsh',
        '-lc',
        'CODEX_HOME="$HOME/.codex-personal" exec "$HOME/.local/bin/codex"',
    },
    focus_after_send = true,
}

vim.g.codex_config = codex_config

local codex = require('codex')

codex.setup(codex_config)

local function current_file_label(bufnr)
    local filename = vim.api.nvim_buf_get_name(bufnr)
    if filename == '' then
        return '[No Name]'
    end
    return vim.fn.fnamemodify(filename, ':.')
end

local function visual_selection_text()
    local bufnr = vim.api.nvim_get_current_buf()
    local selection_type = vim.fn.mode()
    if not selection_type:match('^[vV\22]') then
        selection_type = vim.fn.visualmode()
    end

    local start_pos = vim.fn.getpos('v')
    local end_pos = vim.fn.getpos('.')
    local start_line = start_pos[2]
    local end_line = end_pos[2]

    if start_line == 0 or end_line == 0 then
        return nil
    end

    if start_line > end_line or (start_line == end_line and start_pos[3] > end_pos[3]) then
        start_pos, end_pos = end_pos, start_pos
        start_line, end_line = end_line, start_line
    end

    local ok, lines = pcall(vim.fn.getregion, start_pos, end_pos, { type = selection_type })
    if not ok then
        lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
    end

    if #lines == 0 then
        return nil
    end

    return string.format(
        'File: %s:%d-%d\n\n%s',
        current_file_label(bufnr),
        start_line,
        end_line,
        table.concat(lines, '\n')
    )
end

local function send_after_open(text)
    if not text or text == '' then
        vim.notify('Codex: nothing to send', vim.log.levels.WARN)
        return
    end

    codex.open()
    vim.defer_fn(function()
        codex.send(text .. '\n', { submit = false })
        vim.notify('Codex: sent to composer', vim.log.levels.INFO)
    end, 900)
end

vim.keymap.set('n', '<leader>oo', function()
    codex.open()
end, { desc = 'Codex: Open', noremap = true, silent = true })

vim.keymap.set('n', '<leader>oc', function()
    codex.close()
end, { desc = 'Codex: Close', noremap = true, silent = true })

vim.keymap.set('n', '<leader>ot', function()
    codex.toggle()
end, { desc = 'Codex: Toggle', noremap = true, silent = true })

vim.keymap.set('v', '<leader>os', function()
    send_after_open(visual_selection_text())
end, { desc = 'Codex: Send selection', noremap = true, silent = true })

vim.keymap.set('n', '<leader>ob', function()
    local bufnr = vim.api.nvim_get_current_buf()
    local text = string.format(
        'File: %s\n\n%s',
        current_file_label(bufnr),
        table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), '\n')
    )
    send_after_open(text)
end, { desc = 'Codex: Send buffer', noremap = true, silent = true })
