function! s:onopen()
    let @/=""
endfunction

" Dehighlight any previous search at opening
autocmd BufNewFile,BufReadPost,StdinReadPost * nested call s:onopen()
