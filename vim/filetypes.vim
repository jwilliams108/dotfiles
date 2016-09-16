" ----------------------------------------------------------------------------
" javascript
" ----------------------------------------------------------------------------
"{{{

augroup ft_javascript
  au!

  au FileType javascript setlocal foldmethod=marker foldmarker={,}
  au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
augroup END

"}}}

" ----------------------------------------------------------------------------
" JSON
" ----------------------------------------------------------------------------
"{{{

augroup ft_json
  au!

  au FileType json setlocal foldmethod=syntax
  au BufNewFile,BufRead *.json set ft=json
augroup END

"}}}

" ----------------------------------------------------------------------------
" CSS
" ----------------------------------------------------------------------------
"{{{

augroup ft_css
  au!

  au Filetype css setlocal foldmethod=marker
  au Filetype css setlocal foldmarker={,}
  au FileType css setlocal omnifunc=csscomplete#CompleteCSS
  au FileType css setlocal iskeyword+=-

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
  au BufNewFile,BufRead *.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

  " Make {<CR> insert a pair of brackets in such a way that the cursor is correctly
  " positioned inside of them AND the following code doesn't get unfolded.
  au BufNewFile,BufRead *.css inoremap <buffer> {<CR> {}<left><CR><space><space><space><space>.<CR><Esc>kA<bs>
augroup END

"}}}

" ----------------------------------------------------------------------------
" XML
" ----------------------------------------------------------------------------
"{{{

augroup ft_xml
  au!

  au FileType xml setlocal foldmethod=manual

  " Use <localleader>f to fold the current tag.
  au FileType xml nnoremap <buffer> <localleader>f Vatzf

  " Indent tag
  au FileType xml nnoremap <buffer> <localleader>= Vat=
augroup END

"}}}

" ----------------------------------------------------------------------------
" Vim
" ----------------------------------------------------------------------------
"{{{

augroup ft_vim
  au!

  au FileType vim setlocal foldmethod=marker
  au FileType help setlocal textwidth=78
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

"}}}

" ----------------------------------------------------------------------------
" Python
" ----------------------------------------------------------------------------
"{{{

augroup ft_python
  au!

  " make Python follow PEP8 for whitespace (http://www.python.org/dev/peps/pep-0008/ )
  au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4
augroup END

"}}}

" ----------------------------------------------------------------------------
" PHP
" ----------------------------------------------------------------------------
"{{{

augroup ft_php
  au!

  "au Filetype php,inc setlocal foldmethod=syntax
  au Filetype php,inc setlocal foldmethod=marker foldmarker={,}
augroup END

"}}}

" ----------------------------------------------------------------------------
" Java
" ----------------------------------------------------------------------------
"{{{

augroup ft_java
  au!

  au FileType java,groovy setlocal foldmethod=marker foldmarker={,}
augroup END

"}}}
