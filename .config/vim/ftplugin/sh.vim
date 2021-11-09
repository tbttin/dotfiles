" Load guard {{{1
if exists('b:loaded_ftplugin') " Only do this when not done yet for this buffer.
  finish
endif
let b:loaded_ftplugin = 1      " Loaded flag.

" Options {{{1
setlocal isfname+={,}          " Examples: ${XDG_CONFIG_HOME}/vim/vimrc

let g:is_bash = 1              " Use bash syntax highlighting.
let g:sh_fold_enabled = 1      " Enable function folding.
