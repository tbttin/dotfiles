" Load guard {{{1
if exists('b:loaded_ftplugin') " Only do this when not done yet for this buffer.
  finish
endif
let b:loaded_ftplugin = 1      " Loaded flag.

" Options {{{1
" " GNU indentation style (all spaces) {{{2
" setlocal expandtab                    " Don't use tabs for indentation. Spaces are nicer to work with.
" setlocal shiftwidth=2                 " Number of spaces to use for each step of (auto)indent.
" setlocal softtabstop=2                " Virtual tab stop instead of 8-wide tabs.
" setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1

" Indent with tabs, align with spaces {{{2
setlocal copyindent
setlocal preserveindent
" setlocal shiftwidth=4
" setlocal tabstop=4
setlocal cinoptions+=(0,u0,U0

" Miscellany {{{2
" setlocal textwidth=79
setlocal formatprg=/usr/bin/indent                           " GNU indent formator.
setlocal path=.,/usr/include,**,$VIMHOME/**                  " Current file's dir ('%:p:h'), sys include, $PWD then $VIMHOME.
setlocal showfulltag                                         " Show function name + template in auto completion pop-up menu.
setlocal makeprg=/usr/bin/make\ -C\ ..                       " Usually $PWD = project/src
setlocal tags+=./tags;$HOME/projects/c,tags;$HOME/projects/c " Upward search for tags file recursively.

" Plugins {{{1
packadd termdebug        " Load terminal debug plugin.
let g:termdebug_wide = 1 " Enable vertical split without every changing &columns.

" Mappings. {{{1
" Man page default section should be 3.
nnoremap <buffer> K 3K

" Smart less than sign. Currently pear-tree does not do this.
inoremap <expr> <buffer> < pairs#IsMatchOnLHS('^#include\s*$') ? '<><C-G>U<Left>' : '<'

" Auto insert multi-line comment terminator.
inoremap <buffer> /* /*  */<C-G>U<Left><Left><Left>

" TODO: Suppress "Press ENTER or type command to continue" message.
" Build.
nnoremap <buffer> glmb :wall \| make! \| cwindow<CR>
" Debug with terminal debug plugin.
nnoremap <buffer> glmd :wall \| make debug \| Termdebug ../bin/prog<CR>
" Make clean after clear terminal screen.
nnoremap <buffer> glmc :!clear<CR>:make clean<CR>
" Run.
nnoremap <buffer> glmr :make run<CR>

