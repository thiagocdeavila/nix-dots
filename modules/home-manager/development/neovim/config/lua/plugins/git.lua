local keys = require("utils").keys
local add, later = MiniDeps.add, MiniDeps.later

later(function()
	require("mini.diff").setup()
	require("mini.git").setup()
end)

later(function()
	add("NeogitOrg/neogit")
	local neogit = require("neogit")
	neogit.setup({ kind = "replace" })

	keys.lmap("n", "gg", function() neogit.open() end)
end)
