local set_key = function(rhs, lhs, buf) vim.keymap.set("n", rhs, lhs, { buffer = buf, silent = true }) end

Config.new_autocmd("FileType", nil, function() vim.opt.formatoptions:remove({ "c", "o" }) end, "Proper 'formatoptions'")
Config.new_autocmd("TextYankPost", nil, function() vim.highlight.on_yank() end, "Highlight on yank")
Config.new_autocmd("VimResized", nil, function() vim.cmd("tabdo wincmd =") end, "Resize splits")

-- Close some filetypes with 'q'
local q_ft = function(event)
    vim.bo[event.buf].buflisted = false
    set_key("q", "<cmd>close<cr>", event.buf)
end
Config.new_autocmd("FileType", {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "startuptime",
    "tsplayground",
    "checkhealth",
    "gitsigns-blame",
    "grug-far",
    "nvim-undotree",
}, q_ft, "Close some filetypes with 'q'")

-- Close diffview tab with 'q'
local tab_close = function(ev) set_key("q", "<cmd>tabclose<cr>", ev.buf) end
Config.new_autocmd("FileType", { "DiffviewFiles" }, tab_close, "Close tab with 'q'")

-- Close oil window with 'q' (:close doesn't work well in this case)
local mini_close = function(ev) set_key("q", "<Cmd>lua MiniBufremove.delete()<CR>", ev.buf) end
Config.new_autocmd("FileType", { "oil" }, mini_close, "Close oil windows with 'q'")

-- Autosave
local autosave = function(event)
    if not vim.api.nvim_buf_is_loaded(event.buf) then
        return
    end
    vim.api.nvim_buf_call(event.buf, function() vim.cmd("silent! update") end)
end
Config.new_autocmd({ "BufLeave", "FocusLost" }, nil, autosave, "Autosave on switching buffers")

-- If you delete a file with oil, also delete its buffer (taken from https://github.com/stevearc/oil.nvim/issues/612#issuecomment-2828601810)
local delete_file = function(e)
    if e.data.actions == nil then
        return
    end
    for _, action in ipairs(e.data.actions) do
        if action.entry_type == "file" and action.type == "delete" then
            local file = action.url:sub(7)
            local bufnr = vim.fn.bufnr(file)

            if bufnr >= 0 then
                vim.api.nvim_buf_delete(bufnr, { force = true })
            end
        end
    end
end
Config.new_autocmd("User", "OilActionsPost", delete_file, "Delete buffer when deleting file")

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
