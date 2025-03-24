#!/bin/bash
#
# use this file as a way to temporarily append snippets to your $HOME/.bashrc.
#
# usage: extra-bashrc.sh [extra-script ...]

exec bash --rcfile <(cat "$HOME/.bashrc" $@)
