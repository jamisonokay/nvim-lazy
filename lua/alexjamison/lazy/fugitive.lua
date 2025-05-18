return {
    "tpope/vim-fugitive",
    config = function()
        function GitCheckout()
            local input = vim.fn.input("Change branch to: ")
            vim.cmd("Git checkout " .. input)
        end
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>ga", ":Git add -A<CR>")
        vim.keymap.set("n", "<leader>gap", ":Git add -N .<CR> <BAR> :vertical Git add -p<CR>")
        vim.keymap.set("n", "<leader>gc", ":vertical Git commit<CR>")
        vim.keymap.set("n", "<leader>gp", ":Git push<CR>")
        vim.keymap.set("n", "<leader>gb", ":lua GitCheckout()<CR>")
    end
}
