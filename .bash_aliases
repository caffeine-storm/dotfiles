
# git shorthands
alias gs='git status -s'
alias gd='git diff -b'
alias gdc='git diff -b --cached'
alias gt='git show-tree'

alias nl='nl -w 1 -s" "'

# to make running a common command, over and over, you can run it once, then
# run 'alias_last <id>' to make `id` run it next time.
function alias_last() {
	if [[ $# -eq 1 ]]; then
		local target="$1"
		local cmd_to_run="`history -p !!`"
		alias $target="echo \"$cmd_to_run\" ; $cmd_to_run"
	else
		echo "usage: alias_last <new-alias-name>"
		return 1
	fi
}

if havebin mpc; then
	# 'mpcplaylist' prints a numbered list of songs that the mpd has queued
	alias mpcplaylist='mpc playlist | nl | cut -c 1-80'
	# 'mpctoggle' is for using start/stop instead of pause
	alias mpctoggle='if [[ "$(mpc current)"x == x ]]; then mpc play ; else mpc stop ; fi'
fi

alias 'cd..'='cd ..'

# If we've got rlwrap, make ispell nicer to use
if havebin ispell && havebin rlwrap ; then
	alias 'ispell'='rlwrap ispell'
fi

# enable colour support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -A'
#alias l='ls -CF'
