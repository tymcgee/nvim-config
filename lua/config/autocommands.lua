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
}, q_ft, "Close some filetypes with 'q'")

local autosave = function(event)
    if not vim.api.nvim_buf_is_loaded(event.buf) then
        return
    end
    vim.api.nvim_buf_call(event.buf, function() vim.cmd("silent! update") end)
end
Config.new_autocmd({ "BufLeave", "FocusLost" }, nil, autosave, "Autosave on switching buffers")

-- from the snacks notify docs, simple lsp progress notification (replaces fidget.nvim)
local progress = function(ev)
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(vim.lsp.status(), "info", {
        id = "lsp_progress",
        title = "LSP Progress",
        opts = function(notif)
            notif.icon = ev.data.params.value.kind == "end" and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
    })
end
Config.new_autocmd("LspProgress", nil, progress, "LSP Progress")
