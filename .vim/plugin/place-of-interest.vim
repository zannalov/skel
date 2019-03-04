highlight PlaceOfInterestColor ctermfg=white ctermbg=red term=NONE cterm=NONE
let @i="⌘"
autocmd BufNewFile,BufReadPost,StdinReadPost * nested call matchadd( "PlaceOfInterestColor" , "⌘" )
