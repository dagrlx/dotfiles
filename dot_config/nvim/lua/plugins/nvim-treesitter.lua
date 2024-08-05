-- ~/.config/nvim/lua/plugins/nvim-treesitter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  config = function()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = {
        "lua",
        "javascript",
        "python",
        "html",
        "css",
        "csv",
        "bash",
        "dockerfile",
        "dot",
        "git_config",
        "gitignore",
        "nix",
        "passwd",
        "sql",
        "ssh_config",
        "tmux",
        "toml",
        "yaml",

      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
    }
  end,
}
