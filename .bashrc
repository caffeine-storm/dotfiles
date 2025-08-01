# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-colour, unless we know we "want" colour)
case "$TERM" in
    xterm-color | screen-bce | alacritty) color_prompt=yes;;
esac

# GPG_TTY is important according to gpg-agent(1)
export GPG_TTY=$(tty)

# uncomment for a coloured prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have colour support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;31m\]\u@\h\[\033[01;34m\]\w \[\033[00m\]'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
screen*|xterm*|rxvt*)
    PS1="\[\033[01;31m\]\u@\h\[\033[01;34m\]\w \[\033[00m\]"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias 'cd..'='cd ..'

# If we've got rlwrap, make ispell nicer to use
if [ -x "`which ispell 2>/dev/null`" ] && [ -x "`which rlwrap 2>/dev/null`" ]; then
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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export PATH

# Thanks S.O.! https://superuser.com/a/39995/300939
pathadd() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="${PATH:+"$PATH:"}$1"
	fi
}
pathprepend() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="$1${PATH:+":$PATH"}"
	fi
}

# If ccache is installed, put first on PATH to intercept calls
pathprepend /usr/lib/ccache
pathprepend /usr/lib/ccache/bin

# If a local golang is installed, add to PATH
pathadd /usr/local/go/bin

# Add user-specific go binaries to PATH
pathadd "$HOME/go/bin"

# Add home-folder binaries to PATH
pathadd "$HOME/bin"
pathadd "$HOME/tools/bin"
pathadd "$HOME/.local/bin"

# If screen is installed but /run/screen is missing or not useable, fall back
# to SCREENDIR=~/.screen
if [ -x "`which screen 2>/dev/null`" ]; then
	if [ ! -d /run/screen ] || [ ! -w /run/screen ]; then
		mkdir -p ~/.screen
		export SCREENDIR=~/.screen
	fi
fi

# Set up EDITOR so that command-line stuff doesn't freak out when looking
export EDITOR=/usr/bin/vim

# Have python interpreters source my .pythonrc
export PYTHONSTARTUP=~/.pythonrc

# bash-completion for git... tasty!
completions=/usr/share/bash-completion/completions/git
if [ -e "$completions" ]; then
	source "$completions"
fi

# Go away capslock!
if [ -n "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && [ -x "`which setxkbmap 2>/dev/null`" ]; then
	setxkbmap -option ctrl:nocaps
fi

# 'mpcplaylist' prints a numbered list of songs that the mpd has queued
alias mpcplaylist='mpc playlist | nl | cut -c 1-80'
alias mpctoggle='if [[ "$(mpc current)"x == x ]]; then mpc play ; else mpc stop ; fi'

# add pyenv and pyenv-virtualenv
if [ -d "$HOME/.pyenv" ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	command -v pyenv >/dev/null || PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

# add nvm -- node version manager
if [ -f "/usr/share/nvm/init-nvm.sh" ]; then
	source /usr/share/nvm/init-nvm.sh
fi

# Source completions scripts under dotfiles/completions.d/*bash
DOTFILES_DIR="$HOME/dotfiles"
for fname in `ls $DOTFILES_DIR/completions.d/*bash` ; do
	source $fname
done

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/tmckee/.juliaup/bin:*)
        ;;

    *)
        PATH=/home/tmckee/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<

# If there's a $HOME/.local.bashrc, source it now
if [ -f $HOME/.local.bashrc ]; then
	. $HOME/.local.bashrc
fi
