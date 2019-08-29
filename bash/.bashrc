# ~/.bashrc: executed by bash(1) for non-login shells.
# This file is sourced by all interactive bash shells on startup

# Test for interactive shell; if shell is non-interactive do nothing
case $- in
    *i*) ;;
      *) return;;
esac

# disable write(1), talk(1) to terminal
mesg n

# unset -f command_not_found_handle

# number of commands to remember in command history (2^12 = 4096)
HISTSIZE=$((1 << 12))

# maximum number of lines contained in history file (2^24 = ~16 million)
HISTFILESIZE=$((1 << 24))

# ignore duplicate commands and whitespace in history
HISTCONTROL=ignoredups

HISTIGNORE="&:bg:fg:ls:history:cd -:pwd:exit:date:* --help:* -h:* -v:make*"

# include timestamps of commands in history
HISTTIMEFORMAT='%F %T  '

# append to the history file, don't overwrite it
shopt -s histappend

# on history expansion failure retry the command
shopt -s histreedit

# check the window size after invoking commands and update the values of
# LINES,COLUNS
shopt -s checkwinsize

# use single history entry for multi-line commands
shopt -s cmdhist

# enable extended globbing: !(foo), ?(bar|baz)...
shopt -s extglob

if ((BASH_VERSINFO[0] >= 4)) ; then
	# tolerate minor directory name errors during completion
	shopt -s dirspell
    # If set, the pattern "**" used in a pathname expansion context will match
    # all files and zero or more directories and subdirectories
	shopt -s globstar
fi

# correct spelling errors in `cd` directory component
shopt -s cdspell

# include dotfiles in pattern matching
shopt -s dotglob

# use case-insensitive filename matching when performing pathname expansion
shopt -s nocaseglob

# do not offer completions for empty input on tab-press
shopt -s no_empty_cmd_completion

# use programmable completion if available
shopt -s progcomp

# exclude search of $PATH for locating files with `source` builtin
shopt -u sourcepath

# hostname completion
shopt -s hostcomplete

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && export LESSOPEN="|lesspipe %s"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" \
        || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

GPG_TTY=$(tty)
export GPG_TTY

gpg-connect-agent /bye
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
alias ssh="gpg-connect-agent updatestartuptty /bye >/dev/null"

if [[ "$UID" -ne 0 ]]; then
	PS1="\[\033[31m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\W\[\033[m\]\$ "
fi

# source supplementary aliases definitions, functions and PATH
for file in ~/.{bash_aliases,functions,path,env,bash_prompt}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		source "$file"
	fi
done
unset -v file
