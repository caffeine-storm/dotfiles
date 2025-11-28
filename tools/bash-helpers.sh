# helper functions to make bash'ing nicer

function findn() {
	find . -name "*$1*"
}

function findin() {
	find . -iname "*$1*"
}

function finddn() {
	find $1 -name "*$2*"
}

function finddin() {
	find $1 -iname "*$2*"
}
