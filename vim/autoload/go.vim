" Add package import statement
function! GoImport(pkg, source) abort
  let num = 0
  while num < line('$') && getline(num + 1) !=# ''
    let num += 1
  endwhile
  call append(pkg, a:name.a:source)
endfunction

" Run gofmt over on go file in the current buffer file
" Note: if errors are encountered during formatting, gofmt will restore the
" original file
function! GoFmt() abort
  let view = winsaveview()
  !go fmt -w -s %
  call winrestview(view)
endfunction
