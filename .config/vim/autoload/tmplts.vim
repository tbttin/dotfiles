function! s:ParseTemplate() abort " {{{1
  let l:line_start = 1
  let l:line_end = line('$') > 10 ? 10 : line('$')
  let l:lines = []
  for l:lnum in range(l:line_start, l:line_end)
    let l:line = substitute(getline(l:lnum), '\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]', '\=eval(submatch(1))', 'ge')
    call add(l:lines, l:line)
  endfor
  call setline(l:line_start, l:lines)
endfunction

function! tmplts#LoadTemplate(filename) abort " {{{1
  let l:fullpath = $VIMHOME . '/tmplts/' . a:filename
  if filereadable(l:fullpath)
    silent execute '0read ' . l:fullpath
    call s:ParseTemplate()
  endif
endfunction

function! tmplts#AddFileDescription() " {{{1
  " 0 if not found, no error.
  if search('\cDescription:.\+', 'eW')
    startinsert!
  endif
endfunction

