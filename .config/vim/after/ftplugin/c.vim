" TODO Make this filetype plugin.
" loadded check, variables {{{
" Only do this when not done yet for this buffer.
if exists('b:loaded_after_ftplugin')
    echo 'Reload detected in ' . expand('<sfile>:p')
    finish
endif
" Don't load another plugin for this buffer.
let b:loaded_after_ftplugin = 1
" }}}

" options {{{
" A template for a comment.
setlocal commentstring=//%s

" Disable auto insert line comment.
setlocal comments-=:// comments+=f://
" }}}
