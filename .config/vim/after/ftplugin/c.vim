" loadded check {{{
" Only load this file when no other was loaded yet.
if exists("b:loaded_c_ftplugin")
    " For fun.
    echo "Reload detected in " . expand("$VIMDOTDIR/after/ftplugin/c.vim")
    finish
endif
let b:loaded_c_ftplugin = 1
" }}}

" options {{{
" GNU indent.
setlocal formatprg=indent

" Disable auto insert line comment.
setlocal comments-=:// comments+=f://

" GNU C style indentation / format.
" TODO parameters and variable declaration equal sign align.
setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal textwidth=79
" }}}

" mappings. {{{
" TODO Upgrade this mapping: make it process each line independently.
" Comment and umcomment.
xnoremap <expr> <buffer> / Comment ('//')

" Create tags file in $PWD recursively.
nnoremap <buffer> <F5> :!ctags -R<CR>
" Build.
nnoremap <buffer> <Leader>mb :write \| make \| cwindow<CR>
" Debug.
nnoremap <buffer> <Leader>md :write \| make debug \| Termdebug all<CR>
" Clean.
nnoremap <buffer> <Leader>mc :make clean<CR>
" Run.
nnoremap <buffer> <Leader>r :!./all<CR>
" Clear terminal screen.
nnoremap <buffer> <Leader>c :!clear<CR>

" Smart less than sign.
inoremap <expr> <buffer> < IsMatchOnLHS ('^#include\s*$') ? "<>\<Left>" : "<"
" }}}

" plugins {{{
" Load terminal debug plugin.
packadd termdebug
let g:termdebug_wide = 1
" }}}

" modeline {{{
" vim: foldmethod=marker
" }}}
