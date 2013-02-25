function! s:onopen()
    set textwidth=0 " Disable auto-wrap
    set formatoptions=cq " Only wrap comments
    set nowrap " Don't wrap my lines by default
endfunction

autocmd BufNewFile,BufReadPost,StdinReadPost * nested call s:onopen()
