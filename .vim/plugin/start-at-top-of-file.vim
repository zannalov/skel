" Move to top of file
autocmd BufNewFile,BufReadPost,StdinReadPost * nested call cursor( 1 , 1 )
