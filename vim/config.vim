set encoding=utf-8
scriptencoding utf-8

" ----------------------------------------------------------------------------
" basic config
" ----------------------------------------------------------------------------
"{{{

set hidden
set autoindent
set copyindent
set laststatus=2
set noshowmode
set splitbelow
set splitright
set autowrite
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
    call mkdir(expand(&directory), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
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
set numberwidth=4

" softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
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

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

"}}}

" ----------------------------------------------------------------------------
" grepping
" ----------------------------------------------------------------------------
"{{{

if executable('ag')
    set grepprg=ag\ --vimgrep
    set grepformat=%f:%l:%c:%m,%f:%l:%m
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
set wildignore+=.git,.hg,.svn
set wildignore+=*.swp,.lock,.DS_Store,._*

"}}}

" ----------------------------------------------------------------------------
" omnifunc
" ----------------------------------------------------------------------------
"{{{

set completeopt-=preview

"}}}

" ----------------------------------------------------------------------------
" folding
" ----------------------------------------------------------------------------
"{{{

set nofoldenable
set foldlevel=99
set foldlevelstart=99

" }}}

" ----------------------------------------------------------------------------
" theme
" ----------------------------------------------------------------------------
"{{{

colorscheme hybrid

"}}}
