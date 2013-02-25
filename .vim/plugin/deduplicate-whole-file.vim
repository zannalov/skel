" Deduplicate lines from a file, keeping the first copy of each line
" Credit goest to http://vim.wikia.com/wiki/Uniq_-_Removing_duplicate_lines
nno <Leader>d1 :g/^/kl\|if search('^'.escape(getline('.'),'\.*[]^$/').'$','bW')\|'ld<CR>
