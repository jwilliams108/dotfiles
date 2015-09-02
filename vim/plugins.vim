" ----------------------------------------------------------------------------
" netrw
" ----------------------------------------------------------------------------
"{{{

let g:netrw_altfile = 1

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
" airline
" ----------------------------------------------------------------------------
"{{{

"let g:airline_powerline_fonts = 1
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols = {}
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

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
