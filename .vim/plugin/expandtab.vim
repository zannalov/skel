function! s:onopen()
    " If the file already has literal tabs, then don't expand tabs, otherwise do
    if search( "\t" , "cnw" )
        set noexpandtab
    else
        set expandtab
    endif
endfunction

autocmd BufNewFile,BufReadPost,StdinReadPost * nested call s:onopen()
