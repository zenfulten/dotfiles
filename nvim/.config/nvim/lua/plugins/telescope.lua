return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				sort_mru = true,
				sort_lastused = true,
				ignore_current_buffer = true,
				pickers = { buffers = { sort_lastused = true } },
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				defaults = {
					initial_mode = "insert",
					prompt_prefix = "   ",
					selection_caret = "▍ ",
					multi_icon = " ",
					entry_prefix = " ",
					path_display = { "truncate" },
					file_ignore_patterns = { "node_modules" },
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.70,
						},
						width = 0.87,
						height = 0.80,
					},
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
						n = { ["q"] = require("telescope.actions").close },
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
