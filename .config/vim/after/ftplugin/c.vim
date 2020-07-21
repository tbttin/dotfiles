" Only load this indent file when no other was loaded yet.
if exists("g:loaded_c")
    finish
endif
let g:loaded_c = 1

" GNU C style indentation.
" TODO function and variable declaration align.
setlocal cindent
setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal textwidth=79

" Use external format program.
setlocal formatprg=indent

" Disable auto insert line comment.
setlocal comments-=:// comments+=f://

" Temporarily, one Makefile multi source files.
setlocal makeprg=make\ -f\ ../Makefile

" Load terminal debug plugin.
packadd termdebug

" Mappings.
" Basic pairs auto completions.
inoremap { {<CR>}<Esc>O
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap ( ()<Esc>i

" Create tags file in $pwd recursively.
nnoremap <F5> :!ctags -R<CR>

" Build.
nnoremap <buffer> <Leader>b :write \| make \| cwindow<CR>
" Run.
nnoremap <buffer> <Leader>r :!./all<CR>
" Debug.
nnoremap <buffer> <Leader>d :write \| make debug \| Termdebug all<CR>
