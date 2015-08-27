" ----------------------------------------------------------------------------
" key remaps
" ----------------------------------------------------------------------------
"{{{

let mapleader = ','

" remap colon
noremap <Space> :
nnoremap ; :
nnoremap <leader>; ;
nnoremap <leader><leader> ,

"nnoremap Y y$
"noremap H ^
"noremap L $
"vnoremap L g_

"}}}

" ----------------------------------------------------------------------------
" movement
" ----------------------------------------------------------------------------
"{{{

" larger moves
nmap J 5j
nmap K 5k
xmap J 5j
xmap K 5k

" emacs-like movement
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
cnoremap <C-D> <Del>

" move tabs
nmap <C-l> gt
nmap <C-h> gT

"}}}

" ----------------------------------------------------------------------------
" splits
" ----------------------------------------------------------------------------
"{{{

nnoremap s <C-W>
autocmd filetype netrw nnoremap <buffer> s <C-W>

" navigate splits
nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l

" swap split
nmap gH <C-w>r
nmap gK <C-w>r

" resize splits
noremap <up>    <C-W>+
noremap <down>  <C-W>-
noremap <left>  3<C-W><
noremap <right> 3<C-W>>

"}}}

" ----------------------------------------------------------------------------
" copying
" ----------------------------------------------------------------------------
"{{{

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" line joins/splits
noremap <leader>j :join<CR>
noremap <leader>s i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w

"}}}

" ----------------------------------------------------------------------------
" searching
" ----------------------------------------------------------------------------
"{{{

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

" open a Quickfix window for the last search.
nnoremap <silent> ,/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

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

" ----------------------------------------------------------------------------
" display
" ----------------------------------------------------------------------------
"{{{

" toggle [i]nvisible characters
nnoremap <silent> <F7> :set list!<CR>

" wrap
nnoremap <silent> <F8> :set wrap!<CR>

" set text wrapping toggles
nmap <silent> <leader>ww :set invwrap<CR>:set wrap?<CR>

" turn off highlight search
"nmap <silent> <leader><space> :nohls<CR>
nmap <silent> <leader><space> :noh<CR>:call clearmatches()<CR>

"}}}

" ----------------------------------------------------------------------------
" whitespace
" ----------------------------------------------------------------------------
"{{{

" set 2 space tabs
nmap <silent> <F2> :set ts=2 sw=2 sts=2<CR>

" set 4 space tabs
nmap <silent> <F4> :set ts=4 sw=4 sts=4<CR>

" set no width restriction
nmap <silent> <F5> :set tw=0<CR>

" set 120 column width
nmap <silent> <F6> :set tw=120<CR>

" increase/decrease indentation
vmap <leader>l >gv
vmap <leader>h <gv

" trim trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<CR>:let @/=''<CR>`z

" convert tabs to spaces
nnoremap <leader>e :retab<CR>

" convert 4 space indents to 2 spaces
map <leader>r :set ts=4 noet<CR>:retab!<CR>:set et ts=2<CR>:retab<CR>

" convert 2 space indents to 4 spaces
map <leader>R :set ts=2 noet<CR>:retab!<CR>:set et ts=4<CR>:retab<CR>

"}}}

" ----------------------------------------------------------------------------
" buffers
" ----------------------------------------------------------------------------
"{{{

" list buffers then wait for input to switch
nnoremap <leader>ll :ls<CR>:b<Space>
nnoremap gb :ls<CR>:vert sb<Space>

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

"}}}

" ----------------------------------------------------------------------------
" clipboard
" ----------------------------------------------------------------------------
"{{{

" copy to/replace with clipboard
set clipboard=unnamed
map <silent> <leader>c :%y+<CR>
map <silent> <leader>v gg"_dGP

" toggle paste mode
nmap <silent> <leader>p :set invpaste<CR>:set paste?<CR>

"}}}

" ----------------------------------------------------------------------------
" diff
" ----------------------------------------------------------------------------
"{{{

nnoremap <Leader>dh :diffthis<CR>
nnoremap <Leader>dg :diffget<CR>
nnoremap <Leader>dp :diffput<CR>
nnoremap <Leader>du :diffupdate<CR>

" do vimdiff clipboard in new window
nnoremap <leader>dt :vnew<CR>gg"_dGP:diffthis<CR><C-w>l:diffthis<CR>

" close vimdiff clipboard new window
nnoremap <leader>dc <C-w>h:bd!<CR>:diffoff<CR>

"}}}

" ----------------------------------------------------------------------------
" folding
" ----------------------------------------------------------------------------
"{{{

" Space to toggle folds.
nnoremap z<space> za
vnoremap z<space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

"}}}
