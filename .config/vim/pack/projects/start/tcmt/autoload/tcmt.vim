" TODO Add comment operations.

function! s:GetCms () abort " {{{1
    if exists ('b:escaped_cms')
        return
    endif
    let l:cms = split (&commentstring, '%s', 1)
    let b:escaped_cms = []
    for i in range (0, len (l:cms) - 1)
        call add (b:escaped_cms, escape (l:cms[i], '/*<>'))
    endfor
    return b:escaped_cms
endfunction

function! tcmt#Comment () range " {{{1
    call s:GetCms ()
    if empty (b:escaped_cms[1]) " Line comment.
        silent execute a:firstline . ',' . a:lastline . 's/\v^(\s*\S)/' . b:escaped_cms[0] . '\1/e'
    else " Multi-line comment.
        " TODO:
        " - Respect the top indent level.
        " - Single line visual mode.
        " - Support 'comments'.
        " - Prevent nested comments.
        " - firstline or lastline is empty.
        silent execute a:firstline . 's/\v^(\s*)(\S)/\1' . b:escaped_cms[0] . ' \2/e'
        silent execute a:lastline . 's/\v(\S)$/\1 ' . b:escaped_cms[1] .'/e'
    endif
endfunction

function! tcmt#Uncomment () range " {{{1
    " TODO: Uncomment without selection (current line).
    call s:GetCms ()
    if empty (b:escaped_cms[1]) " Line comment.
        silent execute a:firstline . ',' . a:lastline . 's/\v^' . b:escaped_cms[0] . '//e'
    else " Multi-line comment.
        silent execute a:firstline . ',' . a:lastline . 's/\v' . b:escaped_cms[0] . ' //e'
        silent execute a:firstline . ',' . a:lastline . 's/\v ' . b:escaped_cms[1] . '//e'
    endif
endfunction

"function! tcmt#ToggleComment () " {{{1
"    if getline ('.') =~ '^\s*' . b:escaped_cms[0]
"        call tcmt#Uncomment ()
"    else
"        call tcmt#Comment ()
"    endif
"endfunction
