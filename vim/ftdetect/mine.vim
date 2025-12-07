" Makefiles Debian 9.9 (stretch) uses a heuristic that erroneously detects
" Makefile.lib as as COBOL.
au BufNewFile,BufRead
      \ [Mm]akefile
      \,Makefile.mk
      \,Makefile.lib
      \,GNUmakefile
      \ set filetype=make
