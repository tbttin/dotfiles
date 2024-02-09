" Load guard {{{1
if exists('b:loaded_after_ftplugin') " Only do this when not done yet for this buffer.
  finish
endif
let b:loaded_after_ftplugin = 1      " Loaded flag.

" Options {{{1
setlocal keywordprg=man   " My man()!

