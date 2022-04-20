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
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab

" Mappings. {{{1

" Toggle hide/show blank characters.
nnoremap <buffer> gltl :set list! list?<CR>

" Convert markdown note[s] into ".pdf" file[s] and open current file in "zathura".
" TODO: Do nothing when make failed.
" Just run.
nnoremap <buffer> glm :make! \| execute '!zathura ' .. expand('%:p:r:s?notes/?\0notes-output/pdf/?') .. '.pdf &'<CR><CR><CR>
" Save and run.
nnoremap <buffer> glM :write \| make! \| execute '!zathura ' .. expand('%:p:r:s?notes/?\0notes-output/pdf/?') .. '.pdf &'<CR><CR><CR>

