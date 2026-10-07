require 'keys.alias'

local neotree = require 'neo-tree'

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

nm('<leader>nf', '<cmd>Neotree filesystem<cr>')
nm('<leader>nb', '<cmd>Neotree buffers<cr>')
nm('<leader>ng', '<cmd>Neotree git_status<cr>')
nm('<leader>nc', '<cmd>Neotree current reveal float<cr>')

neotree.setup {
    event_handlers = {
        {
            event = 'file_open_requested',
            handler = function(event)
                local bufnr = event.bufnr
                if event.state.name ~= 'buffers' or not bufnr or vim.bo[bufnr].buftype ~= 'terminal' then
                    return
                end

                require('neo-tree.sources.manager').close_all('float')

                if vim.b[bufnr].codex_terminal then
                    require('codex').open()
                    require('codex.ui').focus()
                else
                    local terminal
                    for _, window in ipairs(Snacks.terminal.list()) do
                        if window.buf == bufnr then
                            terminal = window
                            break
                        end
                    end

                    if terminal then
                        terminal:show():focus()
                    else
                        Snacks.win({
                            buf = bufnr,
                            width = 0.85,
                            height = 0.85,
                            border = 'rounded',
                            title = vim.b[bufnr].term_title,
                            enter = true,
                            keys = { q = 'close', ['<Esc>'] = 'close' },
                        })
                    end
                end

                vim.cmd('startinsert')
                return { handled = true }
            end,
        },
    },
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    window = {
        position = 'float',
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ['o'] = 'open',
        },
    },
    filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
        },
        commands = {
            delete = function(state)
	local inputs = require "neo-tree.ui.inputs"
	local path = state.tree:get_node().path
	local msg = "Are you sure you want to delete " .. path
	inputs.confirm(msg, function(confirmed)
		if not confirmed then return end

		vim.fn.system { "trash", vim.fn.fnameescape(path) }
		require("neo-tree.sources.manager").refresh(state.name)
	end)
end,
        }
    },
}
