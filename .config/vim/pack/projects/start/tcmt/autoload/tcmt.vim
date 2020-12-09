" TODO Keep cursor position.
" TODO Add operations.

function! tcmt#Uncomment () range " {{{1
    if !exists ('b:comment_starter')
        let b:comment_starter = split (&commentstring, '%s')[0]
    endif
    silent execute a:firstline . ',' . a:lastline . 's/\v^(\s*)' . escape (b:comment_starter, '/') . '/\1/e'
endfunction

function! tcmt#Comment () range " {{{1
    if !exists ('b:comment_starter')
        let b:comment_starter = split (&commentstring, '%s')[0]
    endif
    "silent execute a:firstline . ',' . a:lastline . 's/\v^(\s*)(\S)/\1' . escape (b:comment_starter, '/') . '\2/e'
    silent execute a:firstline . ',' . a:lastline . 's/\v^(\s*\S)/' . escape (b:comment_starter, '/') . '\1/e'
endfunction

function! tcmt#ToggleComment () " {{{1
    " TODO Fix this: commentstring=/*%s*/ in c, indent, xdefaults, .etc files.
    if !exists ('b:comment_starter')
        let b:comment_starter = split (&commentstring, '%s')[0]
    endif
    if getline ('.') =~ '^\s*' . b:comment_starter
        execute 's/\v^(\s*)' . escape (b:comment_starter, '/') . '/\1/e'
    else
"        execute 's/\v^(\s*)(\S)/\1' . escape (b:comment_starter, '/') . '\2/e'
        execute 's/\v^(\s*\S)/' . escape (b:comment_starter, '/') . '\1/e'
    endif
endfunction

" command {{{1
"command! -range Uncomment <line1>,<line2>call s:Uncomment ()
"command! -range Comment <line1>,<line2>call s:Comment ()
"command! -range ToggleComment <line1>,<line2>call s:ToggleComment ()
