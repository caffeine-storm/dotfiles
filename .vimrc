set nocompatible

set mouse=a

set tabstop=4
set softtabstop=4
set shiftwidth=4
set ic

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

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
set ofu=syntaxcomplete#Complete

