" GUI GUI Goodness
if has("gui_running")
    set lines=999 columns=999

    if has("gui_win32")
        set guifont=Lucida_Console:h8:cDEFAULT
        autocmd GUIEnter * simalt ~x
    endif
    if has("gui_mac")
        set lines=75
        set columns=275
    endif
endif
