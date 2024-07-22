" Load guard {{{1

if exists('b:loaded_ftplugin') " Only do this when not done yet for this buffer.
  finish
endif
let b:loaded_ftplugin = 1      " Loaded flag.

" Options {{{1

" Displays {{{2

setlocal foldmethod=syntax " Fold function bodies, comments.
" setlocal foldnestmax=1     " Just function body; and not if, else, for, ...
let c_space_errors = 1     " Highlight trailing white space and spaces before a <Tab>.

" Autocompletions {{{2

setlocal showfulltag          " Show function name + template in auto completion pop-up menu.
setlocal completeopt-=preview " Turn off preview window.
" LSP is necessary?
" +-------------------+-----+-----+
" |                   | vim | LSP |
" +-------------------+-----+-----+
" | refactoring (big) |  ~  |  X  |
" +-------------------+-----+-----+
" | ctags (1)         |  X  |     |
" +-------------------+-----+-----+
" | omni completion   |  X  |     |
" +-------------------+-----+-----+
" | a snippet plugin  |  X  |     |
" +-------------------+-----+-----+
" | normal mode K     |  X  |     |
" +-------------------+-----+-----+
" | a compiler        |  X  |     |
" +-------------------+-----+-----+
" | you               |  X  |     |
" +-------------------+-----+-----+
" (1) ctags --kinds-c=+p /usr/include/<lib>
"   TODO: 'tagsrch.txt'

" Indentation {{{2

" Indent with spaces, align with spaces (GNU style) {{{3
" setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0
" setlocal cinoptions+=h2,p5,t0,+2,(0,u0,w1,m1

" Indent with tabs, align with spaces {{{3

" setlocal copyindent
" setlocal preserveindent
" setlocal cinoptions+=(0,u0,U0,t0,l1
setlocal cinoptions=l1,(0,t0

" Miscellany {{{2

" setlocal path=.,/usr/include,**                              " Current file's dir, system include, recursive $PWD.
setlocal path&                                               " Revert vimrc.
setlocal tags+=./tags;$HOME/projects/c,tags;$HOME/projects/c " Upward search for tags file recursively.

" Mappings. {{{1

" Man page default section should be 3 or 3p? sleep() e.g.
nnoremap <buffer> K 3K<CR>

" Build.
nnoremap <buffer> <Leader>mm :wall \| make! \| cwindow<CR><CR>
" Debug with terminal debug plugin.
nnoremap <buffer> <expr> <Leader>md ":wall \| make debug \| Termdebug ./build/" . fnamemodify(getcwd(), ':t') . "<CR>"
" Clean and clear screen.
nnoremap <buffer> <Leader>mc :make clean \| :!clear<CR><CR>
" Build and run.
" TODO: Handle compiler/program output.
" !make run -- --args
nnoremap <buffer> <Leader>mr :wall \| cclose \| !make run<CR>

" Plugins {{{1

packadd! termdebug        " Load terminal debug plugin.
let g:termdebug_wide = 1 " Enable vertical split without every changing &columns.

