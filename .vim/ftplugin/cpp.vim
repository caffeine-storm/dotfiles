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
" make_shared is also quite common...
abbr sms std::make_shared
abbr sup std::unique_ptr

fu! CPPHTarget()
	" If we're a hpp, need to find a cpp and vice-versa
	let l:extension = expand('%:e') " l:extension should get either 'hpp' or 'cpp'

	let l:target_path = ""

	" Get the filename to ':splitfind' without any directory cruft. We use
	" :splitfind to support .hpp in an ext folder linking to a .cpp outside of
	" ext.
	if l:extension == "hpp"
		let l:target_path = expand('%:t:r').".cpp"
	elseif l:extension == "cpp"
		let l:target_path = expand('%:t:r').".hpp"
	else
		throw "Not a recognized file extension: '".l:extension."'"
	endif

	return l:target_path
endfunction

" Implementation for ctrl-w \ feature: "open the {hpp|cpp} file that goes with
" the one I'm editing"
fu! CPPHSplit()
	" Cleanup any rouge windows... they don't get removed if they have changes
	" though which is good.
	if winnr('$') != 1
		only
	endif

	let l:target_path = CPPHTarget()

	let l:extension = expand('%:e') " l:extension should get either 'hpp' or 'cpp'
	" split-find the target
	if l:extension == "hpp"
		" From a header, the .cpp will open above so we'll swap windows and
		" cycle-to-prev-window so that the .cpp will be below and selected.
		return "sfind ".l:target_path." | wincmd x | wincmd = | wincmd p"
	else
		return "sfind ".l:target_path." | wincmd ="
	endif
endfunction

fu! CPPHToggle()
	" Cleanup any rouge windows... they don't get removed if they have changes
	" though which is good.
	if winnr('$') != 1
		only
	endif

	let l:target_path = CPPHTarget()

	" split-find the target and make it the 'only' window in the tab-page.
	return "sfind ".l:target_path." | wincmd o"
endfunction

" 'ctrl-w \' h-splits to the .hpp or .cpp counterpart of the current file.
nnoremap <C-W>\ :exe CPPHSplit()<CR>

" 'ctrl-w |' replaces the current window with it's corresponding '.hpp' or
" '.cpp'... like 'ctrl-w \' followed by 'ctrl-o'.
nnoremap <C-W>\| :exe CPPHToggle()<CR>

nnoremap <Leader>head :.! ../codegen header ::%:t:r<C-Left>
nnoremap <Leader>impl :.! ../codegen impl ::%:t:r<C-Left>
nnoremap <Leader>inc :put! ='#include <'<CR> :starti!<CR>
" From inside a parenthesized expression, add a padding space between the
" parentheses and the expression.
nnoremap <Leader><Space> :norm! F(a <Esc>h%i <Esc>
nnoremap <Leader><BackSpace> :norm! F(lxh%hx

" Insert a separator and a blank line above the current line.
nnoremap <Leader>/ :put! ='/******************************************************************************/'<CR> :put =''<CR>j
nnoremap <Leader>? :put ='/******************************************************************************/'<CR>

