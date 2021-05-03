function! s:ShowDocumentation(word)
    execute '!nu -c "help '. a:word .'"'
endfunction
command! -nargs=1 ShowDocumentation :call s:ShowDocumentation(<f-args>)

lua require('nu.tree_sitter_config')
