"basic config {{{

set encoding=utf-8

set hidden
set autoindent
set copyindent
set laststatus=2
set splitbelow
set splitright
set autowrite
set autoread

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
set wrap

" text
set showbreak=↪
set linebreak
set textwidth=80
set colorcolumn=+1

"}}}

"folding {{{

set foldlevelstart=0

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a little bit (15 lines) above the center of the screen.
" 4. Pulse the cursor line.  My eyes are bad.
"
" This mapping wipes out the z mark, which I never use.
"
" I use :sus for the rare times I want to actually background Vim.
nnoremap <C-z> mzzMzvzz15<C-e>`z:Pulse<CR>

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}

set foldtext=MyFoldText()

" }}}

"wildchar {{{

set wildchar=<Tab> wildmenu wildmode=full

"}}}
