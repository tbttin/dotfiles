" TODO Support both line comment and multi-line comment.
" TODO Add comment operations.

function! s:GetCmtStarter () " {{{1
    if !exists ('b:escaped_line_cms')
        " Extract line comment string.
        let b:escaped_line_cms = escape (split (&commentstring, '%s')[0], '/')
    endif
    return b:escaped_line_cms
endfunction

function! tcmt#Uncomment () range " {{{1
    call s:GetCmtStarter ()
    execute a:firstline . ',' . a:lastline . 's/\v^(\s*)' . b:escaped_line_cms . '/\1/e'
endfunction

function! tcmt#Comment () range " {{{1
    call s:GetCmtStarter ()
    execute a:firstline . ',' . a:lastline . 's/\v^/' . b:escaped_line_cms . '/e'
endfunction

function! tcmt#ToggleComment () " {{{1
    if getline ('.') =~ '^\s*' . b:escaped_line_cms
        call tcmt#Uncomment ()
    else
        call tcmt#Comment ()
    endif
endfunction
