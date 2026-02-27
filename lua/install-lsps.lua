-- This is a custom version of something like mason-tool-installer.
-- Just run :MasonInstallAll to install all the tools listed below.
local is_installed = function(cmd)
    return vim.fn.executable(cmd) == 1
end

-- NOTE: these are mason names, not lspconfig names. in mason, that's the first name (if there are two)
local ensure_installed = {
    -- language servers
    "basedpyright",
    "bash-language-server",
    "json-lsp",
    "css-lsp",
    "taplo", -- note that the default config doesn't activate unless the toml file is in a git repo
    "yaml-language-server",
    "vtsls",
    "lua-language-server",
    "html-lsp",
    "tailwindcss-language-server",
    "docker-compose-language-service",
    "dockerfile-language-server",

    -- tools
    "stylua",
    "fixjson",
    "shfmt",
    "yamlfmt",
    "ruff",
    "prettier",
}

local add = function(pkg) table.insert(ensure_installed, pkg) end

if is_installed("go") then
    add("gopls")
    add("templ")
    add("gofumpt")
    add("golangci-lint")
end

if is_installed("terraform") then
    add("terraform-ls")
end

-- run this command to sync all packages that aren't installed
vim.api.nvim_create_user_command("MasonInstallAll", function()
    local reg = require("mason-registry")
    for _, value in ipairs(ensure_installed) do
        if not reg.is_installed(value) then
            local pkg = reg.get_package(value)
            pkg:install()
        end
    end
end, {})

return {}
