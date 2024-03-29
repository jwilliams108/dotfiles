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
" vim-jsx
" ----------------------------------------------------------------------------
"{{{

let g:jsx_ext_required = 1

"}}}

" ----------------------------------------------------------------------------
" vim-vue
" ----------------------------------------------------------------------------
"{{{

let g:vue_pre_processors = []

"}}}

" ----------------------------------------------------------------------------
" ale
" ----------------------------------------------------------------------------
"{{{

" appearance
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_statusline_format = ['>> %d', '-- %d', '']

" linters
let g:ale_linters = {
\   'css': ['stylelint'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'perl': ['perlcritic'],
\   'php': ['phpcs'],
\}

let g:ale_linters_explicit = 1

let g:ale_php_phpcs_standard = 'PSR12'

" only lint on enter or file save
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 'never'

" disable LSP features
let g:ale_completion_enabled = 0

" fixers
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'php': ['php_cs_fixer'],
\}

" keymaps
nmap <silent> [r <Plug>(ale_previous_wrap)
nmap <silent> ]r <Plug>(ale_next_wrap)

nmap <silent> <leader>at :ALEToggle<CR>
nmap <silent> <leader>af :ALEFix<CR>

"}}}

" ----------------------------------------------------------------------------
" delimitMate
" ----------------------------------------------------------------------------
"{{{

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

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
" signify
" ----------------------------------------------------------------------------
"{{{

let g:signify_vcs_list = [ 'git' ]
let g:signify_update_on_focusgained = 1

nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

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
  \ 'subseparator': { 'left': '|', 'right': '|' },
  \ }

" 'separator': { 'left': '', 'right': '' },
"
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
" vim-asterisk
" ----------------------------------------------------------------------------
"{{{

map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)

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

set rtp+=/opt/local/share/fzf/vim

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


nnoremap <C-p> :Files<CR>
nnoremap <leader>ls :Buffers<CR>
nnoremap <leader>ll :Lines<CR>
nnoremap <leader>lg :GFiles<CR>
nnoremap <leader>lh :History<CR>
nnoremap <leader>lc :Commands<CR>
nnoremap <leader>lt :BTags<CR>

" Fuzzy search for Git commits. Requires tpope/vim-fugitive
"let g:fzf_commits_log_options = '--graph --color=always
"  \ --format="%C(yellow)%h%C(red)%d%C(reset)
"  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'

nnoremap <leader>gls :Commits<CR>
nnoremap <leader>glc :BCommits<CR>

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
nnoremap <silent> <leader>js :%!jq .<CR>
nnoremap <silent> <leader>jc :%!jq -c .<CR>
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
