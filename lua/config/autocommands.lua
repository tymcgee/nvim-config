Config.new_autocmd("FileType", nil, function() vim.opt.formatoptions:remove({ "c", "o" }) end, "Proper 'formatoptions'")
Config.new_autocmd("TextYankPost", nil, function() vim.highlight.on_yank() end, "Highlight on yank")
Config.new_autocmd("VimResized", nil, function() vim.cmd("tabdo wincmd =") end, "Resize splits")

local q_ft = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
end
Config.new_autocmd("FileType", {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "startuptime",
    "tsplayground",
    "checkhealth",
    "gitsigns-blame",
    "grug-far",
}, q_ft, "Close some filetypes with 'q'")

local autosave = function(event)
    if not vim.api.nvim_buf_is_loaded(event.buf) then
        return
    end
    vim.api.nvim_buf_call(event.buf, function() vim.cmd("silent! update") end)
end
Config.new_autocmd({ "BufLeave", "FocusLost" }, nil, autosave, "Autosave on switching buffers")

-- Some other filetype autocommands for simple stuff that I don't want to make a bunch of `after/` files for
local two_tab = function()
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.softtabstop = 2
end
Config.new_autocmd("FileType", {
    "javascript",
    "typescript",
    "typescriptreact",
    "scss",
    "css",
    "terraform",
}, two_tab, "Use two-space tabs")

local dash = function() vim.opt_local.iskeyword:append("-") end
Config.new_autocmd("FileType", { "css", "scss", "svelte" }, dash, "Add dashes to words")

local autofmt = function() vim.g.disable_autoformat = false end
Config.new_autocmd("FileType", { "templ", "go", "lua" }, autofmt, "Enable autoformatting")
