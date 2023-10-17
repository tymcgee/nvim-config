return {

    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        -- TODO: remove, null-ls is archived
        local nls = require("null-ls")
        nls.setup({
            sources = {
                nls.builtins.formatting.stylua,
                nls.builtins.diagnostics.luacheck,
                nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
                -- nls.builtins.diagnostics.ruff,
                nls.builtins.formatting.shfmt,
                nls.builtins.formatting.yamlfmt,
                nls.builtins.formatting.fixjson,
                nls.builtins.formatting.rustfmt,
                -- nls.builtins.code_actions.typescript,
            },
        })
    end,
}
