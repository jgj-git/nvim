return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        -- import cmp-nvim-lsp plugin
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                local opts = { buffer = ev.buf, silent = true }
                opts.desc = "See available code actions"
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                opts.desc = "Smart rename"
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                opts.desc = "Show line diagnostics"
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                opts.desc = "Go to previous diagnostic"
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                opts.desc = "Go to next diagnostic"
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                opts.desc = "Show documentation for what is under cursor"
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                opts.desc = "Format according to lsp in buffer"
                vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
                opts.desc = "Restart LSP"
                vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
                opts.desc = "Go to declaration"
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            end,
        })

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "X",
                    [vim.diagnostic.severity.WARN] = "!",
                    [vim.diagnostic.severity.HINT] = "?",
                    [vim.diagnostic.severity.INFO] = "I",
                },
            },
        })

        vim.lsp.config["*"] = {
            root_markers = { ".git" },
        }

        vim.lsp.config["lua_ls"] = {
            settings = {
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                },
            },
        }
        vim.lsp.enable("lua_ls")
        vim.lsp.config["slang-server"] = {
            cmd = {
                "slang-server",
            },
            filetypes = {
                "systemverilog",
                "verilog",
            },
            single_file_support = true,
            root_markers = { '.slang', '.git' },
        }
        vim.lsp.enable("slang-server")
        vim.lsp.config["clangd"] = {
            cmd = {
                'clangd',
                '--clang-tidy',
                '--background-index',
                '--offset-encoding=utf-8',
                "--compile-commands-dir=build",
            },
            root_markers = { ".clangd", "build/compile_commands.json" },
            filetypes = { "c", "cpp" },
        }
        vim.lsp.enable("clangd")
    end,
}
