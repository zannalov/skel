function! s:onopen()
    if !exists( 'b:LongFileLines' ) || !b:LongFileLines " See long-file-lines.vim
        set foldmethod=indent
        set foldlevel=99
        set foldminlines=0
    endif
endfunction

autocmd BufNewFile,BufReadPost,StdinReadPost * nested call s:onopen()
