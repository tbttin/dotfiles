" Load guard {{{1

if exists('b:loaded_ftplugin') " Only do this when not done yet for this buffer.
  finish
endif
let b:loaded_ftplugin = 1      " Loaded flag.

" Options {{{1

let g:markdown_folding = 1 " Enable section/heading folding, little bit slow but it's okay.
setlocal conceallevel=2    " TODO: italics.
setlocal formatoptions-=l  " Auto format in insert mode.
setlocal wildignore+=*.pdf " Do not suggest .pdf file.
setlocal path=.,**         " Current file directory, recursive project directory.

" Indentations {{{2

setlocal autoindent " For formating and auto wraping.

" Mappings. {{{1

" View pdf version of current file.
nnoremap <buffer> <Leader>m <Plug>View_PDF

" Functions {{{2

" Convert markdown note[s] into ".pdf" file[s] and open current file in "zathura".
" Warning: don't mess around with "working directory".
function! s:View_PDF()
  let l:pdf_file = 'notes-output/pdf/' .. expand('%:r:.') .. '.pdf'
  up
  " How to get ":make" return status?
  exe '!make ' .. l:pdf_file
  if !v:shell_error
    exe '!zathura ' .. l:pdf_file .. ' &'
  endif
endfunction

nnoremap <Plug>View_PDF :<C-U>call <SID>View_PDF()<CR><CR><CR>

