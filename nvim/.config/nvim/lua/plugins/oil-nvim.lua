return {
	"stevearc/oil.nvim",
	opts = {
		columns = {
			"permissions",
			"size",
			"mtime",
			"icon",
		},
		delete_to_trash = true,
	},
	keys = {
		{
			"-",
			"<cmd>Oil<CR>",
			desc = "Open Oil File Manager",
		},
	},
}
