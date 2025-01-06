return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
				component_separators = { " ", " " },
				section_separators = { left = "", right = "" },
				-- component_separators = "|",
				-- section_separators = { "", "" },
			},
			sections = {
				lualine_b = {
					"branch",
					"diff",
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						sections = { "error", "warn", "info", "hint" },
						diagnostics_color = {
							error = "DiagnosticError",
							warn = "DiagnosticWarn",
							info = "DiagnosticInfo",
							hint = "DiagnosticHint",
						},
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
						colored = true,
						update_in_insert = false,
						always_visible = false,
					},
				},

				lualine_c = {
					{
						"filename",
						file_status = true,
						path = 0,
						shorting_target = 40,
						symbols = {
							modified = "󰐖 ", -- Text to show when the file is modified.
							readonly = " ", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "[No Name]", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for new created file before first writting
						},
					},
				},
				lualine_x = {
					"encoding",
					"fileformat",
					"filetype",
					"python_env",
				},
			},
			tabline = {},
			extensions = {
				"quickfix",
				"oil",
				"fzf",
			},
		})
	end,
}
