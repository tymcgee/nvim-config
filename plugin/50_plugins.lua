local gh = Config.gh

vim.pack.add({
    -- lsp
    gh("neovim/nvim-lspconfig"),
    gh("mason-org/mason.nvim"),
    gh("mason-org/mason-lspconfig.nvim"),

    -- git
    gh("lewis6991/gitsigns.nvim"),
    gh("sindrets/diffview.nvim"), -- :help diff-mode for some more info on how this works natively

    -- terminal
    gh("MunsMan/kitty-navigator.nvim"), -- note: don't forget to copy the .py files into ~/.config/kitty on a new machine
    { src = "https://github.com/mikesmithgh/kitty-scrollback.nvim", version = vim.version.range("^9.0.0") },

    gh("navarasu/onedark.nvim"),
    gh("windwp/nvim-autopairs"),
    gh("nmac427/guess-indent.nvim"),
    gh("MagicDuck/grug-far.nvim"),
    gh("saghen/blink.indent"),
    gh("saecki/live-rename.nvim"),
    gh("MeanderingProgrammer/render-markdown.nvim"),
    gh("folke/snacks.nvim"),
    gh("stevearc/oil.nvim"),
})
require("kitty-scrollback").setup()

-- don't make sessions when using kitty scrollback
if vim.env.KITTY_SCROLLBACK_NVIM ~= "true" then
    vim.pack.add({ gh("rmagatti/auto-session") })
    require("auto-session").setup()
end

require("onedark").load()
require("mason").setup()
require("mason-lspconfig").setup()
require("diffview").setup({ file_panel = { listing_style = "list" } })
require("nvim-autopairs").setup()
require("guess-indent").setup()
require("render-markdown").setup({ render_modes = { "n", "c", "i" }, completions = { lsp = { enabled = true } } })

-- snacks
require("snacks").setup({
    input = { enabled = true },
    picker = { enabled = true },
    image = { enabled = true },
})

-- file picker (oil)
require("oil").setup({
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    cleanup_delay_ms = 300, -- default is 2000, but i want a quick ctrl+o not to go back to oil
    view_options = {
        show_hidden = true,
        is_always_hidden = function(name, bufnr) return name == ".git" or name == ".jj" end,
    },
    keymaps = {
        -- don't conflict with terminal navigator
        ["<C-l>"] = false,
        ["<C-h>"] = false,
    },
})

-- stole this "background"-ish color from indent-blankline.nvim's default config... idk man
vim.api.nvim_set_hl(0, "BlinkIndent", { fg = "#31353f" })
