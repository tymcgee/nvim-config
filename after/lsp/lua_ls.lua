return {
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
            -- ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = { disable = { "missing-fields" } },
        },
    },
}
