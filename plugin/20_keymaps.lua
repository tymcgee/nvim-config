--stylua: ignore start
local cmd = function(rhs) return "<Cmd>" .. rhs .. "<CR>" end
local nmap_leader = function(suffix, rhs, desc) vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc }) end
local set = vim.keymap.set

-- Windows =============================================================================================================
nmap_leader("-",  "<C-W>s",                                 "Split window below")
nmap_leader("|",  "<C-W>v",                                 "Split window right")
nmap_leader("x",  cmd("tabclose"),                          "Close tab")
nmap_leader("bD", cmd("lua MiniBufremove.delete(0, true)"), "Force delete buffer")
set("n", "<s-q>", cmd("lua MiniBufremove.delete()"), { desc = "Delete buffer" })

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
-- doing these in an autocommand so i don't overwrite the defaults
-- in buffers that don't have language servers
-- (particularly 'K' in man and help pages to follow links)
local lsp_keymaps = function(ev)
    local setl = function(lhs, rhs, desc, nowait) set("n", lhs, cmd(rhs), {desc = desc, buffer = ev.buf, nowait = nowait}) end
    setl("gd", "lua Snacks.picker.lsp_definitions()", "LSP Definition")
    setl("gr", "lua Snacks.picker.lsp_references()", "LSP References", true)
    setl("gi", "lua Snacks.picker.lsp_implementations()", "LSP Implementation")
    setl("gt", "lua Snacks.picker.lsp_type_definitions()", "LSP Type definition")
    setl("gs", "lua vim.lsp.buf.signature_help()", "LSP Signature help")
    setl("gl", "lua vim.diagnostic.open_float()", "Open diagnostic float")
    setl("K",  "lua vim.lsp.buf.hover()", "LSP Hover")
    setl("[d", "lua vim.diagnostic.jump({count = 1, float = true})", "Go to prev diagnostic")
    setl("]d", "lua vim.diagnostic.jump({count = -1, float = true})", "Go to next diagnostic")
end
Config.new_autocmd("LspAttach", nil, lsp_keymaps, "LSP Keymaps")
nmap_leader("ca",  cmd("lua vim.lsp.buf.code_action()"),                                      "Code actions")
nmap_leader("cf",  cmd("lua require('conform').format({async = true, lsp_fallback = true})"), "Format document")
nmap_leader("cr",  cmd("lua require('live-rename').rename({text = '', insert = true})"),      "Rename symbol")
nmap_leader("cli", cmd("checkhealth vim.lsp"),                                                "LSP Info")
-- 0.12 changed this
local is_12 = vim.fn.has("nvim-0.12.0") == 1
local lsp_restart = is_12 and "lsp restart" or "LspRestart"
nmap_leader("clr", cmd(lsp_restart), "Restart LSP")

-- Other Plugins =======================================================================================================
nmap_leader("ls", function() vim.pack.update(nil, { target = 'lockfile' }) end, "Sync plugins with lockfile")
nmap_leader("lu", function() vim.pack.update() end, "Update plugins")
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

-- Files
nmap_leader("e", cmd("Oil"), "Open file explorer")
nmap_leader("E", cmd("Oil ."), "Open CWD")

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
