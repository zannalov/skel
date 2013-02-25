" When the command LFL1 is run, Long File Lines is enabled, and lots of
" different options which choke on long lines inside files will be disabled.
" This should help prevent long delays in editing files. The command LFL0
" attempts to restore settings to their previous values (but not
" all settings are always restored). NOTE: This is a work in progress.

let s:AUTO_ON_THRESHOLD = 5242880 " 5MB

function! s:on()
    if exists( 'b:LongFileLines' ) && b:LongFileLines
        echoerr "LongFileLines is already on for this buffer"
    endif

    let b:foldmethodkeep = &foldmethod | let &foldmethod = "manual"
    let b:swapfilekeep   = &swapfile   | let &swapfile   = 0
    let b:matchpairskeep = &matchpairs | let &matchpairs = ""
    let b:incsearchkeep  = &incsearch  | let &incsearch  = 0
    let b:hlsearchkeep   = &hlsearch   | let &hlsearch   = 0
    let b:numberkeep     = &number     | let &number     = 0

    syntax off
    filetype off

    let b:LongFileLines = 1
endfunction

function! s:off()
    if !exists( 'b:LongFileLines' ) || !b:LongFileLines
        echoerr "LongFileLines is already off for this buffer"
    endif

    filetype on
    syntax on

    if exists( 'b:numberkeep'     ) | let &number     = b:numberkeep     | endif
    if exists( 'b:hlsearchkeep'   ) | let &hlsearch   = b:hlsearchkeep   | endif
    if exists( 'b:incsearchkeep'  ) | let &incsearch  = b:incsearchkeep  | endif
    if exists( 'b:matchpairskeep' ) | let &matchpairs = b:matchpairskeep | endif
    if exists( 'b:swapfilekeep'   ) | let &swapfile   = b:swapfilekeep   | endif
    if exists( 'b:foldmethodkeep' ) | let &foldmethod = b:foldmethodkeep | endif

    let b:LongFileLines = 0
endfunction

function! s:auto()
    let s:totalLength = line2byte(line('$')) + col([line('$'),'$'])
    if s:totalLength > s:AUTO_ON_THRESHOLD
        call s:on()
    endif
endfunction

command! -nargs=0 LFL0 call s:off()
command! -nargs=0 LFL1 call s:on()
autocmd BufNewFile,BufReadPost,StdinReadPost * nested call s:auto()
