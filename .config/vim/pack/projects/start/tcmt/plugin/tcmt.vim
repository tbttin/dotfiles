" TODO Make this a git submodule plugin.

if exists ("b:loaded_tcmt")
    finish
endif
let b:loaded_tcmt = 1

function! s:Uncomment () range " {{{
    if !exists ('b:comment_starter')
        let b:comment_starter = split (&commentstring, '%s')[0]
    endif
    silent execute a:firstline . ',' . a:lastline . 's/\v^(\s*)' . escape (b:comment_starter, '/') . '/\1/e'
endfunction " }}}

function! s:Comment () range " {{{
    if !exists ('b:comment_starter')
        let b:comment_starter = split (&commentstring, '%s')[0]
    endif
    silent execute a:firstline . ',' . a:lastline . 's/\v^(\s*)(\S)/\1' . escape (b:comment_starter, '/') . '\2/e'
endfunction " }}}

function! s:ToggleComment () " {{{
    if !exists ('b:comment_starter')
        " TODO Fix this: commentstring=/*%s*/ in c, indent, xdefaults, .etc files.
        let b:comment_starter = split (&commentstring, '%s')[0]
    endif
    if getline ('.') =~ '^\s*' . b:comment_starter
        execute 's/\v^(\s*)' . escape (b:comment_starter, '/') . '/\1/e'
    else
        execute 's/\v^(\s*)(\S)/\1' . escape (b:comment_starter, '/') . '\2/e'
    endif
endfunction " }}}

" TODO Keep cursor position.
" TODO Add operations.
command! -range Uncomment <line1>,<line2>call s:Uncomment ()
command! -range Comment <line1>,<line2>call s:Comment ()
command! -range ToggleComment <line1>,<line2>call s:ToggleComment ()
