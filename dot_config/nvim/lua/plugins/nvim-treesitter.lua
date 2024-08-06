-- ~/.config/nvim/lua/plugins/nvim-treesitter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },

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
        "markdown",
        "markdown_inline",
        "nix",
        "passwd",
        "sql",
        "ssh_config",
        "tmux",
        "toml",
        "vimdoc",
        "yaml",

      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      -- enable indentation
      indent = { enable = true },

      autotag = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    }
  end,
}
