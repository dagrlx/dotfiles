return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"ansiblels", -- Ansible
				"tsserver", -- JavaScript
				"html", -- HTML
				"cssls", -- CSS
				"lua_ls", -- Lua
				"pyright", -- Python
				"jsonls", -- JSON
				"yamlls", -- YAML
				"marksman", -- Markdown
				"docker-compose-language-service", -- Docker
				"dockerfile-language-server", -- Dockerfile
				"bash-language-server", -- Bash
				"shellcheck",
				"sqls", -- SQL
				"taplo", -- Toml
				"nil", -- nix
				"rust_analyzer", -- Rust
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				"eslint_d", -- JavaScript linter
				"sql-formatter",
			},
		})
	end,
}
