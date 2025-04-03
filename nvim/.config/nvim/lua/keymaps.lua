local map = vim.keymap.set

--move in insert mode
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

--line number
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

-- Lsp keymap
map("n", "<leader>K", vim.lsp.buf.hover, { desc = "Lsp hover" })
map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Lsp definition" })
map("n", "<leader>gr", vim.lsp.buf.references, { desc = "Lsp references" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Neo Tree
map("n", "<leader>e", ":Neotree filesystem reveal left<CR>", { desc = "File Explorer" })
map("n", "<leader>rr", ":Neotree filesystem reveal right<CR>", { desc = "File Explorer" })
map("n", "<leader>bf", ":Neotree buffers reveal float<CR>", { desc = "Buffer Explorer" })
map("n", "<leader>qe", ":Neotree close<CR>", { desc = "Close File Explorer" })

-- telescope
local builtin = require("telescope.builtin")
map("n", "<leader>fp", builtin.find_files, { desc = "Find Files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
map("n", "<leader><leader>", builtin.oldfiles, { desc = "Find Old Files" })
map("n", "<leader>fz", builtin.current_buffer_fuzzy_find, { desc = "Telescope find in current buffer" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope find buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- BufferLine
map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
map("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
map("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
map("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })

-- toggle-term
map("n", "<leader>rt", ":ToggleTerm<CR>", { desc = "ToggleTerm" })

-- Navigate vim panes better
map("n", "<c-k>", ":wincmd k<CR>")
map("n", "<c-j>", ":wincmd j<CR>")
map("n", "<c-h>", ":wincmd h<CR>")
map("n", "<c-l>", ":wincmd l<CR>")

--Todo
map("n", "<leader>I", ":TodoTelescope<CR>", { desc = "TodoTelescope" })

-- save files
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- New File
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

--alpha
map("n", "<leader>h", ":Alpha<CR>", { desc = "󰠅 Alpha" })

--quit all
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

--make jk key to ESC
map("i", "jk", "<esc>", { desc = "Normal Mode" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

--flutter tools
map("n", "<leader>fd", "<cmd> FlutterDevices <CR>", { desc = "Flutter devices" })
map("n", "<leader>fD", "<cmd> FlutterDetatch <CR>", { desc = "Flutter detatch" })
map("n", "<leader>ff", "<cmd> FlutterRun <CR>", { desc = "Flutter run" })
map("n", "<leader>fq", "<cmd> FlutterQuit <CR>", { desc = "Flutter quit" })
map("n", "<leader>fr", "<cmd> FlutterReload <CR>", { desc = "Flutter reload" })
map("n", "<leader>fR", "<cmd> FlutterRestart <CR>", { desc = "Flutter restart" })
map("n", "<leader>fU", "<cmd> FlutterPubUpgrade <CR>", { desc = "Flutter pub upgrade" })
map("n", "<leader>fu", "<cmd> FlutterPubGet <CR>", { desc = "Flutter pub get" })

-- windows
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>rw", "<C-W>c", { desc = "Delete Window", remap = true })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
map("n", "<leader>wk", function()
	vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })

local api = vim.api

api.nvim_set_keymap("n", "<C-c>", "gtc", { desc = "Toggle Comment", noremap = false })
api.nvim_set_keymap("v", "<C-c>", "goc", { desc = "Toggle Comment", noremap = false })
