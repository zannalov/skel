function! ToASCII()
    if !&readonly
        set nobomb
        set encoding=latin1
        set fileencoding=latin1
    endif
endfunction
