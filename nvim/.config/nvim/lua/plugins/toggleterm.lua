return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("toggleterm").setup({
				start_in_insert = true,
				insert_mappings = true,
				close_on_exit = true,
				direction = "float",
				size = 30,
				float_opts = {
					border = "curved",
				},
			})
		end,
	},
}
