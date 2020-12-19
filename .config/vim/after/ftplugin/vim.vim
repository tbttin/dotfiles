" load guard {{{1
" Only do this when not done yet for this buffer.
if exists('b:loaded_after_ftplugin')
    echo 'Reload detected in ' . expand('<sfile>:p')
    finish
endif

" Don't load another plugin for this buffer.
let b:loaded_after_ftplugin = 1

" options {{{1
" Do not automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
setlocal formatoptions-=o
