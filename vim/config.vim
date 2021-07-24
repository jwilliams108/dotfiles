set encoding=utf-8
scriptencoding utf-8

filetype plugin indent on
syntax on

" ----------------------------------------------------------------------------
" basic config
" ----------------------------------------------------------------------------
"{{{

set backspace=indent,eol,start
set hidden
set laststatus=2
set splitbelow
set splitright
set breakindent
set autoindent
set autoread

"}}}

" ----------------------------------------------------------------------------
" swap, backups and undo
" ----------------------------------------------------------------------------
"{{{

set noswapfile
set backup
set undofile
set undolevels=1000
set undoreload=10000

set directory=~/.tmp/vim/swap//
set backupdir=~/.tmp/vim/backup//
set undodir=~/.tmp/vim/undo//

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), 'p')
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), 'p')
endif
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), 'p')
endif

"}}}

" ----------------------------------------------------------------------------
" display tweaks
" ----------------------------------------------------------------------------
"{{{

" extra chars
set list
set listchars=tab:▸\ ,eol:¬,trail:·,extends:❯,precedes:❮

" line numbers
set number
set relativenumber
set numberwidth=4

" softtabs, 4 spaces
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab

" whitespace/text
set wrap
set showbreak=↪
set linebreak         " no explicit linebreaks
set nojoinspaces      " ensure J command doesn't add extra space
set textwidth=120
set colorcolumn=+1    " show visual indicator of textwidth limit

"}}}

" ----------------------------------------------------------------------------
" searching
" ----------------------------------------------------------------------------
"{{{

set gdefault
set smartcase
set showmatch
set hlsearch
set ignorecase
set incsearch

"}}}

" ----------------------------------------------------------------------------
" grepping
" ----------------------------------------------------------------------------
"{{{

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --vimgrep
    set grepformat^=%f:%l:%c:%m
endif

" }}}

" ----------------------------------------------------------------------------
" wild and file globbing
" ----------------------------------------------------------------------------
"{{{

set browsedir=buffer                  " browse files in same dir as open file
set wildmenu                          " Enhanced command line completion.
set wildmode=list:longest,full        " Complete files using a menu AND list

" ignores
set wildignore+=*.swp,*.bak,.DS_Store
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/node_modules/*,*/bower_components/*
set wildignore+=*/vendor/*
set wildignore+=*.pyc,*.pyo

"}}}

" ----------------------------------------------------------------------------
" omnifunc
" ----------------------------------------------------------------------------
"{{{

set completeopt=menu,menuone,noselect,noinsert
set complete=.,w,b,u,U,i,t

"}}}

" ----------------------------------------------------------------------------
" tags
" ----------------------------------------------------------------------------
"{{{

set tags=./tags;,tags;

"}}}

" ----------------------------------------------------------------------------
" folding
" ----------------------------------------------------------------------------
"{{{

set foldenable
set foldlevel=99

" }}}
