vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
vim.g.python_highlight_all = 1

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.list = false
vim.opt.shell = "/bin/bash" -- Helps tmux navigator not be so slow

vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.conceallevel = 3 -- Hide * markup for bold and italic
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true -- Ignore case
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.shiftround = true -- Round indent to nearest multiple of shiftwidth
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.showmode = false -- Dont show mode since we have a statusline
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.tabstop = 4 -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.wrap = false -- Disable line wrap
vim.opt.splitkeep = "screen"
vim.opt.virtualedit = "block" -- Allow virtual block mode to extend past a line
vim.opt.sessionoptions = vim.opt.sessionoptions + "globals"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

vim.filetype.add({
    extension = {
        templ = "templ",
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
