" load guard {{{1
" Only do this when not done yet for this buffer.
if exists('b:loaded_ftplugin')
    echo 'Reload detected in ' . expand('<sfile>:p')
    finish
endif

" Don't load another plugin for this buffer.
let b:loaded_ftplugin = 1

" options {{{1
" Curly-braced variable.
setlocal isfname+={,}

" Use bash syntax highlighting.
let g:is_bash = 1

" Enable function folding.
"let g:sh_fold_enabled = 1