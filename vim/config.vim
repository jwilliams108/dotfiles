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
set splitbelow
"set splitright
set autowrite
set autoread

"}}}

" ----------------------------------------------------------------------------
" theme
" ----------------------------------------------------------------------------
"{{{

syntax on

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

" prefer silver search if available
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

"}}}

" ----------------------------------------------------------------------------
" backups and swap
" ----------------------------------------------------------------------------
"{{{

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

" text
set wrap
set showbreak=↪
set linebreak
set textwidth=120
set colorcolumn=+1

" change shape of cursor in insert mode in iTerm 2
let s:iterm   = exists('$ITERM_PROFILE') || exists('$ITERM_SESSION_ID') || filereadable(expand("~/.vim/.assume-iterm"))
let s:tmux    = exists('$TMUX')

function! s:EscapeEscapes(string)
  " double each <Esc>
  return substitute(a:string, "\<Esc>", "\<Esc>\<Esc>", "g")
endfunction

function! s:TmuxWrap(string)
  if strlen(a:string) == 0
    return ""
  end

  let tmux_begin  = "\<Esc>Ptmux;"
  let tmux_end    = "\<Esc>\\"

  return tmux_begin . s:EscapeEscapes(a:string) . tmux_end
endfunction

if s:iterm
  let start_insert  = "\<Esc>]50;CursorShape=1\x7"
  let end_insert    = "\<Esc>]50;CursorShape=2\x7"

  if s:tmux
    let start_insert  = s:TmuxWrap(start_insert)
    let end_insert    = s:TmuxWrap(end_insert)
  endif

  let &t_SI = start_insert
  let &t_EI = end_insert
endif

"}}}

" ----------------------------------------------------------------------------
" folding
" ----------------------------------------------------------------------------
"{{{

set foldlevelstart=99

" }}}

" ----------------------------------------------------------------------------
" wildchar
" ----------------------------------------------------------------------------
"{{{

set wildchar=<Tab> wildmenu wildmode=full

"}}}
