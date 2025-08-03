local keys = require("utils").keys

vim.lsp.enable({ "lua_ls", "elixirls", "tailwindcss", "ruby_lsp" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function()
		local builtin = require("telescope.builtin")

		keys.map("n", "grn", vim.lsp.buf.rename, "Rename")
		keys.map({ "n", "x" }, "gra", vim.lsp.buf.code_action, "Goto Code Actions")
		keys.map("n", "grr", builtin.lsp_references, "Goto References")
		keys.map("n", "gri", builtin.lsp_implementations, "Goto Implementation")
		keys.map("n", "grd", builtin.lsp_definitions, "Goto Defininition")
		keys.map("n", "grD", vim.lsp.buf.declaration, "Goto Declaration")
		keys.map("n", "gO", builtin.lsp_document_symbols, "Goto Document Symbol")
		keys.map("n", "gW", builtin.lsp_dynamic_workspace_symbols, "Goto Workspace Symbol")
	end
})
