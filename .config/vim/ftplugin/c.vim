" Load guard {{{1

if exists('b:loaded_ftplugin') " Only do this when not done yet for this buffer.
  finish
endif
let b:loaded_ftplugin = 1      " Loaded flag.

" Options {{{1

" Displays {{{2

setlocal foldmethod=syntax " Fold function bodies, comments.
setlocal foldnestmax=1     " Just function body; and not if, else, for, ...
let c_space_errors = 1     " Highlight trailing white space and spaces before a <Tab>.

" Autocompletions {{{2

setlocal showfulltag          " Show function name + template in auto completion pop-up menu.
setlocal completeopt-=preview " Turn off preview window.

" Indentation {{{2

" Indent with spaces, align with spaces (GNU style) {{{3

setlocal expandtab     " Don't use tabs for indentation. Spaces are nicer to work with.
setlocal shiftwidth=2  " Number of spaces to use for each step of (auto)indent.
setlocal softtabstop=2 " Virtual tab stop instead of 8-wide tabs.
setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0
setlocal cinoptions+=h2,p5,t0,+2,(0,u0,w1,m1

" Indent with tabs, align with spaces {{{3

" setlocal copyindent
" setlocal preserveindent
" setlocal cinoptions+=(0,u0,U0,t0,l1

" Miscellany {{{2

setlocal formatprg=/usr/bin/indent                           " GNU indent formator.
setlocal path=.,/usr/include,**                              " Current file's dir, system include, recursive $PWD.
setlocal tags+=./tags;$HOME/projects/c,tags;$HOME/projects/c " Upward search for tags file recursively.

" Plugins {{{1

packadd termdebug        " Load terminal debug plugin.
let g:termdebug_wide = 1 " Enable vertical split without every changing &columns.

" Mappings. {{{1

" Man page default section should be 3.
nnoremap <buffer> K 3K

" Smart less than sign. Currently pear-tree does not do this.
inoremap <buffer> <expr> < pairs#IsMatchOnLHS('^#include\s*$') ? '<><C-G>U<Left>' : '<'

" Auto insert multi-line comment terminator.
inoremap <buffer> /* /*  */<C-G>U<Left><Left><Left>

" Build.
nnoremap <buffer> <Leader>mb :wall \| make! \| cwindow<CR><CR>
" Debug with terminal debug plugin.
nnoremap <buffer> <Leader>md :wall \| make debug \| Termdebug build/prog<CR>
" Make clean after clear terminal screen.
nnoremap <buffer> <Leader>mc :!clear<CR>:make clean<CR>
" Run.
" !make run -- --args
nnoremap <buffer> <Leader>mr :cclose \| make run<CR>

