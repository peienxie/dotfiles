local M = {}

-- jdtls need at least java 17 or newer version.
-- use java17 binary if JAVA17_HOME environment variable is set
-- otherwise use default java binary.
local java_bin = "java"
local java17_home = os.getenv("JAVA17_HOME")
if java17_home ~= "" and vim.fn.executable(java17_home .. "/bin/java") then
	java_bin = java17_home .. "/bin/java"
end

-- all servers are installed by mason
local jdtls_home = require("mason-registry.jdtls"):get_install_path()
local java_debug_home = require("mason-registry.java-debug-adapter"):get_install_path()
local java_test_home = require("mason-registry.java-test"):get_install_path()

local root_markers = { ".git", "mvnw", "gradlew" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	vim.notify("can't find any project root for current java file")
	return
end

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
		java_bin,
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
		java = {
			eclipse = { downloadSources = true },
			maven = { downloadSources = true },
			implementationsCodeLens = { enabled = true },
			referencesCodeLens = { enabled = true },
			references = { includeDecompiledSources = true },
			signatureHelp = { enabled = true },
			format = { enabled = false },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
			},
			contentProvider = { preferred = "fernflower" },
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				useBlocks = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = {
					{
						name = "JavaSE-1.8",
						path = os.getenv("JAVA8_HOME"),
					},
					{
						name = "JavaSE-11",
						path = os.getenv("JAVA11_HOME"),
					},
					{
						name = "JavaSE-17",
						path = os.getenv("JAVA17_HOME"),
					},
				},
			},
		},
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	init_options = {
		bundles = bundles,
	},

	capabilities = require("mylua.lsp.handlers").get_capabilities({ snippetSupport = false }),

	on_attach = function(client, bufnr)
		-- call my common LSP on_attach function
		require("mylua.lsp.handlers").on_attach(client, bufnr)
		local jdtls = require("jdtls")

		require("jdtls.setup").add_commands()
		jdtls.update_project_config()
		jdtls.setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()

		local nnoremap = require("mylua.utils.keymap").nnoremap
		nnoremap("<leader>tr", jdtls.test_nearest_method, { buffer = bufnr })
		nnoremap("<leader>tf", jdtls.test_class, { buffer = bufnr })
	end,
}

M.on_attach = function(config)
	config = config or M.config
	require("jdtls").start_or_attach(config)
end

return M
