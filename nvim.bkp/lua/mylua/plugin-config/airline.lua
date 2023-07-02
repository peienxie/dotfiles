vim.cmd([[
	let g:airline#extensions#branch#enabled = 1
	" change section_z only display line number and column number
	let g:airline_section_z = airline#section#create(['windowswap', 'obsession', 'linenr', 'colnr'])
	let g:airline_symbols.colnr = ',Col'
	let g:airline_symbols.linenr = 'Ln'
]])
