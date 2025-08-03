return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			format = {
				enable = true,
				defaultConfig = {
					indent_style = "space",
					indent_size = "2",
					quote_style = "double",
				},
			},
		},
	},
}
