return {
    settings = {
        Lua = {
            -- Use LuaJIT (it's built into Neovim)
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            workspace = {
                -- Don't analyze code from submodules
                ignoreSubmodules = true,
                -- Add Neovim's methods
                library = { vim.env.VIMRUNTIME },
            },
            completion = {
                callSnippet = "Replace",
            },
            -- Ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = { disable = { "missing-fields" } },
        },
    },
}
