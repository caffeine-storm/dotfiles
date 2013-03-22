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

" Set the file search-path to include our source tree and system includes
set path=src/**,/usr/include/,,

" smarter indenting ftw
set cindent
set cino=l1g0(su1U1j1
set smartindent
set noexpandtab

" build tags of our cpp source with F-12
nnoremap <F12> :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q --exclude="output/*" --exclude="data/*" --exclude="test/*" --exclude="rootpath/*" --exclude="timing/*" --exclude="profiling/*" .<cr>
inoremap <F12> <Esc>:!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q --exclude="output/*" --exclude="data/*" --exclude="test/*" --exclude="rootpath/*" --exclude="timing/*" --exclude="profiling/*" .<cr>

" shared_ptr is quite common...
abbr ssp std::shared_ptr

" Implementation for ctrl-w \ feature
fu! CPPHSplit()
	" If we're a hpp, need to find a cpp and vice-versa
	let l:extension = expand('%:e') " l:extension should get either 'hpp' or 'cpp'

	" Cleanup any rouge windows... they don't get removed if they have changes
	" though which is good.
	if winnr('$') != 1
		only
	endif

	let l:foo = ""

	" Get the filename to ':splitfind' without any directory cruft. We use
	" :splitfind to support .hpp in an ext folder linking to a .cpp outside of
	" ext.
	if l:extension == "hpp"
		let l:foo = expand('%:t:r').".cpp"
	elseif l:extension == "cpp"
		let l:foo = expand('%:t:r').".hpp"
	else
		throw "Not a recognized file extension: '".l:extension."'"
	endif

	" split-find the target
	" exe "sfind ".l:foo

	if l:extension == "hpp"
		return "sfind ".l:foo." | wincmd x | wincmd = | wincmd p"
		" wincmd x
		" wincmd =
		" wincmd p
	else
		return "sfind ".l:foo." | wincmd ="
		" wincmd =
	endif

endfunction

" 'ctrl-w \' h-splits to the .hpp or .cpp counterpart of the current file.
nnoremap <C-W>\ :exe CPPHSplit()<CR>
nnoremap <Leader>head :.! ../codegen header ::%:t:r<C-Left>
nnoremap <Leader>impl :.! ../codegen impl ::%:t:r<C-Left>
nnoremap <Leader>inc :put! ='#include <'<CR> :starti!<CR>
nnoremap <Leader><Space> :norm! F(a <Esc>h%i <Esc>
nnoremap <Leader>/ :put! ='/******************************************************************************/'<CR>

