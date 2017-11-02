" ----------------------------------------------------------------------------
" key remaps
" ----------------------------------------------------------------------------
"{{{

let mapleader = "\<space>"

" remap colon
nnoremap ; :
nnoremap <leader>; ;

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

" goto last file
nnoremap <Backspace><Backspace> <C-^>

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
noremap <left>  <C-W><
noremap <right> <C-W>>

"}}}

" ----------------------------------------------------------------------------
" copying
" ----------------------------------------------------------------------------
"{{{

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" line joins/splits
set formatoptions+=j " Delete comment character when joining commented lines
noremap <leader>j :join<CR>
noremap <leader>p i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w

"}}}

" ----------------------------------------------------------------------------
" deleting
" ----------------------------------------------------------------------------
"{{{

nnoremap <leader>da :-d<CR>
nnoremap <leader>db :+d<CR>

"}}}

" ----------------------------------------------------------------------------
" saving
" ----------------------------------------------------------------------------
"{{{

nnoremap <leader>s :w<CR>

"}}}

" ----------------------------------------------------------------------------
" searching
" ----------------------------------------------------------------------------
"{{{

" matchit
runtime macros/matchit.vim
map <tab> %

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
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

"}}}

" ----------------------------------------------------------------------------
" display
" ----------------------------------------------------------------------------
"{{{

" toggle relative numbers
function! NumberToggle()
  if (&relativenumber == 1)
    set number
    set norelativenumber
  else
    set number
    set relativenumber
  endif
endfunc

nnoremap <silent> <F3> :call NumberToggle()<CR>

" wrap
nnoremap <silent> <F11> :set wrap!<CR>

" turn off highlight search - from vim-sensible
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

"}}}

" ----------------------------------------------------------------------------
" whitespace
" ----------------------------------------------------------------------------
"{{{

" set 2 space tabs
nmap <silent> <F2> :set ts=2 sw=2 sts=2<CR>

" convert 4 space indents to 2 spaces
nmap <silent> <leader><F2> :set ts=4 noet<CR>:retab!<CR>:set et ts=2<CR>:retab<CR>

" convert tabs to spaces
nmap <silent> <F3> :retab<CR>

" set 4 space tabs
nmap <silent> <F4> :set ts=4 sw=4 sts=4<CR>

" convert 2 space indents to 4 spaces
nmap <silent> <leader><F4> :set ts=2 noet<CR>:retab!<CR>:set et ts=4<CR>:retab<CR>

" set no width restriction
nmap <silent> <leader>nw :set tw=0<CR>

" set 120 column width
nmap <silent> <leader>sw :set tw=120<CR>

" trim trailing whitespace
nmap <silent> <leader>tw mz:%s/\s\+$//<CR>:let @/=''<CR>`z

" increase/decrease indentation
vmap <leader>l >gv
vmap <leader>h <gv

"}}}

" ----------------------------------------------------------------------------
" buffers
" ----------------------------------------------------------------------------
"{{{

" using Denite buffer and BufExplorer to handle many of these now

" list buffers then wait for input to switch
"nnoremap <leader>lb :ls<CR>:b<Space>
"nnoremap <leader>ld :ls<CR>:bd<Space>
"nnoremap gb :ls<CR>:vert sb<Space>

"nnoremap <leader>b :buffer <C-z><S-Tab>
"nnoremap <leader>B :sbuffer <C-z><S-Tab>

" Move to the previous/next buffer
nnoremap <PageUp>   :bprevious<CR>
nnoremap <PageDown> :bnext<CR>

"nnoremap H :bprevious<CR>
"nnoremap L :bnext<CR>

" Replace remapped H and L
"nnoremap + H
"nnoremap _ L

"}}}

" ----------------------------------------------------------------------------
" clipboard
" ----------------------------------------------------------------------------
"{{{

" copy to/paste from system clipboard
" (requires vim-textobj-entire and vim-system-copy)
map <silent> <leader>c cpae
map <silent> <leader>v cvgg"_dd
map <silent> <leader>V cvgg"_ddG

" toggle paste mode
nmap <silent> <leader>pa :set invpaste<CR>:set paste?<CR>

"}}}

" ----------------------------------------------------------------------------
" diff
" ----------------------------------------------------------------------------
"{{{

nnoremap <silent> <leader>dh :diffthis<CR>
nnoremap <silent> <leader>dg :diffget<CR>
nnoremap <silent> <leader>dp :diffput<CR>
nnoremap <silent> <leader>du :diffupdate<CR>

" do vimdiff clipboard in new window
nnoremap <silent> <leader>dt :lefta vnew<CR>gg"_dGP:diffthis<CR><C-w>l:diffthis<CR>

" close vimdiff clipboard new window
nnoremap <silent> <leader>dc <C-w>h:bd!<CR>:diffoff<CR>

"}}}

" ----------------------------------------------------------------------------
" sorting
" ----------------------------------------------------------------------------
"{{{

" TAB in visual mode: sort
vnoremap <tab> :sort<cr>

"}}}

" ----------------------------------------------------------------------------
" folding
" ----------------------------------------------------------------------------
"{{{

" TAB in normal mode: quick fold toggling
nnoremap <tab><tab> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

"}}}
