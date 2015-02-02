"leader
let mapleader = ','

"key remaps {{{

" switch semicolon
nnoremap ; :
nnoremap <leader>; ;
nnoremap <leader><leader> ,

"nnoremap Y y$
"noremap H ^
"noremap L $
"vnoremap L g_

"}}}

"movement {{{

" move splits
nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l

"noremap <C-h> <C-w>h
"noremap <C-j> <C-w>j
"noremap <C-k> <C-w>k
"noremap <C-l> <C-w>l

" swap split
nmap gH <C-w>r
nmap gK <C-w>r

" resize splits
noremap <up>    <C-W>+
noremap <down>  <C-W>-
noremap <left>  3<C-W><
noremap <right> 3<C-W>>

" move tabs
nmap <C-l> gt
nmap <C-h> gT

" larger moves
nmap J 5j
nmap K 5k
xmap J 5j
xmap K 5k

" bash/emacs-like movement
cnoremap <C-A>      <Home>
cnoremap <C-B>      <Left>
cnoremap <C-E>      <End>
cnoremap <C-F>      <Right>
cnoremap <C-N>      <End>
cnoremap <C-P>      <Up>
cnoremap <C-D>      <Del>

"}}}

"copying {{{

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"line joins/splits
noremap <leader>j :join<CR>
noremap <leader>s i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w

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

" highlight last inserted text
nmap gV `[v`]

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

" set no width restriction
nmap <silent> <F7> :set tw=0

" set (return to) 120 column width
nmap <silent> <F8> :set tw=120<CR>

" increase/decrease indentation
vmap <leader>l >gv
vmap <leader>h <gv

" trim trailing whitespace
nnoremap <leader>h mz:%s/\s\+$//<CR>:let @/=''<CR>`z

" convert tabs to spaces
nnoremap <leader>a :retab<CR>

" convert 4 space indents to 2 spaces
map <leader>r :set ts=4 noet<CR>:retab!<CR>:set et ts=2<CR>:retab<CR>

" convert 2 space indents to 4 spaces
map <leader>R :set ts=2 noet<CR>:retab!<CR>:set et ts=4<CR>:retab<CR>

" insert spaces after colons (for css)
map <leader>: :%s/: \@!/: /g<CR>

"}}}

"buffers {{{

" list buffers then wait for input to switch
nnoremap <leader>ls :ls<CR>:b<Space>
nnoremap gb :ls<CR>:b<Space>
nnoremap gB :ls<CR>:vert sb<Space>

"nnoremap ,b :buffer <C-z><S-Tab>
"nnoremap ,B :sbuffer <C-z><S-Tab>

" Move to the previous/next buffer
nnoremap <PageUp>   :bprevious<CR>
nnoremap <PageDown> :bnext<CR>

nnoremap H :bprevious<CR>
nnoremap L :bnext<CR>

" Replace remapped H and L
nnoremap + H
nnoremap _ L

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>
"nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

"}}}

"clipboard {{{

" toggle paste mode
nmap <silent> <leader>p :set invpaste<CR>:set paste?<CR>

" copy to/replace with clipboard
set clipboard=unnamed
map <silent> <leader>c :%y+<CR>
map <silent> <leader>v gg"_dGP

"}}}

"vimdiff {{{

" do vimdiff clipboard in new window
nnoremap <leader>dt :vnew<CR>gg"_dGP:diffthis<CR><C-w>l:diffthis<CR>

" close vimdiff clipboard new window
nnoremap <leader>dc <C-w>h:bd!<CR>:diffoff<CR>

"}}}
