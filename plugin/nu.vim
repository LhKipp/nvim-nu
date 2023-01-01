function! s:ShowDocumentation(word)
    let nu_help = system('nu -c "help '. a:word .' | str replace -a `\\u001B\\[[0-9;]*m` ``"')
    if v:shell_error == 0
        echo nu_help
    else
        execute '!man '. a:word
    endif
endfunction
command! -nargs=1 ShowDocumentation :call s:ShowDocumentation(<f-args>)

lua require('nu.tree_sitter_config')
