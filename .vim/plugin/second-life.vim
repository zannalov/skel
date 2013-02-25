" Jason's SL Debug Commands
function! JSLDC()
    %s/\<FALSE\>/0/ge
    %s/\<TRUE\>/1/ge
    %s/\/\*\(\(\*\/\)\@!\_.\)*\*\///ge
    %s/^\s\+//ge
    %s/\s\+$//ge
    %s/\s\+\ze[^a-zA-Z0-9_]//ge
    %s/[^a-zA-Z0-9_]\zs\s\+//ge
    %s/\n\+/\r/ge
endfunction

" Jason's SL Compression Commands
function! JSLCC()
    %s/^.*\/\* DEBUG \*\/.*$//e
    call JSLDC()
    %s/\([a-zA-Z0-9_]\)\n\+\([a-zA-Z0-9_]\)/\1 \2/ge
    %s/\n\+//ge
endfunction
