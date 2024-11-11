set nocompatible              " be iMproved, required
filetype off                  " required

" Note: need to
"   `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle`
" to get an intial copy of Vundle.
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'ycm-core/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set mouse=a

" 2-space tabs plz
set tabstop=2
set softtabstop=2
set shiftwidth=2
" don't choose (no)expandtab here, let ftplugins do it
" set expandtab

" Nicer pattern matching
set ignorecase
set smartcase
set incsearch

" Don't leave buffers unshown while modified
set nohidden

set showmatch
set ruler

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

" <F1> opening help is usually just a fat-finger; disable it.
" :help will still work.
map <F1> <Esc>
imap <F1> <Esc>

" tab-complete things more like bash
set wildmode=longest:list

" toggle hlsearch with leader-hl
nnoremap <Leader>hl :set hlsearch!<CR>
set nohlsearch

" toggle 'list' with leader-l
nnoremap <Leader>l :set list!<CR>

" toggle 'paste' with leader-p
nnoremap <Leader>p :set paste!<CR>

" leader-d for go to definition
nnoremap <Leader>d :YcmCompleter GoToDefinition<CR>
" leader-D for 'get docs'
nnoremap <Leader>D :YcmCompleter GetDoc<CR>
" leader-r for go to references
nnoremap <Leader>r :YcmCompleter GoToReferences<CR>
" leader-h for go to header/implfile
nnoremap <Leader>h :YcmCompleter GoToAlternateFile<CR>
" leader-F for go to FixIt
nnoremap <Leader>F :YcmCompleter FixIt<CR>
" leader-R for RefactorRename
nnoremap <Leader>R :YcmCompleter RefactorRename 
