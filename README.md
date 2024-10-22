dotfiles
========

Per-user linux config files for the applications I use/need.

It's called dotfiles because (almost) all of the config files are expected to
be placed in ~/.<file> . They maintain the leading dot in the git repo so that,
if one is so inclined, a simple 'for i in ~/dotfiles/.[^.]\*; do ln -sf $i .;
done' from your home directory ought to have any edits apply automagically
after a pull while keeping the rest of your home directory from living inside a
git repo.

notes
=====

Install vundle with `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
Open vim, run `:PluginInstall`
-> can fail b/c YCM not compiled
	- need ubuntu packages 'python3-dev cmake'
	- cd ~/.vim/bundle/YouCompleteMe
	-	./install.py [--all | --foo-completer [ --bar-completer ... ]]
		- ./install.py --clang-completer --go-completer
