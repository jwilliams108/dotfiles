" ----------------------------------------------------------------------------
" netrw
" ----------------------------------------------------------------------------
"{{{

let g:netrw_liststyle = 0
let g:netrw_altfile = 1
let g:netrw_dirhistmax = 0
let g:netrw_list_hide='.*\.swp$,\.DS_Store'

"}}}

" ----------------------------------------------------------------------------
" vim-grepper
" ----------------------------------------------------------------------------
"{{{

nmap \ :Grepper -tool ag -grepprg ag --vimgrep<CR>

"}}}

" ----------------------------------------------------------------------------
" denite
" ----------------------------------------------------------------------------
"{{{

call denite#custom#option('default', {  'prompt': '❯'  })

if executable('ag')
    call denite#custom#var('file_rec', 'command', ['ag', '-l', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif

" key maps
call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>', 'noremap')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('normal', '<Esc>', '<NOP>', 'noremap')
call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('normal', '<C-e>', '<denite:do_action:execute>', 'noremap')

highlight link deniteMatchedChar Special

nnoremap <C-p> :<C-u>Denite file_rec -highlight-mode-insert=Search -highlight-mode-normal=Search<CR>
nnoremap <leader>ls :<C-u>Denite buffer -highlight-mode-insert=Search -highlight-mode-normal=Search<CR>
nnoremap <leader>ll :<C-u>Denite line -highlight-mode-insert=Search -highlight-mode-normal=Search<CR>

"}}}

" ----------------------------------------------------------------------------
" denite extras, git, etc.
" ----------------------------------------------------------------------------
"{{{

nnoremap <leader>hs :<C-u>Denite history:search -mode=normal -highlight-mode-insert=Search -highlight-mode-normal=Search<CR>
nnoremap <leader>hc :<C-u>Denite history:cmd -mode=normal -highlight-mode-insert=Search -highlight-mode-normal=Search<CR>
nnoremap <leader>gl :<C-u>Denite gitlog -highlight-mode-insert=Search -highlight-mode-normal=Search<CR>

"}}}

" ----------------------------------------------------------------------------
" tagbar
" ----------------------------------------------------------------------------
"{{{

nmap <leader>lt :TagbarToggle<CR>

"}}}

" ----------------------------------------------------------------------------
" BufExplorer
" ----------------------------------------------------------------------------
"{{{

let g:bufExplorerSplitHorzSize = 15

nmap <silent> <leader>lS :BufExplorerHorizontalSplit<CR>

"}}}

" ----------------------------------------------------------------------------
" vim-jsx
" ----------------------------------------------------------------------------
"{{{

let g:jsx_ext_required = 0

"}}}

" ----------------------------------------------------------------------------
" ale
" ----------------------------------------------------------------------------
"{{{

let g:ale_linters = {
\   'css': ['stylelint'],
\   'javascript': ['eslint'],
\   'perl': ['perlcritic'],
\   'php': ['phpcs'],
\}

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
"let g:ale_php_phpcs_standard = '~/.phpcs/phpcs.xml'
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_statusline_format = ['>> %d', '-- %d', '']

nmap <silent> [r <Plug>(ale_previous_wrap)
nmap <silent> ]r <Plug>(ale_next_wrap)

" fixers
let g:ale_fixers = { 'javascript': ['prettier'] }
let g:ale_javascript_prettier_options = '--print-width 120 --single-quote --trailing-comma all'

nmap <silent> <leader>fm :ALEFix<CR>

"}}}

" ----------------------------------------------------------------------------
" ListToggle
" ----------------------------------------------------------------------------
"{{{

let g:lt_height = 10

nmap <silent> <F12> :LToggle<CR>
nmap <silent> <F11> :QToggle<CR>

"}}}

" ----------------------------------------------------------------------------
" delimitMate
" ----------------------------------------------------------------------------
"{{{

imap <expr><CR> pumvisible() ? "\<C-n>" : "<plug>delimitMateCR"

"}}}

" ----------------------------------------------------------------------------
" vim-fugitive
" ----------------------------------------------------------------------------
"{{{

nmap <silent> <leader>gd  :Gvdiff<CR>
nmap <silent> <leader>gs  :Gstatus<CR>
nmap <silent> <leader>gw  :Gwrite<CR>
nmap <silent> <leader>ga  :Gadd<CR>
nmap <silent> <leader>gb  :Gblame<CR>
nmap <silent> <leader>gco :Gcheckout<CR>
nmap <silent> <leader>gci :Gcommit<CR>
nmap <silent> <leader>gm  :Gmove<CR>
nmap <silent> <leader>gr  :Gremove<CR>

"}}}

" ----------------------------------------------------------------------------
" gitgutter
" ----------------------------------------------------------------------------
"{{{

highlight clear SignColumn
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow

"}}}

" ----------------------------------------------------------------------------
" lightline
" ----------------------------------------------------------------------------
"{{{

let g:lightline = {
  \ 'colorscheme': 'hybrid',
  \ 'active': {
  \   'left': [ [ 'mode' ],
  \             [ 'fugitive', 'filename' ],
  \             [ 'ctrlpmark' ] ],
  \   'right': [ [ 'ale' ],
  \              [ 'lineinfo', 'percent' ],
  \              [ 'filetype', 'fileformat', 'fileencoding' ] ]
  \ },
  \ 'component': {
  \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
  \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
  \ },
  \ 'component_visible_condition': {
  \   'readonly': '(&filetype!="help"&& &readonly)',
  \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightLineFugitive',
  \   'filename': 'LightLineFilename',
  \   'fileencoding': 'LightLineFileencoding',
  \   'ale': 'ALEGetStatusLine',
  \ },
  \ 'component_type': {
  \   'syntastic': 'error',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '|', 'right': '|' },
  \ }

"let g:lightline_hybrid_style = 'plain'

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

" symbols for reference

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

"}}}

" ----------------------------------------------------------------------------
" Undotree
" ----------------------------------------------------------------------------
"{{{

let g:undotree_DiffCommand = "diff -u"
let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1

nmap <silent> <leader>u :UndotreeToggle<CR>

"}}}

" ----------------------------------------------------------------------------
" EasyMotion
" ----------------------------------------------------------------------------
"{{{

map <leader> <Plug>(easymotion-prefix)

"}}}

" ----------------------------------------------------------------------------
" deoplete
" ----------------------------------------------------------------------------
"{{{

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_yarp = 1
" let g:deoplete#disable_auto_complete = 1
let g:deoplete#enable_smart_case = 1

inoremap <expr><C-g> deoplete#undo_completion()
inoremap <expr><C-l> deoplete#complete_common_string()

" <TAB>: completion.
"inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#manual_complete()
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" <BS>: close popup and delete backword char.
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

" Movement within 'ins-completion-menu'
inoremap <expr><C-j> pumvisible() ? "\<Down>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<Up>" : "\<C-k>"

"}}}

" ----------------------------------------------------------------------------
" deoplete ternjs
" ----------------------------------------------------------------------------
"{{{

let g:deoplete#sources#ternjs#filetypes = [ 'jsx', 'javascript.jsx' ]

"}}}

" ----------------------------------------------------------------------------
" Commentary
" ----------------------------------------------------------------------------
"{{{

xmap cm <Plug>Commentary
nmap cm <Plug>Commentary
omap cm <Plug>Commentary

"}}}

" ----------------------------------------------------------------------------
" vim-lion
" ----------------------------------------------------------------------------
"{{{

let b:lion_squeeze_spaces = 1
let g:lion_map_right = '<leader>A'
let g:lion_map_left = '<leader>a'

"}}}

" ----------------------------------------------------------------------------
" fzf.vim
" ----------------------------------------------------------------------------
"{{{

set rtp+=/usr/local/opt/fzf

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"}}}

" ----------------------------------------------------------------------------
" misc functions
" ----------------------------------------------------------------------------
"{{{

" replace word under cursor; match whole word
nnoremap <leader>r yiw:%s/\<<C-r>0\>/

" replace (partial) word under cursor
nnoremap <leader>R yiw:%s/<C-r>0/

" replace selected text
vnoremap <leader>r y:%s/<C-r>0/

" call  formatters
nnoremap <silent> <leader>js :%!python -m json.tool<CR>
nnoremap <silent> <leader>xm :%!xmllint --format -<CR>
nnoremap <silent> <leader>pt :%!prettier --print-width 120 --single-quote --trailing-comma all<CR>

" from: http://vim.wikia.com/wiki/Making_a_list_of_numbers
" Add argument (can be negative, default 1) to global variable x.
" Return value of x before the change.
function Inc(...)
  let result = g:x
  let g:x += a:0 > 0 ? a:1 : 1
  return result
endfunction

"}}}
