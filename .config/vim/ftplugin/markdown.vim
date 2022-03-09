" Load guard {{{1
if exists('b:loaded_ftplugin') " Only do this when not done yet for this buffer.
  finish
endif
let b:loaded_ftplugin = 1      " Loaded flag.

" Options {{{1
setlocal softtabstop=4
setlocal shiftwidth=4

" Mappings. {{{1
" Save and then convert current markdown file into pdf and open in zathura.
nnoremap <buffer> glm :write \| make \| if !v:shell_error \| execute "!zathura " .. expand('%:p:r:s?notes/?\0output/pdf/?') .. '.pdf' \| endif<CR>

