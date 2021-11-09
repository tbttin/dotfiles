" Load guard {{{1
if exists('b:loaded_ftplugin') " Only do this when not done yet for this buffer.
  finish
endif
let b:loaded_ftplugin = 1      " Loaded flag.

" Options {{{1
setlocal foldmethod=marker     " Use markers to specify folds.

" Mappings {{{1
nnoremap <buffer> <silent> gltt :!ctags -R --language-force=vim<CR><CR>
