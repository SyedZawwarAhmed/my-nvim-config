-- Initialize variables
local lsp_zero = require('lsp-zero')
local builtin = require('telescope.builtin')

-- Define on_attach function for LSP
local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- Navigation
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gr", builtin.lsp_references, opts)
    vim.keymap.set("n", "gI", builtin.lsp_implementations, opts)
    vim.keymap.set("n", "<leader>D", builtin.lsp_type_definitions, opts)
    
    -- Information
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    
    -- Workspace
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, opts)
    vim.keymap.set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, opts)
    
    -- Diagnostics
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    
    -- Actions
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
end

-- Set up LSP-Zero with v3.x API
lsp_zero.on_attach(on_attach)

-- Set diagnostic signs
lsp_zero.set_sign_icons({
    error = "❌",
    warning = "⚠️",
    info = "ℹ️",
    hint = "💡",
})

-- Configure diagnostic display
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

-- Set up Mason
require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Get capabilities for LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Set up lspconfig directly
local lspconfig = require('lspconfig')

-- Configure individual servers
local servers = {
    ts_ls = {},
    eslint = {},
    rust_analyzer = {},
    pylsp = {},
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT'
                },
                diagnostics = {
                    globals = {'vim'},
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    },
}

-- Setup each server
for server_name, server_config in pairs(servers) do
    server_config.on_attach = on_attach
    server_config.capabilities = capabilities
    lspconfig[server_name].setup(server_config)
end

-- Set up completion
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer', keyword_length = 3 },
    },
    formatting = lsp_zero.cmp_format({details = false}),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

-- Set up LuaSnip
require('luasnip.loaders.from_vscode').lazy_load()
