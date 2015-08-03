" ----------------------------------------------------------------------------
" delimitMate
" ----------------------------------------------------------------------------
"{{{

"imap <C-i> <CR><Esc>O
imap <expr><CR> pumvisible() ? "\<C-n>" : "<plug>delimitMateCR"

"}}}

" ----------------------------------------------------------------------------
" NERDTree
" ----------------------------------------------------------------------------
"{{{

map <leader>n :NERDTreeToggle<CR>
imap <leader>n <Esc>:NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

" enable closing vim if NERDTree is the only open window
augroup AuNERDTreeCmd

" open NERDTree if no files are specified
"autocmd AuNERDTreeCmd VimEnter * if argc() == 0 | NERDTree | endif
autocmd AuNERDTreeCmd StdinReadPre * let s:std_in=1
autocmd AuNERDTreeCmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" quit if nerdtree is only open buffer
autocmd AuNERDTreeCmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let g:NERDTreeChDirMode = 2
let g:NERDTreeWinSize = 40

"}}}

" ----------------------------------------------------------------------------
" ctrlp
" ----------------------------------------------------------------------------
"{{{

let g:ctrlp_dont_split = 'netrw\|nerdtree'
let g:ctrlp_working_path_mode = 'rw'

"}}}

" ----------------------------------------------------------------------------
" zoomwin
" ----------------------------------------------------------------------------
"{{{

map <bs> :ZoomWin<CR>

"}}}

" ----------------------------------------------------------------------------
" syntastic
" ----------------------------------------------------------------------------
"{{{

nmap <silent> <F9> :SyntasticToggleMode<CR>

map <leader>sc :SyntasticCheck<CR>

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_php_checkers = ['phpcs']
let g:syntastic_php_phpcs_args = "--standard=/Users/***REMOVED***/.phpcs/phpcs.xml -n --report=csv"
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_auto_loc_list=0
"let g:syntastic_auto_loc_list=1

"}}}

" ----------------------------------------------------------------------------
" jshint
" ----------------------------------------------------------------------------
"{{{

" use node.js for javascript
let $JS_CMD='node'

let jshint2_command = '/usr/local/bin/jshint'
nnoremap <silent><leader>js :JSHint<CR>
inoremap <silent><leader>js <C-O>:JSHint<CR>
vnoremap <silent><leader>js :JSHint<CR>
cnoremap <leader>js JSHint

"}}}

" ----------------------------------------------------------------------------
" beautify
" ----------------------------------------------------------------------------
"{{{

map <silent><leader>jf :%!python -m json.tool<CR>
map <silent><leader>jb :call JsBeautify()<CR>

""}}}

" ----------------------------------------------------------------------------
" coffeescript
" ----------------------------------------------------------------------------
"{{{

au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

"}}}

" ----------------------------------------------------------------------------
" vim-fugitive
" ----------------------------------------------------------------------------
"{{{

nmap     <Leader>g  :Gstatus<CR>gg<c-n>
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
