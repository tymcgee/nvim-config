return {
    "luukvbaal/statuscol.nvim",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            ft_ignore = { "neo-tree" },
            segments = {
                -- Put todos and diagnostics in the same sign column
                {
                    sign = { name = { "Diagnostic", "todo*" }, maxwidth = 1, colwidth = 2 },
                    click = "v:lua.ScSa",
                },

                { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },

                {
                    sign = { name = { "GitSigns*" }, maxwidth = 1, colwidth = 1 },
                    click = "v:lua.ScSa",
                },
            },
        })
    end,
}
