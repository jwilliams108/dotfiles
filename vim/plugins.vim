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

hi link deniteMatchedChar Special

nnoremap <C-p> :<C-u>Denite file_rec<CR>
nnoremap <leader>ls :<C-u>Denite buffer<CR>
nnoremap <leader>ll :<C-u>Denite line<CR>

"}}}

" ----------------------------------------------------------------------------
" denite extras, git, etc.
" ----------------------------------------------------------------------------
"{{{

nnoremap <leader>hs :<C-u>Denite history:search -mode=normal<CR>
nnoremap <leader>hc :<C-u>Denite history:cmd -mode=normal<CR>
nnoremap <leader>gl :<C-u>Denite gitlog<CR>

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

"fixers
let g:ale_fixers = { 'javascript': ['prettier'] }
let g:ale_javascript_prettier_options = '--print-width 120 --single-quote --trailing-comma es5'

nmap <silent> [r <Plug>(ale_previous_wrap)
nmap <silent> ]r <Plug>(ale_next_wrap)

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

nmap <leader>gd  :Gvdiff<CR>
nmap <leader>gs  :Gstatus<CR>
nmap <leader>gw  :Gwrite<CR>
nmap <leader>ga  :Gadd<CR>
nmap <leader>gb  :Gblame<CR>
nmap <leader>gco :Gcheckout<CR>
nmap <leader>gci :Gcommit<CR>
nmap <leader>gm  :Gmove<CR>
nmap <leader>gr  :Gremove<CR>

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
  \   'ctrlpmark': 'CtrlPMark',
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

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
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
" CamelCaseMotion
" ----------------------------------------------------------------------------
"{{{

call camelcasemotion#CreateMotionMappings('<leader>')

"}}}

" ----------------------------------------------------------------------------
" FZF
" ----------------------------------------------------------------------------
"{{{

set rtp+=~/.fzf

"}}}

" ----------------------------------------------------------------------------
" neocomplete
" ----------------------------------------------------------------------------
"{{{

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#auto_completion_start_length = 2

inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" <BS>: close popup and delete backword char.
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

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
" misc functions
" ----------------------------------------------------------------------------
"{{{

" replace word under cursor; match only whole word
nnoremap <leader>r yiw:%s/\<<C-r>0\>/

" replace word under cursor
nnoremap <leader>R yiw:%s/<C-r>0/

" replace selected text
vnoremap <leader>r y:%s/<C-r>0/

" from: http://vim.wikia.com/wiki/Making_a_list_of_numbers
" Add argument (can be negative, default 1) to global variable x.
" Return value of x before the change.
function Inc(...)
  let result = g:x
  let g:x += a:0 > 0 ? a:1 : 1
  return result
endfunction

"}}}
