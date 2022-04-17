" Load guard {{{1
if exists('b:loaded_ftplugin') " Only do this when not done yet for this buffer.
  finish
endif
let b:loaded_ftplugin = 1      " Loaded flag.

" Options {{{1
setlocal conceallevel=2   " TODO: italics.
setlocal formatoptions-=l " Auto format in insert mode.
setlocal autoindent       " For formating and auto wraping.
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

" Mappings. {{{1

" Toggle hide/show blank characters.
nnoremap <buffer> gltl :set list! list?<CR>

" Save and then convert current markdown file into pdf and open in zathura.
" TODO: Do nothing when make failed.
nnoremap <buffer> glm :make! \| execute '!zathura ' .. expand('%:p:r:s?notes/?\0notes-output/pdf/?') .. '.pdf &'<CR><CR><CR>

