function! s:onopen()
    set textwidth=0 " Disable auto-wrap
    set formatoptions=cqj " Only wrap comments, auto remove comment leader when re-wrapping comments
    set nowrap " Don't wrap my lines by default
endfunction

autocmd BufNewFile,BufReadPost,StdinReadPost * nested call s:onopen()
