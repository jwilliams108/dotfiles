" Leader
let mapleader = ','

" remaps
" switch semicolon
nnoremap ; :
nnoremap <leader>; ;
nnoremap <leader><leader> ,

" move splits
nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l

" move tabs
nmap <C-l> gt
nmap <C-h> gT

" larger moves
nmap J 5j
nmap K 5k
xmap J 5j
xmap K 5k

imap ii <Esc>
nmap <leader>ll :set list!<CR>

" bash-like movement
imap <C-f> <Right>
imap <C-b> <Left>
imap <C-a> <Home>
imap <C-e> <End>
imap <C-d> <Del>

" utilities
" increase/decrease indentation
vmap <leader>l >gv
vmap <leader>h <gv

" trim trailing whitespace
nnoremap <leader>w :%s/\s\+$//<CR>:let @/=''<CR>

" convert tabs to spaces
nnoremap <leader>e :retab<CR>

" convert 4 space indents to 2 spaces
map <leader>r :set ts=4 noet<CR>:retab!<CR>:set et ts=2<CR>:retab<CR>

" insert spaces after colons (for css)
map <leader>: :%s/: \@!/: /g<CR>

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>
"nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Turn off highlight search
nmap <silent> <leader><space> :nohls<CR>

" set text wrapping toggles
nmap <silent> <leader>ww :set invwrap<CR>:set wrap?<CR>

" Underline the current line with '='
nmap <silent> <leader>ul :t.\|s/./=/g\|:nohls<cr>

"copy to/replace with clipboard
set clipboard=unnamed
map <leader>c :%y+<CR>
map <leader>v gg"_dGP

" do vimdiff clipboard in new window
nnoremap <leader>dt :vnew<CR>gg"_dGP:diffthis<CR><C-w>l:diffthis<CR>

" close vimdiff clipboard new window
nnoremap <leader>dc <C-w>h:bd!<CR>:diffoff<CR>
