return {
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",

		version = "v0.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config

		opts = {
			-- https://cmp.saghen.dev/configuration/keymap
			keymap = { preset = "enter" },

			-- https://cmp.saghen.dev/configuration/appearance.html
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			-- https://cmp.saghen.dev/configuration/sources.html
			-- sources = {
			-- 	default = { 'lsp', 'path', 'luasnip', 'buffer' },
			-- },

			sources = {
				-- https://cmp.saghen.dev/recipes.html#dynamically-picking-providers-by-treesitter-node-filetype
				default = function(ctx)
					local success, node = pcall(vim.treesitter.get_node)
					if vim.bo.filetype == "lua" then
						return { "lsp", "path" }
					elseif
						success
						and node
						and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
					then
						return { "buffer" }
					else
						return { "lsp", "path", "snippets", "buffer" }
					end
				end,
				-- Disable cmdline completions
				-- cmdline = {},
			},

			-- https://cmp.saghen.dev/configuration/signature.html
			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},

			-- https://cmp.saghen.dev/configuration/completion.htm
			completion = {

				-- https://cmp.saghen.dev/configuration/completion.html#menu
				menu = {
					border = "rounded",
					draw = {
						--columns = { { "label", "label_description", gap = 2 }, { "kind_icon", "kind", gap = 2 } },
						treesitter = { "lsp" },
					},
				},

				-- https://cmp.saghen.dev/configuration/reference#completion-ghost-text
				ghost_text = { enabled = true },

				-- https://cmp.saghen.dev/configuration/completion.html#documentation
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					treesitter_highlighting = true,
					window = { border = "rounded" },
				},

				-- https://cmp.saghen.dev/configuration/completion.html#list
				list = {
					selection = function(ctx)
						return ctx.mode == "cmdline" and "auto_insert" or "preselect"
					end,
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
