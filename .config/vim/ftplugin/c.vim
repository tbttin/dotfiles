" loadded check, variables {{{
" Only do this when not done yet for this buffer.
if exists('b:loaded_ftplugin')
    finish
endif
" Don't load another plugin for this buffer.
let b:loaded_ftplugin = 1
" }}}

" options {{{
" TODO parameters and variable declaration equal sign align.
" GNU C style indentation/format.
setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal textwidth=79

setlocal path=.,/usr/include,**,$VIMDOTDIR/**
" end options }}}

" mappings. {{{
" Man page default section is section 3.
nnoremap <buffer> K 3K

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
inoremap <expr> <buffer> < pairs#IsMatchOnLHS ('^#include\s*$') ? '<><C-G>U<Left>' : '<'
" }}}

" plugins {{{
" Load terminal debug plugin.
packadd termdebug

" Enable vertical split without every changing &columns.
let g:termdebug_wide = 1
" }}}
