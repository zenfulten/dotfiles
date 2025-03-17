local map = vim.keymap.set

--move in insert mode
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

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

-- toggle-term
map("n", "<leader>rt", ":ToggleTerm direction=float size=30<CR>")

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
map("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

local api = vim.api

api.nvim_set_keymap("n", "<C-c>", "gtc", { desc = "Toggle Comment", noremap = false })
api.nvim_set_keymap("v", "<C-c>", "goc", { desc = "Toggle Comment", noremap = false })
