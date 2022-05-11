" TODO:
"   - Make a plugin when it is possible.
"   - Support ex-cmdline + escape(\{})
function! pairs#IsAdjacentPairs() " {{{1
  " TODO: Upgrade this function: [\_s*]
  let l:pairs = { '(' : ')', '[' : ']', '{' : '}', '<' : '>', "'" : "'", '"' : '"' }
  let l:mode = mode()
  if l:mode == 'i'
    let l:open = getline('.')[col('.') - 2]
    let l:close = getline('.')[col('.') - 1]
  elseif l:mode == 'c'
    let l:open = getcmdline()[getcmdpos() - 2]
    let l:close = getcmdline()[getcmdpos() - 1]
  endif
  return get(l:pairs, l:open, 'NONE') == l:close
endfunction

function! pairs#IsMatchOnLHS(pattern) " {{{1
  let l:mode = mode()
  if l:mode ==# 'i'
    return strcharpart(getline('.'), 0, col('.') - 1) =~ a:pattern
  elseif l:mode ==# 'c'
    return strcharpart(getcmdline(), 0, getcmdpos() - 1) =~ a:pattern
  endif
endfunction
