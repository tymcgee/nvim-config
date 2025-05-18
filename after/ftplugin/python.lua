vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end
        if client.name == "ruff" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
        end

        -- my color scheme doesn't play very well with basedpyright's semantic tokens,
        -- and the treesitter ones work fine, so just disable semantic token highlighting
        if client.name == "basedpyright" then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
    desc = "LSP: Disable hover capability from Ruff",
})
