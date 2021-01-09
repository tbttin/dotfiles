" TODO Add comment operations.

function! s:GetCms () " {{{1
    let l:cms = split (&commentstring, '%s', 1)
    let l:cms[0] = substitute (l:cms[0], '\v\s?$', ' ', '')
    if !empty (l:cms[1])
        let l:cms[1] = substitute (l:cms[1], '\v^\s?', ' ', '')
    endif
    let b:escaped_cms = [escape (l:cms[0], '/*'), escape (l:cms[1], '/*')]
    return b:escaped_cms
endfunction

function! tcmt#Comment () range " {{{1
    call s:GetCms ()
    if empty (b:escaped_cms[1]) " Line comment.
        silent execute a:firstline . ',' . a:lastline . 's/\v^(\s*)(\S)/\1' . b:escaped_cms[0] . '\2/e'
    else " Multi-line comment.
        " TODO:
        " - Respect the top indent level.
        " - Single line visual mode.
        " - Support 'comments'.
        silent execute a:firstline . 's/\v^(\s*)(\S)/\1' . b:escaped_cms[0] . '\2/e'
        silent execute a:lastline . 's/\v$/' . b:escaped_cms[1] . '/e'
    endif
endfunction

function! tcmt#Uncomment () range " {{{1
    " TODO: Uncomment without selection.
    call s:GetCms ()
    silent execute a:firstline . ',' . a:lastline . 's/\v(\s*)' . b:escaped_cms[0] . '/\1/e'
    if !empty (b:escaped_cms[1]) " Multi-line comment.
        silent execute a:firstline . ',' . a:lastline . 's/\v' . b:escaped_cms[1] . '//e'
    endif
endfunction

" function! tcmt#ToggleComment () " {{{1
    " if getline ('.') =~ '^\s*' . b:escaped_cms[0]
        " call tcmt#Uncomment ()
    " else
        " call tcmt#Comment ()
    " endif
" endfunction
