function! UUID()
    let @" = system( "uuidgen" )
    let @" = substitute( @" , "\\n" , "" , "g" )
    let @" = substitute( @" , "^\\s\\+" , "" , "g" )
    let @" = substitute( @" , "\\s\\+$" , "" , "g" )
    normal P
endfunction
