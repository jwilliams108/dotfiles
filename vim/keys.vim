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
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

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

" set 4 space tabs
nmap <silent> <F4> :set ts=4 sw=4 sts=4<CR>

" set no width restriction
nmap <silent> <F5> :set tw=0<CR>

" set 120 column width
nmap <silent> <F6> :set tw=120<CR>

" trim trailing whitespace
nmap <silent> <F7> mz:%s/\s\+$//<CR>:let @/=''<CR>`z

" convert tabs to spaces
nmap <silent> <F8> :retab<CR>

" convert 4 space indents to 2 spaces
nmap <silent> <F9> :set ts=4 noet<CR>:retab!<CR>:set et ts=2<CR>:retab<CR>

" convert 2 space indents to 4 spaces
nmap <silent> <F10> :set ts=2 noet<CR>:retab!<CR>:set et ts=4<CR>:retab<CR>

" increase/decrease indentation
vmap <leader>l >gv
vmap <leader>h <gv

"}}}

" ----------------------------------------------------------------------------
" buffers
" ----------------------------------------------------------------------------
"{{{

" list buffers then wait for input to switch
nnoremap <leader>lb :ls<CR>:b<Space>
nnoremap <leader>ld :ls<CR>:bd<Space>
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
map <silent> <leader>c ;%y+<CR> " need to use ; since we've remapped : to ;
map <silent> <leader>v gg"_dGP

" toggle paste mode
nmap <silent> <leader>pa :set invpaste<CR>:set paste?<CR>

"}}}

" ----------------------------------------------------------------------------
" diff
" ----------------------------------------------------------------------------
"{{{

nnoremap <leader>dh :diffthis<CR>
nnoremap <leader>dg :diffget<CR>
nnoremap <leader>dp :diffput<CR>
nnoremap <leader>du :diffupdate<CR>

" do vimdiff clipboard in new window
nnoremap <leader>dt :lefta vnew<CR>gg"_dGP:diffthis<CR><C-w>l:diffthis<CR>

" close vimdiff clipboard new window
nnoremap <leader>dc <C-w>h:bd!<CR>:diffoff<CR>

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
