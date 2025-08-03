local keys = require("utils").keys
local add, later, now = MiniDeps.add, MiniDeps.later, MiniDeps.now

now(function()
	add("stevearc/oil.nvim")
	local oil = require("oil")

	oil.setup()

	keys.lmap("n", "ee", function() oil.open() end, "Open Oil")
	keys.lmap("n", "eE", function() oil.open(vim.fn.getcwd()) end, "Open Oil on Root dir")
end)

