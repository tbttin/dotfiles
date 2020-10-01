" loadded check, variables {{{
" Only do this when not done yet for this buffer.
if exists('b:loaded_after_ftplugin')
    finish
endif

" Don't load another plugin for this buffer.
let b:loaded_after_ftplugin = 1
" }}}

" options {{{
" Use markers to specify folds.
setlocal foldmethod=marker

" Do not automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set formatoptions-=o
" }}}
