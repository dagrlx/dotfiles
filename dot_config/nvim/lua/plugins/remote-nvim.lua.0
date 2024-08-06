-- ~/.config/nvim/lua/plugins/remote-nvim.lua

 -- https://github.com/amitds1997/remote-nvim.nvim

return {
  "amitds1997/remote-nvim.nvim",
  version = "*", -- Pin to GitHub releases
  dependencies = {
    "nvim-lua/plenary.nvim", -- For standard functions
    "MunifTanjim/nui.nvim", -- To build the plugin UI
    "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    {
      "folke/which-key.nvim",
      opts = function(_, opts)
        local wk = require "which-key"
        wk.add { "<leader>R", group = "remote" }
      end,
    },
  },
  cmd = { "RemoteStart", "RemoteStop", "RemoteInfo", "RemoteCleanup", "RemoteConfigDel", "RemoteLog" },
  keys = {
    { "<leader>Rs", "<cmd>RemoteStart<CR>", desc = "RemoteStart" },
    { "<leader>RS", "<cmd>RemoteStop<CR>", desc = "RemoteStop" },
    { "<leader>Ri", "<cmd>RemoteInfo<CR>", desc = "RemoteInfo" },
    -- { "<leader>Rc", "<cmd>RemoteCleanup<CR>", desc = "RemoteCleanup" },
    -- { "<leader>RC", "<cmd>RemoteConfigDel<CR>", desc = "RemoteConfigDel" },
    { "<leader>Rl", "<cmd>RemoteLog<CR>", desc = "RemoteLog" },
  },
  opts = {
    -- leverages tar's inbuilt VCS feature to exclude any VCS directories
    client_callback = function(port, workspace_config)
      -- Launch a new wezterm tab with ccustom title when launching Neovim client
      local cmd = ("wezterm cli set-tab-title --pane-id $(wezterm cli spawn nvim --server localhost:%s --remote-ui) %s"):format(
        port,
        ("'Remote: %s'"):format(workspace_config.host)
      )
      -- Launch a new tmux window in the current session named 'Remote: <host>'
      if os.getenv "TMUX" ~= nil then
        cmd = ("tmux new-window -t $(tmux display-message -p '#S') -n 'SSH: %s' 'nvim --server localhost:%s --remote-ui'"):format(
          workspace_config.host,
          port
        )
      end
      if vim.env.TERM == "xterm-kitty" then
        cmd = ("kitty -e nvim --server localhost:%s --remote-ui"):format(port)
      end
      vim.fn.jobstart(cmd, {
        detach = true,
        on_exit = function(job_id, exit_code, event_type)
          -- This function will be called when the job exits
          print("Client", job_id, "exited with code", exit_code, "Event type:", event_type)
        end,
      })
    end,
  },
  }
