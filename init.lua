-- (stolen from MiniMax)
-- This is a global variable accessible either through `_G.Config` or `Config`
_G.Config = {}

-- Helper to create custom autocommands
local augroup = vim.api.nvim_create_augroup("custom-config", {})
Config.new_autocmd = function(event, pattern, callback, desc)
    local opts = { group = augroup, pattern = pattern, callback = callback, desc = desc }
    vim.api.nvim_create_autocmd(event, opts)
end

require("config.autocommands")
require("config.options")
require("config.keymaps")
require("install-lsps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "plugins" },
}, {
    change_detection = {
        enabled = false,
        notify = false,
    },
})

-- auto-launch the session chooser if opening neovide
if vim.g.neovide then
    vim.schedule(function() vim.cmd("AutoSession search") end)
end

-- other language servers not controlled by mason
vim.lsp.enable("gleam")
