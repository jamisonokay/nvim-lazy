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
            html = { "html_beautify", "prettydiff", "prettier", stop_after_first = true },
            sql = { "sqruff" },
            zig = { "zigfmt" }
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
}
