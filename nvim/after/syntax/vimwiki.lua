-- Reference: http://www.panozzaj.com/blog/2016/03/21/ignore-urls-and-acroynms-while-spell-checking-vim/
-- Don't count acronyms / abbreviations as spelling errors
-- (all upper-case letters, at least three characters)
-- Also will not count acronym with 's' at the end a spelling error
-- Also will not count numbers that are part of this
-- Recognizes the following as correct:
-- syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
-- syn match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell

local function flatten(item, result)
	result = result or {}
	if type(item) == "table" then
		for _, v in ipairs(item) do
			flatten(v, result)
		end
	else
		result[#result + 1] = item
	end
	return result
end

local create_containedin = function(...)
	local items = {}
	for _, v in ipairs({ ... }) do
		flatten(v, items)
	end
	return "containedin=" .. table.concat(items, ",")
end

local no_spell = "contains=@NoSell"
local contained = "contained"
local transparent = "transparent"

local headers = {}
for i = 1, 10 do
	table.insert(headers, "VimwikiHeader" .. i)
end

-- FIXME: the syntax VimwikiTableRow also have `transparent` option,
-- the "contained" syntax matches below is not working as headers
local containedin = create_containedin(headers, "VimwikiTableRow")
local contained_opts = { contained, containedin, transparent }

local no_spell_checks = {
	Url = [['\w\+:\/\/\[^\[:space:\]\]\+']],
	AcronymWords = [['\<\(\u\|\d\)\{2,}s\?\>']],
	UpperCaseAndNumber = [['\<\u\d\>']],
}

for name, pattern in pairs(no_spell_checks) do
	local opts = no_spell
	vim.cmd(string.format("syntax match %s %s %s", name, pattern, opts))

	name = name .. "Contained"
	opts = opts .. " " .. table.concat(flatten(contained_opts), " ")
	vim.cmd(string.format("syntax match %s %s %s", name, pattern, opts))
end
