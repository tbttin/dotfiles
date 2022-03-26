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

" Mappings. {{{1
" Save and then convert current markdown file into pdf and open in zathura.
" TODO: make always return 0.
" nnoremap <buffer> glm :write \| make! \| if !v:shell_error \| execute "!zathura " .. expand('%:p:r:s?notes/?\0output/pdf/?') .. '.pdf' \| endif<CR>
nnoremap <buffer> glm :write \| make! \| execute "!zathura " .. expand('%:p:r:s?notes/?\0output/pdf/?') .. '.pdf' <CR>

