--stylua: ignore start
local cmd = function(rhs) return "<Cmd>" .. rhs .. "<CR>" end
local nmap_leader = function(suffix, rhs, desc) vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc }) end
local nmap_l_cmd = function(suffix, rhs, desc) vim.keymap.set("n", "<Leader>" .. suffix, cmd(rhs), {desc = desc}) end
local set = vim.keymap.set

-- Windows =============================================================================================================
nmap_leader("-", "<C-W>s",   "Split window below")
nmap_leader("|", "<C-W>v",   "Split window right")
nmap_l_cmd("x",  "tabclose", "Close tab")

-- Git =================================================================================================================
nmap_l_cmd("gh",  "Gitsigns preview_hunk_inline", "Toggle git hunk (inline)")
nmap_l_cmd("gb",  "Gitsigns blame",               "Show git blame")
nmap_l_cmd("gdf", "Gitsigns diffthis",            "Diff the current file")
nmap_l_cmd("gg",  "DiffviewOpen",                 "Open current diff")
nmap_l_cmd("gdc", "DiffviewClose",                "Close the diff (same as :tabclose)")
set("n", "[h", cmd("Gitsigns prev_hunk"), { desc = "Previous git hunk" })
set("n", "]h", cmd("Gitsigns next_hunk"), { desc = "Next git hunk" })

-- Search ==============================================================================================================
nmap_leader("sr",      cmd("GrugFar"),                                                 "Search and replace")
nmap_l_cmd("<space>",  "lua Snacks.picker.smart({filter = {cwd = true}})",             "Files")
nmap_l_cmd("<leader>", "lua Snacks.picker.grep()",                                     "Grep")
nmap_l_cmd("sb",       "lua Snacks.picker.buffers()",                                  "Buffers")
nmap_l_cmd("sh",       "lua Snacks.picker.help()",                                     "Vim help pages")
nmap_l_cmd("sl",       "lua Snacks.picker.lazy({layout = {preset = 'vscode'}})",       "Plugin specs")
nmap_l_cmd("sd",       "lua Snacks.picker.diagnostics_buffer()",                       "Document diagnostics")
nmap_l_cmd("sD",       "lua Snacks.picker.diagnostics()",                              "Workspace diagnostics")
nmap_l_cmd("sc",       "lua Snacks.picker.git_log()",                                  "Commits")
nmap_l_cmd("sk",       "lua Snacks.picker.keymaps()",                                  "Keymaps")
nmap_l_cmd("sm",       "lua Snacks.picker.man()",                                      "Man pages")
nmap_l_cmd("sH",       "lua Snacks.picker.highlights({layout = {preset = 'vscode'}})", "Highlights")
nmap_l_cmd("ss",       "lua Snacks.picker.lsp_symbols()",                              "LSP Symbols")
nmap_l_cmd("sn",       "lua Snacks.picker.notifications()",                            "Notifications")
nmap_l_cmd("u",        "lua Snacks.picker.undo({layout = {preset = 'right'}})",        "Undo")

-- LSP =================================================================================================================
set("n", "gd", cmd("lua Snacks.picker.lsp_definitions()"),                 { desc = "Definition" })
set("n", "gr", cmd("lua Snacks.picker.lsp_references()"),                  { desc = "References (LSP)", nowait = true })
set("n", "gi", cmd("lua Snacks.picker.lsp_implementations()"),             { desc = "Implementation" })
set("n", "gt", cmd("lua Snacks.picker.lsp_type_definitions()"),            { desc = "Type definition" })
set("n", "gs", cmd("lua vim.lsp.buf.signature_help()"),                    { desc = "Signature help" })
set("n", "gl", cmd("lua vim.diagnostic.open_float()"),                     { desc = "Open diagnostic float" })
set("n", "K",  cmd("lua vim.lsp.buf.hover()"),                             { desc = "Hover" })
set("n", "[d", cmd("lua vim.diagnostic.jump({count = 1, float = true})"),  { desc = "Go to prev diagnostic" })
set("n", "]d", cmd("lua vim.diagnostic.jump({count = -1, float = true})"), { desc = "Go to next diagnostic" })
nmap_l_cmd("ca",  "lua vim.lsp.buf.code_action()",                                      "Code actions")
nmap_l_cmd("cf",  "lua require('conform').format({async = true, lsp_fallback = true})", "Format document")
nmap_l_cmd("cr",  "lua require('live-rename').rename({text = '', insert = true})",      "Rename symbol")
nmap_l_cmd("cli", "checkhealth vim.lsp",                                                "LSP Info")
-- 0.12 might be changing this, LspRestart doesn't exist on nightly
if vim.fn.has("nvim-0.12.0") == 1 then
    nmap_l_cmd("clr", "lsp restart", "Restart LSP")
else
    nmap_l_cmd("clr", "LspRestart", "Restart LSP")
end

-- Misc ================================================================================================================
-- Better up/down
set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Auto-indent pasted text. `[ and `] are marks for the previously changed/yanked text
set({ "n", "v" }, "p", "p`[v`]=<esc>_")
set({ "n", "v" }, "P", "P`[v`]=<esc>_")

-- Copy and paste from clipboard
set({ "n", "v", "x" }, "<leader>y", '"+y')
set({ "n", "v", "x" }, "<leader>p", '"+p')

-- Clear search with <esc>
set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Add undo break-points
set("i", ",", ",<c-g>u")
set("i", ".", ".<c-g>u")
set("i", ";", ";<c-g>u")

-- Normal mode in terminal
set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- Other plugins
nmap_l_cmd("l", "Lazy", "Lazy")
nmap_l_cmd("cm", "Mason", "Mason")

-- Split/terminal navigation
set({"n", "t"}, "<C-h>", cmd("lua require('kitty-navigator').navigateLeft()"),  {desc = "Move left"})
set({"n", "t"}, "<C-j>", cmd("lua require('kitty-navigator').navigateDown()"),  {desc = "Move down"})
set({"n", "t"}, "<C-k>", cmd("lua require('kitty-navigator').navigateUp()"),    {desc = "Move up"})
set({"n", "t"}, "<C-l>", cmd("lua require('kitty-navigator').navigateRight()"), {desc = "Move right"})

-- Session
-- note that from within the picker you can do ctrl+d to delete the highlighted session
nmap_l_cmd("qc", "AutoSession search", "Search sessions")
nmap_l_cmd("qd", "AutoSession deletePicker", "Delete sessions")
