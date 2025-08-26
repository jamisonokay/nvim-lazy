return {
    'stevearc/conform.nvim',
    -- This will provide type hinting with LuaLS
    --   ---@module "conform"
    --     ---@type conform.setupOpts
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "gofmt" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = {"prettier", stop_after_first = true},
            typescriptreact = { "prettier", stop_after_first = true },
            json = { "prettier", stop_after_first = true },
            html = { "html_beautify" },
            sql = { "sqruff" }
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
    event = { "BufWritePre" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true })
            end,
            mode = "",
            desc = "Format buffer"
        }
    },
    -- config = function()
    --     require("conform").setup({
    --         formatters_by_ft = {
    --             lua = { "stylua" },
    --             go = { "gofmt" },
    --             javascript = { "prettierd", "prettier", stop_after_first = true },
    --             typescriptreact = { "prettier", stop_after_first = true },
    --             json = { "prettier", stop_after_first = true },
    --             html = { "html_beautify" },
    --             sql = { "sqruff" }
    --         },
    --         format_on_save = {
    --             -- These options will be passed to conform.format()
    --             timeout_ms = 500,
    --             lsp_format = "fallback",
    --         },
    --     })
    -- end
}
