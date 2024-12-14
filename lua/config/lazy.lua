-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
    { "nvim-lua/plenary.nvim" },
    {
      dir    = "~/Development/hjz/semhl.nvim",
      enabled = true,
      opts   = { "c", "cpp", "h", "python", "lua", "typescript", "java" }
    },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "catppuccin-mocha" } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})
