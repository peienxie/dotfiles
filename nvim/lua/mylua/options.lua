local opt = vim.opt

opt.encoding = "utf-8"
opt.fileencodings = "utf-8,big5,cp950,gbk,cp936,iso-2022-jp,sjis,euc-jp,japan,euc-kr,ucs-bom,utf-bom,latin1,iso8859-1"
opt.termencoding = "utf-8"
opt.fileencoding = "utf-8"
opt.mouse = "a"
opt.splitbelow = true
opt.splitright = true

opt.errorbells = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

opt.smartindent = true
opt.autoindent = true
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.incsearch = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.cursorline = true
opt.cursorlineopt = "number"
opt.cmdheight = 2
opt.colorcolumn = "81"
opt.list = true
opt.listchars = "tab:» ,eol:↓,trail:·"
