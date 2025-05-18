return {
    "dmmulroy/tsc.nvim",
    config = function()
        require('tsc').setup({})
        vim.keymap.set('n', '<leader>ts', ":TSC<CR>")
    end
}
