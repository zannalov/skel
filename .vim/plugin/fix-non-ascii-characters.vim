" Jason's Fix Non Ascii Characters - Plain
function! JFNACP()
    %s/‘/'/ge
    %s/’/'/ge
    %s/‚Äô/'/ge
    %s/“/"/ge
    %s/”/"/ge
    %s/‚Äú/"/ge
    %s/‚Äù/"/ge
    %s/—/--/ge
    %s/–/--/ge
    %s/‚Äî/--/ge
    %s/…/.../ge
    %s/®/(reg)/ge
    %s/™/(TM)/ge
    %s/℠/(SM)/ge
    %s/ / /ge
    %s/\s\+¢/ cents/ge
    %s/÷/\//ge
    %s/©/COPYRIGHT /ge
    %s/‚Ä¶/./ge
    %s/‚Ä¶/, /ge
    %s///ge
    %s///ge
    %s/•/* /ge
    %s/‚/,/ge
    %s// /ge
    %s/\s\+$//ge
    normal 1G0
    let @/="[^ -~]"
endfunction

" Jason's Fix Non Ascii Characters - HTML
function! JFNACH()
    %s/&/\&#38;/ge
    %s/‘/\&#8216;/ge
    %s/’/\&#8217;/ge
    %s/‚Äô/'/ge
    %s/“/\&#8220;/ge
    %s/‚Äú/\&#8220;/ge
    %s/”/\&#8221;/ge
    %s/‚Äù/\&#8221;/ge
    %s/—/\&#8212;/ge
    %s/–/\&#8212;/ge
    %s/‚Äî/\&#8212;/ge
    %s/…/\&#8230;/ge
    %s/®/\&#174;/ge
    %s/™/\&#8482;/ge
    %s/℠/\&#x2120;/ge
    %s/ /\&#160;/ge
    %s/¢/\&#162;/ge
    %s/÷/\&#247;/ge
    %s/©/\&#169;/ge
    %s/‚Ä¶/./ge
    %s/‚Ä¶/, /ge
    %s///ge
    %s///ge
    %s/•/\&#8226;/ge
    %s/‚/,/ge
    %s// /ge
    %s/\s\+$//ge
    normal 1G0
    let @/="[^ -~]"
endfunction
