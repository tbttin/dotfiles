" GNU Coding Standards
" Only load this indent file when no other was loaded yet.
if exists("g:loaded_c_indent")
    finish
endif
let g:loaded_c_indent = 1

setlocal cindent
setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal textwidth=79
setlocal formatoptions-=ro formatoptions+=cql
"setlocal cinoptions+=t0,(0,f0.5s,{0.5s,0.5s},:0.5s,=0.5s
" function and variable declaration align?
