" Load guard {{{1

if exists('b:loaded_after_ftplugin') " Only do this when not done yet for this buffer.
  finish
endif
let b:loaded_after_ftplugin = 1      " Loaded flag.

" Plugins {{{1

" Add strong and emphasis auto-completion to pear-tree plugin.
" TODO: * as list item indicator.
if exists('b:pear_tree_pairs')
  let b:pear_tree_pairs = extend(deepcopy(b:pear_tree_pairs), {
                          \ '_'  : {'closer': '_'},
                          \ '*'  : {'closer': '\*'}
                          \ }, 'keep')
endif

