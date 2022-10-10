local M = {}

local jdtls_home = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local root_markers = { ".git", "mvnw", "gradlew" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = os.getenv("HOME") .. "/.cache/jdtls/workspace/" .. project_name
local platform = "linux" -- or "mac" "win"

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
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {},
	},

	capabilities = require("mylua.lsp.handlers").capabilities,

	on_attach = function(client, bufnr)
		-- call my common LSP on_attach function
		require("mylua.lsp.handlers").on_attach(client, bufnr)

		require("jdtls.setup").add_commands()
		require("jdtls").update_project_config()
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end,
}

M.on_attach = function(config)
	config = config or M.config
	require("jdtls").start_or_attach(config)
end

return M
