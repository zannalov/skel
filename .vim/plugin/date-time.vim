" Insert date/time using Ctrl-D and Ctrl-T
inoremap <C-d> <C-r>=strftime("%Y-%m-%d")<CR>
inoremap <C-t> <C-r>=strftime("%H:%M:%S")<CR>
