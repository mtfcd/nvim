local options = {
  ensure_installed = {"prettirer", "stylua","rust-analyzer", "lua-language-server" }, -- not an option from mason.nvim
  PATH = "skip",
  max_concurrent_installers = 10,
}

return options
