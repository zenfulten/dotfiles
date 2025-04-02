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
			kind_icons = {
				Text = "󰉿",
				Method = "󰊕",
				Function = "󰊕",
				Constructor = "󰒓",

				Field = "󰜢",
				Variable = "󰆦",
				Property = "",

				Class = "󱡠",
				Interface = "󱡠",
				Struct = "󱡠",
				Module = "󰅩",

				Unit = "󰪚",
				Value = "󰦨",
				Enum = "󰦨",
				EnumMember = "󰦨",

				Keyword = "󰻾",
				Constant = "󰏿",

				Snippet = "󱄽",
				Color = "󰏘",
				File = "󰈔",
				Reference = "󰬲",
				Folder = "󰉋",
				Event = "󱐋",
				Operator = "󰪚",
				TypeParameter = "󰬛",
			},
		},
		sources = {
			default = { "codeium", "lsp", "path", "snippets", "buffer" },
			providers = {
				codeium = {
					name = "codeium",
					module = "blink.compat.source",
					score_offset = 100,
					async = true,
				},
			},
		},
		completion = {
			menu = {
				border = "rounded",
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
					},
				},
			},
			documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = "rounded" } },
		},
		signature = { enabled = false, window = { border = "rounded" } },
		cmdline = {
			keymap = {
				["<Tab>"] = { "show", "accept" },
			},
			completion = { menu = { auto_show = true } },
		},
	},
	opts_extend = { "sources.default" },
}
