if has("win32")
    function! s:onread()
        if( &readonly )
            let s:choice = confirm( "File is read-only. Attempt to check out file using TFS?" , "&Check Out\n&Make writeable\n&Ignore" , 1 , "Warning" )

            " Check Out
            if( 1 == s:choice )
                silent execute "!cmd /c tf checkout " . fnameescape( expand( "%:p" ) )
                let s:choice = 2 " fall through to mark writable as well
            endif

            " Make writable
            if( 2 == s:choice )
                silent execute "!attrib -R " . fnameescape( expand( "%:p" ) )
                set noreadonly
            endif

            " Ignore
            if( 3 == s:choice )
                setlocal nomodifiable
            endif
        endif
    endfunction

    autocmd BufReadPre * nested call s:onread()
endif
