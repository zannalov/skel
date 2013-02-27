" Marks in use in this file: v, w

" A handy mark-my-place-and-return script
function! ViewportMarkToggle( returnToPrevious )
    if a:returnToPrevious
        silent normal! `wzt`v
    else
        silent normal! mvHmw
        silent call ViewportMarkToggle( 1 )
        echo "Location tagged"
    endif
endfunction

" I don't normally set marks by hand, and it's useful to see your
" previous page, so set up a jump-back
noremap <silent> `~ :call ViewportMarkToggle(0)<CR>
noremap <silent> `` :call ViewportMarkToggle(1)<CR>
