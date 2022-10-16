local M = {}

-- all servers are installed by mason
local jdtls_home = require("mason-registry.jdtls"):get_install_path()
local java_debug_home = require("mason-registry.java-debug-adapter"):get_install_path()
local java_test_home = require("mason-registry.java-test"):get_install_path()

local root_markers = { ".git", "mvnw", "gradlew" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = os.getenv("HOME") .. "/.cache/jdtls/workspace/" .. project_name
local platform = "linux" -- or "mac" "win"

local bundles = {}
vim.list_extend(bundles, { vim.fn.glob(java_debug_home .. "/extension/server/com.microsoft.java.debug.plugin-*.jar") })
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_home .. "/extension/server/*.jar"), "\n"))

M.config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		"-jar",
		vim.fn.glob(jdtls_home .. "/plugins/org.eclipse.equinox.launcher_*.jar"),

		"-configuration",
		jdtls_home .. "/config_" .. platform,

		-- See `data directory configuration` section in the README
		"-data",
		workspace_dir,
	},

	root_dir = root_dir,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {},
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	init_options = {
		bundles = bundles,
	},

	capabilities = require("mylua.lsp.handlers").capabilities,

	on_attach = function(client, bufnr)
		-- call my common LSP on_attach function
		require("mylua.lsp.handlers").on_attach(client, bufnr)
		local jdtls = require("jdtls")

		require("jdtls.setup").add_commands()
		jdtls.update_project_config()
		jdtls.setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()

		local nnoremap = require("mylua.utils.keymap").nnoremap
		nnoremap("<leader>tr", jdtls.test_nearest_method)
		nnoremap("<leader>tf", jdtls.test_class)
	end,
}

M.on_attach = function(config)
	config = config or M.config
	require("jdtls").start_or_attach(config)
end

return M
