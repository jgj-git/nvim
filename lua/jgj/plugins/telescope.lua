return {
	"nvim-telescope/telescope.nvim",
    version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
					},
				},
			},
		})
		--telescope.load_extension("fzf_native")
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fl", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>D", function() builtin.diagnostics{bufnr = 0} end, {})
		vim.keymap.set("n", "<leader>gD", builtin.diagnostics, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>fw", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>fW", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>fs", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        vim.keymap.set("n", "gR", builtin.lsp_references, {})
        vim.keymap.set("n", "gd", builtin.lsp_definitions, {})
        vim.keymap.set("n", "gi", builtin.lsp_implementations, {})
        vim.keymap.set("n", "gs", builtin.lsp_document_symbols, {})
        vim.keymap.set("n", "gy", builtin.lsp_type_definitions, {})
	end,
}
