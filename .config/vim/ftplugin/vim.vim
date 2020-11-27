" loadded check, variables {{{
" Only do this when not done yet for this buffer.
if exists('b:loaded_ftplugin')
    echo 'Reload detected in ' . expand('<sfile>:p')
    finish
endif

" Don't load another plugin for this buffer.
let b:loaded_ftplugin = 1
" }}}

" options {{{
" Use markers to specify folds.
setlocal foldmethod=marker
" }}}
