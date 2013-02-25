" A simple on-button script
map <F10> :echo "<".synIDattr(synID(line("."),col("."),1),"name").'> <'.synIDattr(synID(line("."),col("."),0),"name")."> <".synIDattr(synIDtrans(synID(line("."),col("."),1)),"name").">"<CR>
