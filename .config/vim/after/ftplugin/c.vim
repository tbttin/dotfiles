" loadded check, variables {{{
" Only load this file when no other was loaded yet.
if exists('b:loaded_c_ftplugin')
    " For fun.
    echo 'Reload detected in ' . expand('$VIMDOTDIR/after/ftplugin/c.vim')
    finish
endif
let b:loaded_c_ftplugin = 1

" Comment string will be used in ToggleComment.
let b:comment_starter = '//'
" }}}

" options {{{
" GNU indent.
setlocal formatprg=indent

" Disable auto insert line comment.
setlocal comments-=:// comments+=f://

" TODO parameters and variable declaration equal sign align.
" GNU C style indentation/format.
setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal textwidth=79
" }}}

" mappings. {{{
" Man page default section is section 3.
nnoremap K 3K

" Create tags file in $PWD recursively.
nnoremap <buffer> <F5> :!ctags -R<CR>

" Build.
nnoremap <buffer> <Leader>mb :write \| make \| cwindow<CR>
" Debug.
nnoremap <buffer> <Leader>md :write \| make debug \| Termdebug all<CR>
" Make clean after clear terminal screen.
nnoremap <buffer> <Leader>mc :!clear<CR>:make clean<CR>
" Run.
nnoremap <buffer> <Leader>r :!./all<CR>

" Smart less than sign.
inoremap <expr> <buffer> < IsMatchOnLHS ('^#include\s*$') ? "<><Left>" : "<"
" }}}

" plugins {{{
" Load terminal debug plugin.
packadd termdebug

" Enable vertical split without every changing &columns.
let g:termdebug_wide = 1
" }}}
