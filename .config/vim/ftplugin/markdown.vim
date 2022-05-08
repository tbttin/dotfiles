" Load guard {{{1

if exists('b:loaded_ftplugin') " Only do this when not done yet for this buffer.
  finish
endif
let b:loaded_ftplugin = 1      " Loaded flag.

" Options {{{1

setlocal conceallevel=2        " TODO: italics.
setlocal formatoptions-=l      " Auto format in insert mode.
setlocal path=**,.,$VIMHOME/** " Quickly find other notes and some config files.

" Indentations {{{2

setlocal autoindent " For formating and auto wraping.

" Mappings. {{{1

" Convert markdown note[s] into ".pdf" file[s] and open current file in "zathura".
" Warning: don't mess around with "working directory".
" TODO:
"   - Do nothing when "make" failed.
"   - "make" current file only.
" Save and run.
nnoremap <buffer> <Leader>m :w \| make! \| exe '!zathura notes-output/pdf/' .. expand('%:.:r') .. '.pdf &'<CR><CR><CR>
" Just open pdf file.
nnoremap <buffer> <Leader>M               :exe '!zathura notes-output/pdf/' .. expand('%:.:r') .. '.pdf &'<CR><CR><CR>

