setlocal commentstring=#%s
setlocal keywordprg=:ShowDocumentation

if !exists("b:undo_ftplugin") | let b:undo_ftplugin = '' | endif
let b:undo_ftplugin .= '|setlocal commentstring<'
    \ . '|setlocal keywordprg<'
