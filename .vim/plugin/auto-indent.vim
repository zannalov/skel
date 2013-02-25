function! s:onopen()
    " Only use ai, not cin
    set nocindent
    set autoindent
endfunction

autocmd BufNewFile,BufReadPost,StdinReadPost * nested call s:onopen()
