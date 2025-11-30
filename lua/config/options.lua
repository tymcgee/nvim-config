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
vim.opt.cmdheight = 0
vim.opt.backupcopy = "yes" -- helps with HMR in bun
vim.opt.breakindent = true -- Wrapped lines in, say, markdown files, will respect indentation

-- Sync OS clipboard with neovim.
-- Scheduled after 'UIEnter' because it can increase startup time.
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings
vim.g.undotree_WindowLayout = 4

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
