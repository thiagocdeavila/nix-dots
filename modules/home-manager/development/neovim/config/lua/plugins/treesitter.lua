local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		checkout = "main",
		hooks = { post_checkout = function() vim.cmd("TSUpdate") end }
	})

	local parsers = require("nvim-treesitter").get_available(2)
	require("nvim-treesitter").install(parsers)

	local filetypes = vim.iter(parsers):map(vim.treesitter.language.get_filetypes):flatten():totable()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = filetypes,
		callback = function() vim.treesitter.start() end,
	})
end)
