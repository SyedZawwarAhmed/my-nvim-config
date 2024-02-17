vim.api.nvim_set_keymap('n', '<leader>gs', ':vertical G<CR>', {noremap = true, silent = true})
vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
vim.keymap.set("n", "gab", "<cmd>/^<<<<<<<\\s*/d | :/^=======\\s*/d | :/^>>>>>>>\\s*/d<CR>")
