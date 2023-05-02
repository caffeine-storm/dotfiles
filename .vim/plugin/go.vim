set noexpandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

fu! SwapTarget()
	let l:current_file = expand("%")
	if l:current_file =~ "_test.go$"
		return substitute(l:current_file, "_test.go$", ".go", "")
	else
		return substitute(l:current_file, ".go$", "_test.go", "")
	endif
endfunction

fu! SwapImplTest()
	let l:target_path = SwapTarget()
	return "edit ".l:target_path
endfunction

" leader-t for swapping between test and impl files
nnoremap <Leader>t :exe SwapImplTest()<CR>
