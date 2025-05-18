require("alexjamison.remap")
require("alexjamison.set")
require("alexjamison.copy")
require("alexjamison.golang")
require("alexjamison.lazy_init")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 60,
        })
    end
})
autocmd('BufEnter', {
    callback = function()
        if vim.bo.filetype == "zig" then
            vim.cmd.colorscheme("tokyonight-night")
        else
            vim.cmd.colorscheme("rose-pine-moon")
        end
    end
})

autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
