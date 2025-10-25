require("nicolas")
vim.lsp.enable({
    'lua_ls',
})
vim.keymap.set('n', '<leader>y', '"+y', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true })


