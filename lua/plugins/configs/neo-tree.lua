require 'keys.alias'

local neotree = require 'neo-tree'

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

nm('<leader>nf', '<cmd>Neotree filesystem<cr>')
nm('<leader>nb', '<cmd>Neotree buffers<cr>')
nm('<leader>ng', '<cmd>Neotree git_status<cr>')
nm('<leader>nc', '<cmd>Neotree current reveal float<cr>')

neotree.setup {
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
