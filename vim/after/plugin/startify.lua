vim.g.startify_lists = {
  { type='files',     header={'   Recent Files'} },
  { type='dir',       header={'   Files in ' .. vim.fn.getcwd() } },
  { type='sessions',  header={'   Sessions'} },
  { type='bookmarks', header={'   Bookmarks'} },
  { type='commands',  header={'   Commands'} },
}

vim.g.startify_bookmarks = {
  { d='~/.dotfiles' },
}

vim.g.startify_session_autoload = 1
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_session_persistence = 1
vim.g.startify_enable_special = 0

