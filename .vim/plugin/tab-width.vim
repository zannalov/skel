function! s:onopen()
    " By default use 4 as the tab width
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
endfunction

autocmd BufNewFile,BufReadPost,StdinReadPost * nested call s:onopen()
