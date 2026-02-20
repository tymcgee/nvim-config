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
