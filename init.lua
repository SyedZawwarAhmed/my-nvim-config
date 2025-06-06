if vim.g.vscode then
  -- VSCode Neovim
  require "user.vscode_keymaps"
else
  require("config")
end
