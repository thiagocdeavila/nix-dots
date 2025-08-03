local keys = require("utils").keys
local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("nvim-telescope/telescope.nvim")
	local telescope = require("telescope")
	telescope.setup({
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			}
		}
	})

	local builtin = require("telescope.builtin")

	keys.lmap("n", "sf", builtin.find_files)
	keys.lmap("n", "sg", builtin.live_grep)
	keys.lmap("n", "sb", builtin.buffers)
	keys.lmap("n", "sr", builtin.resume)
end)

later(function()
	local post_hook = function(params) vim.system({ "make" }, { cwd = params.path }):wait() end

	add({
		source = "nvim-telescope/telescope-fzf-native.nvim",
		hooks = { post_install = post_hook, post_checkout = post_hook },
	})

	require("telescope").load_extension("fzf")
end)
