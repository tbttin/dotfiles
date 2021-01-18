" UpdateTimestamp {{{1
" TODO: Store timestamp in a variable and update it when exit.
"function! templates#UpdateTimestamp ()
"    let l:line = line ('$') > 10 ? 10 : line ('$')
"    kt
"    execute 1 . ',' . l:line . 'g/Last modified: /s/Last modified: .*/Last modified: ' .
"                \ strftime("%b %d %Y %R %z")
"    't
"endfunction

function! templates#AddFileDescription () " {{{1
    " Search backward after parsing.
    " 0 if not found, no error.
    if search ('\cDescription: .', 'beW')
        if expand ('%:p') =~# '/cforces/'
            execute "normal! iCodeforces problemset \<C-R>=expand ('%:p:h:t')\<CR> - \<Esc>l"
        elseif expand ('%:p') =~# '/cchef/'
            execute "normal! iCodechef practice - \<Esc>l"
        endif
        startinsert
    endif
endfunction

function! s:ParseTemplate () " {{{1
    let l:line = line ('$') > 10 ? 10 : line ('$')
    execute 1 . ',' . l:line . 's/\v\[:VIM_EVAL:\](.{-})\[:END_EVAL:\]/\=eval (submatch (1))/ge'
endfunction

function! templates#LoadTemplate (filename) " {{{1
    let l:fullpath = $VIMDOTDIR . '/templates/' . a:filename
    if filereadable (l:fullpath)
        execute '0read ' . l:fullpath
        $delete
        call s:ParseTemplate ()
    endif
endfunction
