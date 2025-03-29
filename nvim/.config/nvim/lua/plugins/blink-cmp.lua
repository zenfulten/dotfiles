return {
	"saghen/blink.cmp",
	dependencies = {
		{ "saghen/blink.compat", opts = { enable_events = true } },
		{
			"Exafunction/codeium.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			opts = {},
		},
	},
	lazy = false, -- lazy loading handled internally
	version = "v0.*",
	---@module 'blink.cmp'
	opts = {
		keymap = { preset = "default" },
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		sources = {
			default = { "codeium", "lsp", "path", "snippets", "buffer" },
			providers = {
				codeium = {
					name = "codeium",
					module = "blink.compat.source",
					score_offset = 3,
				},
			},
		},
		completion = {
			menu = {
				border = "single",
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
					},
				},
			},
			documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = "single" } },
		},
		signature = { enabled = true, window = { border = "single" } },
	},
	opts_extend = { "sources.default" },
}
