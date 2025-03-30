return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	-- config = function()
	-- end,
	opts = {
		close_if_last_window = true,
		popup_border_style = "rounded",
		sort_case_insensitive = true,

		source_selector = {
			winbar = false,
			show_scrolled_off_parent_node = true,
			padding = { left = 1, right = 0 },
			sources = {
				{ source = "filesystem", display_name = "  Files" }, --      
				{ source = "buffers", display_name = "  Buffers" }, --      
				{ source = "git_status", display_name = " 󰊢 Git" }, -- 󰊢      
			},
		},
		event_handlers = {
			-- Close neo-tree when opening a file.
			{
				event = "file_opened",
				handler = function()
					require("neo-tree").close_all()
				end,
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = false,
			},
			icon = {
				folder_empty = "",
				folder_empty_open = "",
				default = "",
			},
			modified = {
				symbol = "•",
			},
			name = {
				trailing_slash = true,
				highlight_opened_files = true,
				use_git_status_colors = false,
			},
			git_status = {
				symbols = {
					-- Change type
					added = "",
					deleted = "",
					modified = "󰊢",
					renamed = "",
					-- Status type
					untracked = "",
					ignored = "",
					unstaged = "",
					staged = "󰊢",
					conflict = "",
				},
			},
		},
		window = {
			width = 25, -- Default 40
			mappings = {
				["q"] = "close_window",
				["?"] = "noop",
				["g?"] = "show_help",
				["<leader>"] = "noop",
			},
		},
		iltered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_by_name = {
				".git",
				".hg",
				".svc",
				".DS_Store",
				"thumbs.db",
				".sass-cache",
				"node_modules",
				".pytest_cache",
				".mypy_cache",
				"__pycache__",
				".stfolder",
				".stversions",
			},
		},
	},
}
