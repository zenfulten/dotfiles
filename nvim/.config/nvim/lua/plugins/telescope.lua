return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				defaults = {
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
						n = { ["q"] = require("telescope.actions").close },
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
