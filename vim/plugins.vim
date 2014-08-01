"delimitMate {{{

"imap <C-i> <CR><Esc>O
imap <expr><CR> pumvisible() ? "\<C-n>" : "<plug>delimitMateCR"

"}}}

"buffergator {{{

let g:buffergator_viewport_split_policy = 'R'
let g:buffergator_split_size = '30'
let g:buffergator_display_regime = 'bufname'

"}}}

"NERDTree {{{

map <leader>n :NERDTreeToggle<CR>
imap <leader>n <Esc>:NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

" enable closing vim if NERDTree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" don't open NERDTree if files are specified
autocmd VimEnter * if argc() == 0 | NERDTree | endif

"}}}

"zoomwin {{{

map <leader>z :ZoomWin<CR>

"}}}

"goyo {{{

let g:goyo_width = 140
nnoremap <leader>g :Goyo<CR>

function! GoyoBefore()
  Limelight
endfunction

function! GoyoAfter()
  Limelight!
endfunction

let g:goyo_callbacks = [function('GoyoBefore'), function('GoyoAfter')]

"}}}

"syntastic {{{

map <leader>sc :SyntasticCheck<CR>

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_auto_loc_list=0
"let g:syntastic_auto_loc_list=1

"}}}

"jshint {{{

" use node.js for javascript
let $JS_CMD='node'

let jshint2_command = '/usr/local/bin/jshint'
nnoremap <silent><leader>js :JSHint<CR>
inoremap <silent><leader>js <C-O>:JSHint<CR>
vnoremap <silent><leader>js :JSHint<CR>
cnoremap <leader>js JSHint

"}}}

"js-beautify {{{

map <leader>jb :call JsBeautify()<CR>

""}}}

"lessc {{{

"nnoremap <leader>lc :w <BAR> silent !lessc % > %:r.css<CR>
nnoremap <silent> <leader>lc :silent !lessc % > %:r.css<CR>

"}}}

"coffeescript {{{

au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

"}}}

"fugitive {{{

nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>ga :Gadd<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gco :Gcheckout<CR>
nnoremap <leader>gci :Gcommit<CR>
nnoremap <leader>gm :Gmove<CR>
nnoremap <leader>gr :Gremove<CR>

"}}}

"gitgutter {{{

highlight clear SignColumn
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow

"}}}

"airline {{{

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

"indent guides {{{

let g:indentguides_state = 0
function! IndentGuides() " {{{
    if g:indentguides_state
        let g:indentguides_state = 0
        2match None
    else
        let g:indentguides_state = 1
        execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
    endif
endfunction " }}}
hi def IndentGuides guibg=#303030 ctermbg=234
nnoremap <leader>I :call IndentGuides()<CR>

"}}}

"highlight word {{{
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n) " {{{
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction " }}}

" Mappings
nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

"}}}
