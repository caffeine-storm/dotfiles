alias gs='git status -s'
alias gd='git diff -b'
alias gdc='git diff -b --cached'
alias gt='git show-tree'

alias nl='nl -w 1 -s" "'

function alias_last() {
	if [[ $# -eq 1 ]]; then
		local target="$1"
		local cmd_to_run=`history -p !!`
		alias $target="echo $cmd_to_run ; $cmd_to_run"
	else
		echo "usage: alias_last <new-alias-name>"
		return 1
	fi
}
