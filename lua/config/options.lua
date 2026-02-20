vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings
vim.g.python_highlight_all = 1
vim.cmd("filetype plugin indent on")
if vim.fn.exists("syntax_on") ~= 1 then
    vim.cmd("syntax enable")
end
-- General ========================================================
vim.opt.backupcopy = "yes" -- helps with HMR in bun
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.grepprg = "rg --vimgrep"
vim.opt.sessionoptions = vim.opt.sessionoptions + "globals"
vim.opt.swapfile = false
vim.opt.termguicolors = true -- True color support
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- UI =============================================================
vim.opt.breakindent = true -- Wrapped lines in, say, markdown files, will respect indentation
vim.opt.cmdheight = 0
vim.opt.conceallevel = 3 -- Hide * markup for bold and italic
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = "screen"
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.wrap = false -- Disable line wrap

-- Folds
vim.o.foldlevel = 10 -- Fold nothing by default
vim.o.foldmethod = "indent" -- Fold based on indent level
vim.o.foldnestmax = 10 -- Limit number of fold levels
vim.o.foldtext = "" -- Show text under fold with its highlighting

-- Editing ========================================================
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.formatoptions = "rqnl1j" -- Improve comment editing (note this is further edited with an autocommand)
vim.opt.ignorecase = true -- Ignore case
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.shiftround = true -- Round indent to nearest multiple of shiftwidth
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.spelllang = { "en" }
vim.opt.tabstop = 4 -- Number of spaces tabs count for
vim.opt.virtualedit = "block" -- Allow virtual block mode to extend past a line
vim.opt.completeopt = "menu,menuone,noselect"

vim.filetype.add({
    extension = {
        templ = "templ",
        tmpl = "html",
    },
})

vim.filetype.add({
    filename = {
        ["docker-compose.yml"] = "yaml.docker-compose",
        ["docker-compose.yaml"] = "yaml.docker-compose",
        ["compose.yml"] = "yaml.docker-compose",
        ["compose.yaml"] = "yaml.docker-compose",
    },
})

local signs = {
    Error = " ",
    Information = " ",
    Hint = " ",
    Warn = " ",
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- neovide stuff
vim.o.guifont = "JetBrainsMono Nerd Font Mono:h16"
vim.g.neovide_scroll_animation_length = 0.1 -- 0.3 is default
vim.g.neovide_cursor_animation_length = 0.03 -- 0.13 is default
vim.g.neovide_cursor_trail_size = 0.2 -- 0.8 is default
-- some weird gui stuff for getting copy paste to work (copied from neovide faq)
-- on non-mac, the copy/paste bindings are control+<key>
-- on mac, it is cmd+<key>
local is_mac = jit.os == "OSX"
if vim.g.neovide then
    -- stylua: ignore start
    local modifier = "c"
    if is_mac then modifier = "D" end
    local function cmd(mod, key) return "<" .. mod .. "-" .. key .. ">" end
    vim.keymap.set("v", cmd(modifier, "c"), '"+y') -- Copy
    vim.keymap.set("n", cmd(modifier, "v"), '"+P') -- Paste normal mode
    vim.keymap.set("v", cmd(modifier, "v"), '"+P') -- Paste visual mode
    vim.keymap.set("c", cmd(modifier, "v"), "<C-R>+") -- Paste command mode
    vim.keymap.set("i", cmd(modifier, "v"), '<ESC>"+Pi') -- Paste insert mode (doesn't quite behave great, but whatever)
    -- stylua: ignore end
end
