local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("folke/lazydev.nvim")

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "lua",
		once = true,
		callback = function()
			require("lazydev").setup({
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					{ path = vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.nvim" },
				},
			})
		end
	})
end)
