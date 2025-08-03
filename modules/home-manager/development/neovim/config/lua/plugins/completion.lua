local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add({
		source = "saghen/blink.cmp",
		depends = { "rafamadriz/friendly-snippets" },
		checkout = "v1.6.0"
	})

	require("blink.cmp").setup({
		keymap = { preset = "default" },
		completion = { documentation = { auto_show = false } },
	})
end)
