" Load guard {{{1

if exists('b:loaded_ftplugin') " Only do this when not done yet for this buffer.
  finish
endif
let b:loaded_ftplugin = 1      " Loaded flag.

" Options {{{1

let g:markdown_folding = 1           " Enable section/heading folding, little bit slow but it's okay.
let g:markdown_recommended_style = 0 " Check "$VIMRUNTIME/ftplugin/markdown.vim", ts=sts=sw4 WTF?
setlocal conceallevel=2              " TODO: italics.
setlocal formatoptions-=l            " Auto format in insert mode.
setlocal wildignore+=*.pdf           " Do not suggest .pdf file.

" Indentations {{{2

setlocal autoindent " For formating and auto wraping.

" Mappings. {{{1

" View pdf version of current file.
nnoremap <buffer> <Leader>mm <Plug>View_PDF

" Functions {{{2

" Convert markdown note[s] into ".pdf" file[s] and open current file in "zathura".
" Warning: don't mess around with "working directory".
function! s:View_PDF() " {{{3
  let l:pdf_file = 'output/pdf/' .. expand('%:r:.') .. '.pdf'
  up
  " How to get ":make" return status?
  exe '!make ' .. l:pdf_file
  if !v:shell_error
    exe '!zathura ' .. l:pdf_file .. ' &'
  endif
endfunction

nnoremap <Plug>View_PDF :<C-U>call <SID>View_PDF()<CR><CR><CR>
" End View_PDF() }}}3

" TODO: 'gf' jump to header, see https://vi.stackexchange.com/q/9344
" - ":e +/" suck with section folding.
" - Manual navigation is still acceptable with section folding.

" [foo.md](paht/to/foo.md#header have space) there is another link [this header](#this header)

" function! s:OpenMDFile() " {{{3
"   let l:url = matchstr(getline('.'), '(\zs.\{-}\ze)')
"   let l:parts = split(l:url, '#')
"   " echom "file: " .. l:parts[0]
"   " echom "id: " .. l:parts[1]
"   if len(l:parts) == 2
"     let l:epattern = '+/' .. escape(l:parts[1], ' /\') .. ' ' .. escape(l:parts[0], '\')
"   elseif len(l:parts) == 1
"     let l:epattern = '+/' .. escape(l:parts[0], ' /\') .. ' %'
"   else
"     echo 'l:parts = ??'
"   endif
"   echom l:epattern
"   execute 'edit' l:epattern
" endfunction
" nnoremap <Plug>OpenMDFile :<C-U>call <SID>OpenMDFile()<CR><CR><CR>
" nnoremap <buffer> <Leader>f <Plug>OpenMDFile
" " End OpenMDFile() }}}3

