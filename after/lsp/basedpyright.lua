return {
    on_attach = function(client, buf_id)
        -- removed "[" from this list
        -- i don't want completion to show up when i press [ in python. it's very annoying
        client.server_capabilities.completionProvider.triggerCharacters = { ".", '"', "'" }
    end,
    settings = {
        basedpyright = {
            typeCheckingMode = "standard",
        },
    },
}
