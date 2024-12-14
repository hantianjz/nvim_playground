require("nvim_cfg")

vim.keymap.set("n", "<Leader>x", ":.lua<CR>")
vim.keymap.set("v", "<Leader>x", ":lua<CR>")
vim.keymap.set("n", "<Leader>lt", ":Inspect<CR>")

require("config.lazy")
