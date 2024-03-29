-- Add modules here
local modules = {
	"mylua.options",
	"mylua.keymaps",
	"mylua.autocmd",
	"mylua.plugins",
}

-- Refresh module cache
for _, v in pairs(modules) do
	package.loaded[v] = nil
	require(v)
end
