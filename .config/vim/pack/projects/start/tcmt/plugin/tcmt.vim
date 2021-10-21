" TODO: Add comment operators.

function! tcmt#Comment () range " {{{1
    let l:cms = s:GetCms ()
    if empty (l:cms[1])
        call s:LineComment (l:cms[0])
    else
        call s:BlockComment (l:cms)
    endif
endfunction

function! tcmt#Uncomment () range " {{{1
    let l:cms = s:GetCms ()
    if empty (l:cms[1])
        call s:LineUnComment (l:cms[0])
    else
        call s:BlockUnComment (l:cms)
    endif
endfunction

function! tcmt#ToggleComment () " {{{1
    let l:cms = s:GetCms ()
    if empty (l:cms[1]) " Single-line comment.
        if getline ('.') =~ '\V\^\s\*' . l:cms[0]
            call tcmt#Uncomment ()
        else
            call tcmt#Comment ()
        endif
    else
        " Sometime it does necessary.
    endif
endfunction

function! s:GetCms () abort " {{{1
    let l:cms = split (&commentstring, '\v\s*\%s\s*', 1)
    let l:escaped_cms = []
    for i in range (0, len (l:cms) - 1)
        call add (l:escaped_cms, escape (l:cms[i], '/\'))
    endfor
    return l:escaped_cms
endfunction

function s:LineComment (cms) range abort " {{{1
    silent execute a:firstline . ',' . a:lastline . 's/\V\^\(\s\*\)\(\.\)/\1' . a:cms . '\2/e'
endfunction

function s:BlockComment (cms) range abort " {{{1
    " TODO:
    " - Single line visual mode.
    " - Support 'comments'.
    " - Prevent nested comments.
    " - firstline or lastline is empty.
    "let l:select_mode = mode ()
    "if l:select_mode ==# 'v'
    " Get the line and column of the visual selection marks
    "let [lnum1, col1] = getpos("'<")[1:2]
    "let [lnum2, col2] = getpos("'>")[1:2]
    ":3s/\%9c.//
    silent execute a:lastline . 's/\V\^\(\s\*\)\(\.\*\)/\0\r\1' . a:cms[1] . '/e'
    silent execute a:firstline . 's/\V\^\(\s\*\)\(\.\*\)/\1' . a:cms[0] . '\r\0/e'
endfunction

function s:LineUnComment (cms) range abort " {{{1
    silent execute a:firstline . ',' . a:lastline . 's/\V\^\(\s\*\)' . a:cms . '/\1/e'
endfunction

function s:BlockUnComment (cms) range abort " {{{1
    if a:firstline == a:lastline
        if exists ('g:syntax_on')
            let l:syn_name = synIDattr(synID(line("."), col("."), 1), "name")
            if l:syn_name =~# 'Comment'
                if l:syn_name !~# 'L'
                    " Search, replace backward and forward.
                    let l:open = search ('\V' . a:cms[0], 'beW')
                    echom 'Open comment at line ' . l:open
                    let l:close = search ('\V' . a:cms[1], 'eW')
                    echom 'Close comment at line ' . l:close
                else
                    echom 'Comment marker does not match.'
                endif
            else
                echom 'Not in a comment'
            endif
        else
            echom 'Syntax is off (or not enabled).'
        endif
    else " Multi-lines selected.
        execute a:firstline . ',' . a:lastline . 's/\V\^\s\*' . a:cms[1] . '\n//e'
        execute a:firstline . ',' . (a:lastline - 1) . 's/\V\^\s\*' . a:cms[0] . '\n//e'
    endif
endfunction

command! -range Comment <line1>,<line2>call tcmt#Comment()
