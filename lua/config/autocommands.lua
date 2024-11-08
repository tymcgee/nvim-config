vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.opt.formatoptions:remove({ "c", "o" })
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
        "saga_code_action",
        "sagarename",
        "toggleterm",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- autosave on switching buffers
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
    callback = function(event)
        if not vim.api.nvim_buf_is_loaded(event.buf) then
            return
        end

        vim.api.nvim_buf_call(event.buf, function()
            vim.cmd("silent! update")
            -- vim.print("Saved")
            -- vim.fn.timer_start(1000, function()
            --     vim.print("")
            -- end)
        end)
    end,
})
