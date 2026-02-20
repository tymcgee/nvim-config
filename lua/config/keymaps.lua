--stylua: ignore start
local nmap_leader = function(suffix, rhs, desc) vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc }) end
local nmap_l_cmd = function(suffix, rhs, desc) 
    local cmd = "<Cmd>" .. rhs .. "<CR>"
    vim.keymap.set("n", "<Leader>" .. suffix, cmd, {desc = desc})
end

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- auto-indent pasted text. `[ and `] are marks for the previously changed/yanked text
vim.keymap.set({ "n", "v" }, "p", "p`[v`]=<esc>_")
vim.keymap.set({ "n", "v" }, "P", "P`[v`]=<esc>_")

-- copy and paste from clipboard
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p')

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Normal mode in terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- windows
nmap_leader("-", "<C-W>s", "Split window below")
nmap_leader("|", "<C-W>v", "Split window right")

-- gitsigns
nmap_leader("gh", "<Cmd>Gitsigns preview_hunk_inline<CR>", "Toggle git hunk (inline)")
nmap_leader("gb", "<Cmd>Gitsigns blame<CR>",               "Show git blame")
nmap_leader("gd", "<Cmd>Gitsigns diffthis<CR>",            "Diff the current file")
-- TODO: figure out a clean way to exit out of the diff. right now i have to move to the diffed buffer and :q it
vim.keymap.set("n", "[h", "<Cmd>Gitsigns prev_hunk<CR>", { desc = "Previous git hunk" })
vim.keymap.set("n", "]h", "<Cmd>Gitsigns next_hunk<CR>", { desc = "Next git hunk" })

-- search
nmap_leader("sr",      "<Cmd>GrugFar<CR>",                                             "Search and replace")
nmap_l_cmd("<space>",  "lua Snacks.picker.grep()",                                     "Files")
nmap_l_cmd("<leader>", "lua Snacks.picker.smart({filter = {cwd = true}})",             "Files")
nmap_l_cmd("sb",       "lua Snacks.picker.buffers()",                                  "Buffers")
nmap_l_cmd("sh",       "lua Snacks.picker.help()",                                     "Vim help pages")
nmap_l_cmd("sl",       "lua Snacks.picker.lazy({layout = {preset = 'vscode'}})",       "Plugin specs")
nmap_l_cmd("sd",       "lua Snacks.picker.diagnostics_buffer()",                       "Document diagnostics")
nmap_l_cmd("sD",       "lua Snacks.picker.diagnostics()",                              "Workspace diagnostics")
nmap_l_cmd("sc",       "lua Snacks.picker.git_log()",                                  "Commits")
nmap_l_cmd("sm",       "lua Snacks.picker.man()",                                      "Man pages")
nmap_l_cmd("sH",       "lua Snacks.picker.highlights({layout = {preset = 'vscode'}})", "Highlights")
nmap_l_cmd("ss",       "lua Snacks.picker.lsp_symbols()",                              "LSP Symbols")
nmap_l_cmd("sn",       "lua Snacks.picker.notifications()",                            "Notifications")
nmap_l_cmd("u",        "lua Snacks.picker.undo({layout = {preset = 'right'}})",        "Undo")

-- lsp
vim.keymap.set("n", "gd", "<Cmd>lua Snacks.picker.lsp_definitions()",      { desc = "Definition" })
vim.keymap.set("n", "gr", "<Cmd>lua Snacks.picker.lsp_references()",       { desc = "References (LSP)", nowait = true })
vim.keymap.set("n", "gi", "<Cmd>lua Snacks.picker.lsp_implementations()",  { desc = "Implementation" })
vim.keymap.set("n", "gt", "<Cmd>lua Snacks.picker.lsp_type_definitions()", { desc = "Type definition" })
