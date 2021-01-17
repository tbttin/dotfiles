" load guard {{{1
if exists('b:loaded_ftplugin')                " Only do this when not done yet for this buffer.
    finish
endif

let b:loaded_ftplugin = 1                     " Loaded flag.

" options {{{1
" GNU C format and indentation style.
setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal textwidth=79

setlocal path=.,/usr/include,**,$VIMDOTDIR/** " Current file's dir ('%:p:h'), headers, $PWD/ and $VIMDOTDIR/ recursively.
setlocal showfulltag                          " Show function name + template in auto completion pop-up menu.

" plugins {{{1
packadd termdebug                             " Load terminal debug plugin.

let g:termdebug_wide = 1                      " Enable vertical split without every changing &columns.

" mappings. {{{1
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

" Auto insert multi-line comment terminator.
inoremap <buffer> /* /*  */<C-G>U<Left><Left><Left>
