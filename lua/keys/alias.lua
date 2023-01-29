local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true}

function nm(key, command)
	map('n', key, command, default_opts)
end

function im(key, command)
	map('i', key, command, default_opts)
end

function vm(key, command)
	map('v', key, command, default_opts)
end

function tm(key, command)
	map('t', key, command, default_opts)
end
