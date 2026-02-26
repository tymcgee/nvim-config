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
nmap_l_cmd("l", "Lazy", "Lazy")

-- Normal mode in terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- windows
nmap_leader("-", "<C-W>s", "Split window below")
nmap_leader("|", "<C-W>v", "Split window right")
nmap_l_cmd("x", "tabclose", "Close tab")

-- git
nmap_l_cmd("gh",  "Gitsigns preview_hunk_inline", "Toggle git hunk (inline)")
nmap_l_cmd("gb",  "Gitsigns blame",               "Show git blame")
nmap_l_cmd("gdf", "Gitsigns diffthis",            "Diff the current file")
nmap_l_cmd("gg", "DiffviewOpen",                 "Open current diff")
nmap_l_cmd("gdc", "DiffviewClose",                "Close the diff (same as :tabclose)")
-- TODO: figure out a clean way to exit out of the diff. right now i have to move to the diffed buffer and :q it
vim.keymap.set("n", "[h", "<Cmd>Gitsigns prev_hunk<CR>", { desc = "Previous git hunk" })
vim.keymap.set("n", "]h", "<Cmd>Gitsigns next_hunk<CR>", { desc = "Next git hunk" })

-- search
nmap_leader("sr",      "<Cmd>GrugFar<CR>",                                             "Search and replace")
nmap_l_cmd("<space>",  "lua Snacks.picker.smart({filter = {cwd = true}})",             "Files")
nmap_l_cmd("<leader>", "lua Snacks.picker.grep()",                                     "Files")
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
vim.keymap.set("n", "gd", "<Cmd>lua Snacks.picker.lsp_definitions()<CR>",      { desc = "Definition" })
vim.keymap.set("n", "gr", "<Cmd>lua Snacks.picker.lsp_references()<CR>",       { desc = "References (LSP)", nowait = true })
vim.keymap.set("n", "gi", "<Cmd>lua Snacks.picker.lsp_implementations()<CR>",  { desc = "Implementation" })
vim.keymap.set("n", "gt", "<Cmd>lua Snacks.picker.lsp_type_definitions()<CR>", { desc = "Type definition" })

-- session
-- note that from within the picker you can do ctrl+d to delete the highlighted session
nmap_l_cmd("qc", "AutoSession search", "Search sessions")
nmap_l_cmd("qd", "AutoSession deletePicker", "Delete sessions")
