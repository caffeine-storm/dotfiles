set nocompatible

set mouse=a

set tabstop=4
set softtabstop=4
set shiftwidth=4
set ic
set smartcase

set showmatch
set ruler
set incsearch

if has("syntax")
	set t_Co=256
	syntax on
	colorscheme wombat256
endif

" Make ':W' write the file too
command W w

set background=dark
set laststatus=2
set statusline=%f\ %m%r%h%w\ [%03.3b,%02.2B]\ %=%(%l,%v\ [%p%%]%)
set scrolloff=4
set showcmd

" Tweak the characters used when you 'set list' to see whitespace chars
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

filetype plugin on
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_enable_signs = 0

" Is there a file with compiler flags to use?
if filereadable(".syntastic_cpp_flags")
	let g:syntastic_cpp_compiler_options = readfile(".syntastic_cpp_flags")[0]
else
	" Use a default that usually makes sense
	let g:syntastic_cpp_compiler_options = '-std=c++0x -Wall -Wextra -Woverloaded-virtual -Isrc -Isrc/ext'
endif

if filereadable(".syntastic_c_flags")
	let g:syntastic_c_compiler_options = readfile(".syntastic_c_flags")[0]
else
	" Use a default that usually makes sense
	let g:syntastic_c_compiler_options = '-std=c11 -Wall -Wextra -Isrc -Isrc/ext'
endif

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
set ofu=syntaxcomplete#Complete

" tab-complete things more like bash
set wildmode=longest:list

" toggle hlsearch with leader-hl
nnoremap <Leader>hl :set hlsearch!<CR>

" toggle 'list' with leader-l
nnoremap <Leader>l :set list!<CR>

" toggle 'paste' with leader-p
nnoremap <Leader>p :set paste!<CR>
