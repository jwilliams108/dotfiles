" ----------------------------------------------------------------------------
" netrw
" ----------------------------------------------------------------------------
"{{{

let g:netrw_altfile = 1
let g:netrw_dirhistmax = 0

"}}}

" ----------------------------------------------------------------------------
" Ag
" ----------------------------------------------------------------------------
"{{{

nnoremap \ :Ag!<SPACE>

"}}}

" ----------------------------------------------------------------------------
" ctrlp
" ----------------------------------------------------------------------------
"{{{

if executable('ag')
  " prefer silver searcher
  let g:ctrlp_use_caching = 0
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

let g:ctrlp_dont_split = 'netrw\|nerdtree'
let g:ctrlp_working_path_mode = 'rw'

nnoremap <leader>ls :CtrlPBuffer<CR>

"}}}

" ----------------------------------------------------------------------------
" buffergator
" ----------------------------------------------------------------------------
"{{{

let g:buffergator_viewport_split_policy = 'B'
let g:buffergator_autoexpand_on_split = 0
let g:buffergator_hsplit_size = 10

"}}}

" ----------------------------------------------------------------------------
" Autoformat
" ----------------------------------------------------------------------------
"{{{

nnoremap <silent><leader>fm :Autoformat<CR>

""}}}

" ----------------------------------------------------------------------------
" syntastic
" ----------------------------------------------------------------------------
"{{{

let g:syntastic_mode_map = {'mode':'passive','active_filetypes':[],'passive_filetypes':[]}
let g:syntastic_auto_loc_list = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_php_checkers = ['phpcs']
let g:syntastic_php_phpcs_args = "--standard=/Users/***REMOVED***/.phpcs/phpcs.xml -n --report=csv"
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

nnoremap <silent> <F9> :SyntasticToggleMode<CR>
nnoremap <leader>sc :SyntasticCheck<CR>
nnoremap <leader>sn :lnext<CR>
nnoremap <leader>sp :lprev<CR>

"}}}

" ----------------------------------------------------------------------------
" delimitMate
" ----------------------------------------------------------------------------
"{{{

"imap <C-i> <CR><Esc>O
imap <expr><CR> pumvisible() ? "\<C-n>" : "<plug>delimitMateCR"

"}}}
" ----------------------------------------------------------------------------
" vim-fugitive
" ----------------------------------------------------------------------------
"{{{

nnoremap <Leader>g  :Gstatus<CR>gg<c-n>
nnoremap <Leader>d  :Gvdiff<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>ga :Gadd<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gco :Gcheckout<CR>
nnoremap <leader>gci :Gcommit<CR>
nnoremap <leader>gm :Gmove<CR>
nnoremap <leader>gr :Gremove<CR>

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
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode' ],
  \             [ 'fugitive', 'filename' ],
  \             [ 'ctrlpmark' ] ],
  \   'right': [ [ 'syntastic' ],
  \              [ 'lineinfo', 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
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
  \ },
  \ 'component_expand': {
  \   'syntastic': 'SyntasticStatuslineFlag',
  \ },
  \ 'component_type': {
  \   'syntastic': 'error',
  \ },
  \ 'separator': { 'left': '⮀', 'right': '⮂' },
  \ 'subseparator': { 'left': '|', 'right': '|' },
  \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? '⭤' : ''
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
    return strlen(_) ? '⭠ '._ : ''
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

"}}}

" ----------------------------------------------------------------------------
" indentguides
" ----------------------------------------------------------------------------
"{{{

let g:indentguides_state = 0
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

"}}}

" ----------------------------------------------------------------------------
" EasyMotion
" ----------------------------------------------------------------------------
"{{{

map <Leader> <Plug>(easymotion-prefix)

map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)

"}}}

" ----------------------------------------------------------------------------
" FZF
" ----------------------------------------------------------------------------
"{{{

set rtp+=~/.fzf

"}}}
