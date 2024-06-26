" Load guard {{{1

if exists('b:loaded_after_ftplugin') " Only do this when not done yet for this buffer.
  finish
endif
let b:loaded_after_ftplugin = 1      " Loaded flag.

" Plugins {{{1

" Extends pear-tree's after/ftplugin/markdown.vim
" TODO:
"   - "*" as a list item indicator.
"   - Fix double emphasizor.
if exists('b:pear_tree_pairs')
  let b:pear_tree_pairs = extend(deepcopy(b:pear_tree_pairs), {
                          \ '_'  : {'closer': '_'},
                          \ '*'  : {'closer': '\*'}
                          \ }, 'keep')
endif

