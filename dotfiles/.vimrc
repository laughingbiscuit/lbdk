set nocompatible
syntax enable
filetype plugin on
set ts=2
set softtabstop=0
set shiftwidth=2
set relativenumber
set expandtab
set smarttab
set colorcolumn=80

let g:netrw_altv=1
let g:netrw_alto=1
let g:netrw_banner=0

set splitbelow
set splitright


"set formatters
map gg=G :Neoformat<CR>

map Q <Nop>

function! CopyLine()
  exec "!tmux send-keys -t1 '".getline(".")."' && tmux select-pane -t1"
endfunction
noremap hjkl :call CopyLine()<CR><CR>

noremap ; :
let g:netrw_liststyle = 3
