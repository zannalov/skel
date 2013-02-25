let s:matching = 0
highlight MatchColor ctermfg=white ctermbg=blue term=NONE cterm=NONE

function! s:on()
    if !s:matching
        let s:matching = 1
        let s:matchLongColumns = matchadd( "MatchColor" , "\\%>80v" )
        let s:matchExcessiveLines = matchadd( "MatchColor" , "\\%>299l" )
        let s:matchLiteralTabs = matchadd( "MatchColor" , "\\t" )
        let s:matchTrailingWhiteSpace = matchadd( "MatchColor" , "\\s\\+$" )
    endif
endfunction

function! s:off()
    if s:matching
        let s:matching = 0
        call matchdelete( s:matchLongColumns )
        call matchdelete( s:matchExcessiveLines )
        call matchdelete( s:matchLiteralTabs )
        call matchdelete( s:matchTrailingWhiteSpace )
    endif
endfunction

function! s:toggle()
    if s:matching
        call s:off()
    else
        call s:on()
    endif
endfunction

command! -nargs=0 JMatchOn :call s:on()
command! -nargs=0 JMatchOff :call s:off()
command! -nargs=0 JMatch :call s:toggle()
