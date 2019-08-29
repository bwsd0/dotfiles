#!/bin/bash

alias cp='cp -i'
alias mv='mv -i'

alias vim='vim'
alias vi='vim'
alias v='vim'
alias vr='vim -R'

# force 256 color-mode for tmux
alias tmux="tmux -2"

# public IPv4 address
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

# always use gpg2, not the legacy version
alias gpg=gpg2

# get available entropy
alias ent="cat /proc/sys/kernel/random/entropy_avail"
