if filereadable('/proc/cpuinfo')
	let s:numcores = system('grep -c ^processor /proc/cpuinfo')+1
else
	let s:numcores = 1
endif

let &makeprg = 'scons debug -j'.s:numcores

" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
" set tags+=~/.vim/tags/gl
" set tags+=~/.vim/tags/sdl
" set tags+=~/.vim/tags/qt4

set path=src/**,/usr/include/,,

set cindent
set cino=l1g0(su1U1j1
set noexpandtab

" build tags of cpp source
nnoremap <F12> :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q  --exclude="output/*" --exclude="data/*" --exclude="test/*" --exclude="rootpath/*" --exclude="timing/*" --exclude="profiling/*" .<cr>
inoremap <F12> <Esc>:!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q --exclude="output/*" --exclude="data/*" --exclude="test/*" --exclude="rootpath/*" --exclude="timing/*" --exclude="profiling/*" .<cr>

" shared_ptr is quite common...
abbr ssp std::shared_ptr

" 'ctrl-w \' h-splits to the .hpp or .cpp file corresponding to the currently
" open file. Broken right now :(
" nnoremap <C-W>\ :

