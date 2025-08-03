local add, later = MiniDeps.add, MiniDeps.later
local keys = require("utils").keys

later(function()
	add("stevearc/conform.nvim")

	local conform = require("conform")

	conform.setup()

	keys.lmap("n", "cf", function() conform.format({ async = true, lsp_fallback = true }) end, "Format Code")
end)
