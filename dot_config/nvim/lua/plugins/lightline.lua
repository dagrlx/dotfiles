-- ~/.config/nvim/lua/plugins/lightline.lua

return {
	"itchyny/lightline.vim",
	config = function()
		-- Configuración de lightline
		vim.g.lightline = {
			colorscheme = "catppuccin", -- usa tu propio esquema de colores
			active = {
				left = { { "mode", "paste" }, { "readonly", "filename", "modified" } },
				right = {
					{ "lineinfo" },
					{ "percent" },
					{ "fileformat", "fileencoding", "filetype", "maximize_status" },
				},
			},
			component_function = {
				maximize_status = "MaximizeStatus",
				-- Otros componentes que ya tienes configurados
			},
		}

		-- Función para lightline para mostrar si una pestaña tiene una ventana
		-- maximizada
		vim.cmd([[
		    function! MaximizeStatus()
		      return luaeval('vim.t.maximized and "   " or ""')
		    endfunction
		    ]])
	end,
}
