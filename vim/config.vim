"basic config {{{

set encoding=utf-8

set hidden
set autoindent
set copyindent
set laststatus=2
set splitbelow
"set splitright
set autowrite
set autoread

"}}}

"theme {{{

syntax on

"}}}

"searching {{{
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

"}}}

"backups and swap {{{

set noswapfile
set backup

set undodir=~/.tmp/vim/undo//
set backupdir=~/.tmp/vim/backup//
set directory=~/.tmp/vim/swap//

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

"}}}

"display tweaks {{{

" extra chars
set list
set listchars=tab:▸\ ,eol:¬,trail:·,extends:❯,precedes:❮

" line numbers
set number
set numberwidth=4

" softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" text
set wrap
set showbreak=↪
set linebreak
set textwidth=120
set colorcolumn=+1

"}}}

"folding {{{

set foldlevelstart=99

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" }}}

"wildchar {{{

set wildchar=<Tab> wildmenu wildmode=full

"}}}
