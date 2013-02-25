" Format: beginning of line, zero or more white-space, time, white-space, timeOrPlaceholder, optionally white-space optionally followed by more text
" Time: HH:MM[:SS]
" Placeholder: One non-white-space character followed by up to seven of any other character to be directly replaced (does match on white-space)

let s:oneOrMoreWhiteSpace = "\\s\\+"
let s:backMatchBeginningOfLineWhiteSpace = "\\(^\\s*\\)\\@<="
let s:matchTime = "\\d\\d:\\d\\d\\(:\\d\\d\\)\\?"
let s:placeholder = "\\(\\S.\\{0,7\\}\\)"

function! s:gotoStartPos()
    call cursor( s:topLine , 1 )
    silent normal! zt
    call cursor( s:startLine , s:startChar )
endfunction

function! s:gotoEndPos()
    call cursor( s:topLine , 1 )
    silent normal! zt
    call cursor( s:endLine , s:endStartChar )
endfunction

function! s:reportError( errMsg )
    " Indicate to the user that it's a problem
    echoerr a:errMsg

    " Move cursor back to the exact place started
    call s:gotoStartPos()

    " Cop out
    return 0
endfunction

function! s:fillInPlaceholder()
    " Copy the original contents of the register
    let s:originalARegister = @a

    " Copy the contents of the range
    call cursor( s:endLine , s:endStartChar )
    normal v
    call cursor( s:endLine , s:endEndChar )
    normal "ay

    " Find the range of the placeholder
    call cursor( s:startLine , 1 )
    call search( s:backMatchBeginningOfLineWhiteSpace . s:matchTime . s:oneOrMoreWhiteSpace , "ce" , s:startLine )
    let s:placeholderStart = col('.') + 1
    call cursor( s:startLine , 1 )
    call search( s:backMatchBeginningOfLineWhiteSpace . s:matchTime . s:oneOrMoreWhiteSpace . s:placeholder, "ce" , s:startLine )
    let s:placeholderEnd = col('.')

    " Replace the placeholder
    call cursor( s:startLine , s:placeholderStart )
    normal v
    call cursor( s:startLine , s:placeholderEnd )
    normal "aP

    " Restore the original contents of the register
    let @a = s:originalARegister
endfunction

function! s:startAutoFillTimecard()
    " Mark current location
    let s:topLine = line('w0')
    let s:startLine = line('.')
    let s:startChar = col('.')

    " Go to the begining of the line
    call cursor( s:startLine , 1 )

    " Check that the line is valid (note: doesn't move cursor)
    if !search( s:backMatchBeginningOfLineWhiteSpace . s:matchTime . s:oneOrMoreWhiteSpace . s:placeholder , "cn" , s:startLine )
        return s:reportError( "You're not on a valid timecard line (line is either missing first time or placeholder for second time)" )
    endif

    return 1
endfunction

function! FillEndTimecard()
    " Start by marking our position and validating the timecard
    if !s:startAutoFillTimecard()
        return 1
    endif

    " Starting with the next line after our starting line
    call cursor( s:startLine + 1 , 1 )

    " Find the next opening timecard
    if !search( s:backMatchBeginningOfLineWhiteSpace . s:matchTime , "c" , line( '$' ) )
        return s:reportError( "No more timecards match" )
    endif

    " Mark the timecard range
    let s:endLine = line('.')
    let s:endStartChar = col('.')
    call search( s:backMatchBeginningOfLineWhiteSpace . s:matchTime , "ce" , line( '.' ) )
    let s:endEndChar = col('.')

    " Finally, fill in the placeholder
    call s:fillInPlaceholder()

    " Jump to the next timecard
    call s:gotoEndPos()
endfunction

function! FillPointInTime()
    " Start by marking our position and validating the timecard
    if !s:startAutoFillTimecard()
        return 1
    endif

    " Find beginning of opening timecard
    let s:endLine = s:startLine
    call cursor( s:startLine , 1 )
    call search( s:backMatchBeginningOfLineWhiteSpace . s:matchTime , "c" , s:startLine )
    let s:endStartChar = col('.')
    call cursor( s:startLine , 1 )
    call search( s:backMatchBeginningOfLineWhiteSpace . s:matchTime , "ce" , s:startLine )
    let s:endEndChar = col('.')

    " Finally, fill in the placeholder
    call s:fillInPlaceholder()

    " See if we can find the next timecard
    call cursor( s:startLine + 1 , 1 )
    call search( s:backMatchBeginningOfLineWhiteSpace . s:matchTime , "c" , line( '$' ) )
endfunction

let @z=":call FillEndTimecard()\x0A"
let @x=":call FillPointInTime()\x0A"
