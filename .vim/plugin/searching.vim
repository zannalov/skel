set nowrapscan  " I can go to the beginning of the file myself

if !exists( 'b:LongFileLines' ) || !b:LongFileLines " See long-file-lines.vim
    set incsearch   " Sweeeet, incremental searching is nice
    set hlsearch    " Highlight searches
endif
