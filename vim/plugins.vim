" pathogen
call pathogen#infect()
call pathogen#helptags()

"imap <C-i> <CR><Esc>O
imap <expr><CR> pumvisible() ? "\<c-n>" : "<plug>delimitMateCR"

" shortcuts
" buffer management
set wildchar=<Tab> wildmenu wildmode=full
set autoread
let g:buffergator_viewport_split_policy = 'R'
let g:buffergator_split_size = '30'
let g:buffergator_display_regime = 'bufname'

" list buffers
nnoremap <leader>l :buffers<CR>:b<Space>

" list buffers then wait for input to switch
nnoremap <leader>ls :ls<CR>:b<Space>

" NERDTree
" enable closing vim if nerdTree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" don't open NERDTree is files are specified
autocmd VimEnter * if argc() == 0 | NERDTree | endif

map <Leader>f :NERDTreeFind<CR>

" enable zoomwin
map <leader>z :ZoomWin<CR>

" goyo
let g:goyo_width = 140
nnoremap <leader>g :Goyo<CR>

function! GoyoBefore()
  Limelight
endfunction

function! GoyoAfter()
  Limelight!
endfunction

let g:goyo_callbacks = [function('GoyoBefore'), function('GoyoAfter')]
" use node.js for javascript
let $JS_CMD='node'

" syntastic fixes
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_auto_loc_list=0
"let g:syntastic_auto_loc_list=1
map <leader>sc :SyntasticCheck<CR>

" use jshint for syntax checking
"let g:syntastic_javascript_checker="jshint"

" jshint config
let jshint2_command = '/usr/local/bin/jshint'
nnoremap <silent><leader>js :JSHint<CR>
inoremap <silent><leader>js <C-O>:JSHint<CR>
vnoremap <silent><leader>js :JSHint<CR>
cnoremap <leader>js JSHint

" js-beautify
map <leader>jb :call JsBeautify()<CR>

" lessc additions
au BufNewFile,BufRead *.less set filetype=less
"au BufWritePost,FileWritePost *.less silent !lessc <afile> <afile>:r.css
"nnoremap <leader>lc :w <BAR> silent !lessc % > %:r.css<CR>
nnoremap <silent> <leader>lc :silent !lessc % > %:r.css<CR>

" coffeescript additions
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" fixes for gitgutter
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow

" for airline
"let g:airline_powerline_fonts = 1
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols = {}
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'
