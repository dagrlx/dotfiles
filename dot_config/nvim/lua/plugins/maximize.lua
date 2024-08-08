-- ~/.config/nvim/lua/plugins/maximize.lua

return {
	"declancm/maximize.nvim",
	config = function()
		require("maximize").setup()

		-- Mapeo para hacer toggle de la maximización
		vim.api.nvim_set_keymap(
			"n",
			"<leader>m",
			':lua require("maximize").toggle()<CR>',
			{ noremap = true, silent = true }
		)

		-- Función para mostrar el estado de maximización
		local function maximize_status()
			return vim.t.maximized and "   " or ""
		end

		-- Añadir maximize_status a lightline (si lightline ya está cargado)
		if vim.g.lightline then
			vim.g.lightline.component_function = vim.g.lightline.component_function or {}
			vim.g.lightline.component_function.maximize_status = "MaximizeStatus"
		end
	end,
}
