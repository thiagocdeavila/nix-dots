local M = {}

local map = function(mode, keys, command, desc, opts)
	opts = opts or {}
	opts.desc = desc

	vim.keymap.set(mode, keys, command, opts)
end

local lmap = function(mode, keys, command, desc, opts)
	map(mode, "<leader>" .. keys, command, desc, opts)
end

M.keys = {
	map = map,
	lmap = lmap
}

return M
