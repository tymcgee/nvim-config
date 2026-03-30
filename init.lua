-- (stolen from MiniMax)
-- This is a global variable accessible either through `_G.Config` or `Config`
_G.Config = {}

Config.gh = function(pkg) return "https://github.com/" .. pkg end

-- Helper to create custom autocommands
local augroup = vim.api.nvim_create_augroup("custom-config", {})
Config.new_autocmd = function(event, pattern, callback, desc)
    local opts = { group = augroup, pattern = pattern, callback = callback, desc = desc }
    vim.api.nvim_create_autocmd(event, opts)
end

-- Custom `vim.pack.add()` hook helper (from minimax)
-- stylua: ignore start
Config.on_packchanged = function(plugin_name, kinds, callback, desc)
    local f = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
        if not ev.data.active then vim.cmd.packadd(plugin_name) end
        callback()
    end
    Config.new_autocmd('PackChanged', '*', f, desc)
end
-- stylua: ignore end

-- auto-launch the session chooser if opening neovide
if vim.g.neovide then
    vim.schedule(function() vim.cmd("AutoSession search") end)
end

-- other language servers not controlled by mason
vim.lsp.enable("gleam")
