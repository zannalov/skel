" A handy mark-my-place-and-return script
function! ViewportMarkToggle( returnToPrevious )
    if a:returnToPrevious
        call cursor( w:viewportMarkTopLine , 1 )
        silent normal! zt
        call cursor( w:viewportMarkLine , w:viewportMarkChar )
    else
        let w:viewportMarkTopLine = line('w0')
        let w:viewportMarkLine = line('.')
        let w:viewportMarkChar = col('.')
        echo "Location tagged"
    endif
endfunction

" I don't normally set marks by hand, and it's useful to see your
" previous page, so set up a jump-back
noremap <silent> `~ :call ViewportMarkToggle(0)<CR>
noremap <silent> `` :call ViewportMarkToggle(1)<CR>
