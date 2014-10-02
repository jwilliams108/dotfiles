"leader
let mapleader = ','

"key remaps {{{

" switch semicolon
nnoremap ; :
nnoremap <leader>; ;
nnoremap <leader><leader> ,

imap ii <Esc>

nnoremap Y y$
noremap H ^
noremap L $
vnoremap L g_

"}}}

"movement {{{

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

" bash-like movement
imap <C-f> <Right>
imap <C-b> <Left>
imap <C-a> <Home>
imap <C-e> <End>
imap <C-d> <Del>

"line joins/splits
nmap <C-j> :join<CR>
nmap <C-s> i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w

"}}}

"searching {{{

" matchit
runtime macros/matchit.vim
map <Tab> %

" don't move on *
nnoremap * *<C-o>

" keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
"nnoremap <C-o> <C-o>zz

" Visual Mode */# from Scrooloose
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

"}}}

"display utilities {{{

" toggle [i]nvisible characters
nnoremap <silent> <F2> :set list!<CR>

" wrap
nnoremap <silent> <F3> :set wrap!<CR>

" set text wrapping toggles
nmap <silent> <leader>ww :set invwrap<CR>:set wrap?<CR>

" turn off highlight search
"nmap <silent> <leader><space> :nohls<CR>
nmap <silent> <leader><space> :noh<CR>:call clearmatches()<CR>

" Underline the current line with '='
nmap <silent> <leader>ul :t.\|s/./=/g\|:nohls<cr>

"}}}

"whitespace utilities {{{

" toggle expandtab
nmap <silent> <F4> :set expandtab!<CR>

" set 4 space tabs
nmap <silent> <F5> :set ts=4 sw=4 sts=4<CR>

" set (return to) 2 space tabs
nmap <silent> <F6> :set ts=2 sw=2 sts=2<CR>

" increase/decrease indentation
vmap <leader>l >gv
vmap <leader>h <gv

" trim trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<CR>:let @/=''<CR>`z

" convert tabs to spaces
nnoremap <leader>e :retab<CR>

" convert 4 space indents to 2 spaces
map <leader>r :set ts=4 noet<CR>:retab!<CR>:set et ts=2<CR>:retab<CR>

" insert spaces after colons (for css)
map <leader>: :%s/: \@!/: /g<CR>

"}}}

"buffers {{{

" list buffers then wait for input to switch
nnoremap <leader>ls :ls<CR>:b<Space>

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>
"nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

"}}}

"clipboard {{{

" copy to/replace with clipboard
set clipboard=unnamed
map <leader>c :%y+<CR>
map <leader>v gg"_dGP

"}}}

"vimdiff {{{

" do vimdiff clipboard in new window
nnoremap <leader>dt :vnew<CR>gg"_dGP:diffthis<CR><C-w>l:diffthis<CR>

" close vimdiff clipboard new window
nnoremap <leader>dc <C-w>h:bd!<CR>:diffoff<CR>

"}}}
