local ok, lualine = pcall(require, "lualine")
if not ok then
	vim.notify("Failed to load plugin 'lualine'", "error")
	return
end

local custom_filename = require("lualine.components.filename"):extend()
local highlight = require("lualine.highlight")
local default_status_colors = { saved = "#ffffff", modified = "#f07178" }

function custom_filename:init(options)
	custom_filename.super.init(self, options)
	self.status_colors = {
		saved = highlight.create_component_highlight_group(
			{ fg = default_status_colors.saved },
			"filename_status_saved",
			self.options
		),
		modified = highlight.create_component_highlight_group(
			{ fg = default_status_colors.modified },
			"filename_status_modified",
			self.options
		),
	}
	if self.options.color == nil then
		self.options.color = ""
	end
end

function custom_filename:update_status()
	local data = custom_filename.super.update_status(self)
	data = highlight.component_format_highlight(
		vim.bo.modified and self.status_colors.modified or self.status_colors.saved
	) .. data
	return data
end

-- display how many characters/bytes count on statusline
-- vim already has word count at the bottom of screen which is enable by :showcmd
-- but it will become rows count once select more than one rows.
local word_count = function()
	local wc = vim.api.nvim_eval("wordcount()")
	local c = wc["visual_chars"] or 0
	local b = wc["visual_bytes"] or 0
	if c ~= b then
		return c .. "-" .. b
	elseif c > 0 then
		return c
	else
		return ""
	end
end

local components = {
	mode = { "mode" },
	branch = {
		"branch",
		icons_enabled = true,
		icon = "",
	},
	diff = {
		"diff",
		symbols = { added = " ", modified = " ", removed = " " },
	},
	diagnostics = {
		"diagnostics",
		update_in_insert = false,
		always_visible = false,
	},
	filetype = {
		"filetype",
		icon_only = true,
		separator = "",
		padding = { right = 0, left = 1 },
	},
	fileformat = {
		"fileformat",
		icons_enabled = true,
		symbols = {
			unix = "LF",
			dos = "CRLF",
			mac = "CR",
		},
	},
	filename = {
		custom_filename,
		file_status = true,
		path = 0,
	},
	word_count = {
		word_count,
	},
	encoding = {
		"encoding",
	},
	location = {
		"location",
		padding = 1,
	},
}

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "ayu",
		component_separators = "",
		section_separators = "",
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = {
			components.mode,
		},
		lualine_b = {
			components.branch,
			components.diagnostics,
		},
		lualine_c = {
			{ "%=" },
			components.filetype,
			components.filename,
		},
		lualine_x = {
			components.word_count,
		},
		lualine_y = {
			components.encoding,
			components.fileformat,
		},
		lualine_z = {
			components.location,
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			components.filetype,
			components.filename,
		},
		lualine_x = {},
		lualine_y = {
			components.encoding,
			components.fileformat,
		},
		lualine_z = {
			components.location,
		},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = { "quickfix", "nvim-tree" },
})
