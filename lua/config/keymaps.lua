--stylua: ignore start
local cmd = function(rhs) return "<Cmd>" .. rhs .. "<CR>" end
local nmap_leader = function(suffix, rhs, desc) vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc }) end
local set = vim.keymap.set

-- Windows =============================================================================================================
nmap_leader("-", "<C-W>s",   "Split window below")
nmap_leader("|", "<C-W>v",   "Split window right")
nmap_leader("x",  cmd("tabclose"), "Close tab")

-- Git =================================================================================================================
nmap_leader("gh",  cmd("Gitsigns preview_hunk_inline"), "Toggle git hunk (inline)")
nmap_leader("gb",  cmd("Gitsigns blame"),               "Show git blame")
nmap_leader("gdf", cmd("Gitsigns diffthis"),            "Diff the current file")
nmap_leader("gg",  cmd("DiffviewOpen"),                 "Open current diff")
nmap_leader("gdc", cmd("DiffviewClose"),                "Close the diff (same as :tabclose)")
set("n", "[h", cmd("Gitsigns prev_hunk"), { desc = "Previous git hunk" })
set("n", "]h", cmd("Gitsigns next_hunk"), { desc = "Next git hunk" })

-- Search ==============================================================================================================
nmap_leader("sr",       cmd("GrugFar"),                                                      "Search and replace")
nmap_leader("<space>",  cmd("lua Snacks.picker.smart({filter = {cwd = true}})"),             "Files")
nmap_leader("<leader>", cmd("lua Snacks.picker.grep()"),                                     "Grep")
nmap_leader("sb",       cmd("lua Snacks.picker.buffers()"),                                  "Buffers")
nmap_leader("sh",       cmd("lua Snacks.picker.help()"),                                     "Vim help pages")
nmap_leader("sl",       cmd("lua Snacks.picker.lazy({layout = {preset = 'vscode'}})"),       "Plugin specs")
nmap_leader("sd",       cmd("lua Snacks.picker.diagnostics_buffer()"),                       "Document diagnostics")
nmap_leader("sD",       cmd("lua Snacks.picker.diagnostics()"),                              "Workspace diagnostics")
nmap_leader("sc",       cmd("lua Snacks.picker.git_log()"),                                  "Commits")
nmap_leader("sk",       cmd("lua Snacks.picker.keymaps()"),                                  "Keymaps")
nmap_leader("sm",       cmd("lua Snacks.picker.man()"),                                      "Man pages")
nmap_leader("sH",       cmd("lua Snacks.picker.highlights({layout = {preset = 'vscode'}})"), "Highlights")
nmap_leader("ss",       cmd("lua Snacks.picker.lsp_symbols()"),                              "LSP Symbols")
nmap_leader("sn",       cmd("lua Snacks.picker.notifications()"),                            "Notifications")
nmap_leader("u",        cmd("lua Snacks.picker.undo({layout = {preset = 'right'}})"),        "Undo")

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
nmap_leader("ca",  cmd("lua vim.lsp.buf.code_action()"),                                      "Code actions")
nmap_leader("cf",  cmd("lua require('conform').format({async = true, lsp_fallback = true})"), "Format document")
nmap_leader("cr",  cmd("lua require('live-rename').rename({text = '', insert = true})"),      "Rename symbol")
nmap_leader("cli", cmd("checkhealth vim.lsp"),                                                "LSP Info")
-- 0.12 might be changing this, LspRestart doesn't exist on nightly
if vim.fn.has("nvim-0.12.0") == 1 then
    nmap_leader("clr", cmd("lsp restart"), "Restart LSP")
else
    nmap_leader("clr", cmd("LspRestart"), "Restart LSP")
end

-- Other Plugins =======================================================================================================
nmap_leader("l",  cmd("Lazy"),  "Lazy")
nmap_leader("cm", cmd("Mason"), "Mason")

-- Split/terminal navigation
set({"n", "t"}, "<C-h>", cmd("lua require('kitty-navigator').navigateLeft()"),  {desc = "Move left"})
set({"n", "t"}, "<C-j>", cmd("lua require('kitty-navigator').navigateDown()"),  {desc = "Move down"})
set({"n", "t"}, "<C-k>", cmd("lua require('kitty-navigator').navigateUp()"),    {desc = "Move up"})
set({"n", "t"}, "<C-l>", cmd("lua require('kitty-navigator').navigateRight()"), {desc = "Move right"})

-- Session
-- note that from within the picker you can do ctrl+d to delete the highlighted session
nmap_leader("qc", cmd("AutoSession search"),       "Search sessions")
nmap_leader("qd", cmd("AutoSession deletePicker"), "Delete sessions")

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
