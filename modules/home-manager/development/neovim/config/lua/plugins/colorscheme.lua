local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add({ source = "catppuccin/nvim", name = "catppuccin" })
	vim.cmd.colorscheme "catppuccin-mocha"
end)
