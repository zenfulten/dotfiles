return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = {

			-- "   _____                            _____   ",
			-- "  ( ___ )--------------------------( ___ )  ",
			-- "   |   |                            |   |   ",
			-- "   |   |                            |   |   ",
			-- "   |   |                            |   |   ",
			-- "   |   |                            |   |   ",
			-- "   |   |    ██████╗ ██╗ ██████╗     |   |   ",
			-- "   |   |    ██╔══██╗██║██╔═══██╗    |   |   ",
			-- "   |   |    ██████╔╝██║██║   ██║    |   |   ",
			-- "   |   |    ██╔══██╗██║██║   ██║    |   |   ",
			-- "   |   |    ██║  ██║██║╚██████╔╝    |   |   ",
			-- "   |   |    ╚═╝  ╚═╝╚═╝ ╚═════╝     |   |   ",
			-- "   |   |                            |   |   ",
			-- "   |   |                            |   |   ",
			-- "   |   |                            |   |   ",
			-- "   |___|                            |___|   ",
			-- "  (_____)--------------------------(_____)  ",
			-- "                                            ",
			--
			"                                                           ",
			"   ██████╗ ██╗███╗   ██╗██████╗ ███████╗███████╗██╗  ██╗   ",
			"   ██╔══██╗██║████╗  ██║██╔══██╗██╔════╝██╔════╝██║  ██║   ",
			"   ██████╔╝██║██╔██╗ ██║██║  ██║█████╗  ███████╗███████║   ",
			"   ██╔══██╗██║██║╚██╗██║██║  ██║██╔══╝  ╚════██║██╔══██║   ",
			"   ██████╔╝██║██║ ╚████║██████╔╝███████╗███████║██║  ██║   ",
			"   ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝   ",
			"                                                           ",
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("n", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("SPC e", "  > Toggle file explorer", "<cmd>Neotree filesystem reveal left<CR>"),
			dashboard.button("SPC fp", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("SPC fg", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
