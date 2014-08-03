"Javascript {{{

augroup ft_javascript
  au!

  au FileType javascript setlocal foldmethod=marker
  au FileType javascript setlocal foldmarker={,}

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " Prettify a hunk of JSON with <leader>p
  au FileType javascript nnoremap <buffer> <leader>p ^vg_:!python -m json.tool<cr>
  au FileType javascript vnoremap <buffer> <leader>p :!python -m json.tool<cr>
augroup END

"}}}

"Coffeescript {{{

augroup ft_coffeescript
  au!

  au FileType coffee setlocal foldmethod=marker
  au FileType coffee setlocal foldmarker={,}

  " Treat litcoffee as coffeescript
  au BufNewFile,BufRead *.litcoffee set ft=coffee
augroup END

"}}}

"CSS, Less and Sass {{{

augroup ft_css
  au!

  au BufNewFile,BufRead *.less setlocal filetype=less
  "au BufWritePost,FileWritePost *.less silent !lessc <afile> <afile>:r.css

  au Filetype less,css setlocal foldmethod=marker
  au Filetype less,css setlocal foldmarker={,}
  au Filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
  au Filetype less,css setlocal iskeyword+=-

  " Use <leader>S to sort properties.  Turns this:
  "
  "     p {
  "         width: 200px;
  "         height: 100px;
  "         background: red;
  "
  "         ...
  "     }
  "
  " into this:

  "     p {
  "         background: red;
  "         height: 100px;
  "         width: 200px;
  "
  "         ...
  "     }
  au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

  " Make {<CR> insert a pair of brackets in such a way that the cursor is correctly
  " positioned inside of them AND the following code doesn't get unfolded.
  au BufNewFile,BufRead *.less,*.css inoremap <buffer> {<CR> {}<left><CR><space><space><space><space>.<CR><Esc>kA<bs>
augroup END

"}}}

"XML {{{

augroup ft_xml
  au!

  au FileType xml setlocal foldmethod=manual

  " Use <localleader>f to fold the current tag.
  au FileType xml nnoremap <buffer> <localleader>f Vatzf

  " Indent tag
  au FileType xml nnoremap <buffer> <localleader>= Vat=
augroup END

"}}}

"VIM config files {{{

augroup ft_vim
  au!

  au FileType vim setlocal foldmethod=marker
  au FileType help setlocal textwidth=78
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

"}}}

"Python {{{

augroup ft_python
  au!

  " make Python follow PEP8 for whitespace (http://www.python.org/dev/peps/pep-0008/ )
  au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4
augroup END

"}}}

"PHP {{{

augroup ft_php
  au!

  "au Filetype php,inc setlocal foldmethod=syntax
  au Filetype php,inc setlocal foldmethod=marker
  au Filetype php,inc setlocal foldmarker={,}
augroup END

"}}}
