" TODO Make a plugin when it is possible.
function! pairs#IsAdjacentPairs () " {{{1
    " TODO Upgrade this function: [\_s*]
    let l:pairs = { '(' : ')', '[' : ']', '{' : '}', '<' : '>', "'" : "'", '"' : '"' }
    let l:mode = mode ()
    if l:mode == 'i' " insert mode.
        let l:open = getline ('.')[col ('.') - 2]
        let l:close = getline ('.')[col ('.') - 1]
    elseif l:mode == 'c' " command line mode.
        let l:open = getcmdline ()[getcmdpos () - 2]
        let l:close = getcmdline ()[getcmdpos () - 1]
    endif
    return get (l:pairs, l:open, 'NONE') == l:close
endfunction

function! pairs#IsMatchOnLHS (pattern) " {{{1
    let l:mode = mode ()
    if l:mode ==# 'i'
        return strpart (getline ('.'), 0, col ('.') - 1) =~ a:pattern
    elseif l:mode ==# 'c'
        return strpart (getcmdline (), 0, getcmdpos () - 1) =~ a:pattern
    endif
endfunction
