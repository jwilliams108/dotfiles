" ----------------------------------------------------------------------------
" javascript
" ----------------------------------------------------------------------------
"{{{

augroup ft_javascript
  au!

  au FileType javascript setlocal foldmethod=marker foldmarker={,}
  au FileType javascript setlocal omnifunc=tern#Complete
  au CompleteDone * pclose " close preview window after leaving autocomplete
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
" HTML
" ----------------------------------------------------------------------------
"{{{

augroup ft_html
  au!

  au FileType html setlocal omnifunc=htmlcomplete#CompleteTags
augroup END

"}}}

" ----------------------------------------------------------------------------
" CSS
" ----------------------------------------------------------------------------
"{{{

augroup ft_css
  au!

  au Filetype css setlocal foldmethod=marker foldmarker={,}
  au FileType css setlocal omnifunc=csscomplete#CompleteCSS
  au FileType css setlocal iskeyword+=-
augroup END

"}}}

" ----------------------------------------------------------------------------
" XML
" ----------------------------------------------------------------------------
"{{{

augroup ft_xml
  au!

  au FileType xml setlocal foldmethod=manual
  au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

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
  au FileType python setlocal omnifunc=pythoncomplete#Complete
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
