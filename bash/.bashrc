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

# Output shell errors in GNU error format.
#
# See: https://www.gnu.org/prep/standards/html_node/Errors.html for an
# explanation of all options.
shopt -s cdable_vars
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s direxpand
shopt -s dirspell
shopt -s dotglob
shopt -s extglob
shopt -s globstar
shopt -s gnu_errfmt
shopt -s histappend
shopt -s histreedit
shopt -s hostcomplete
shopt -s no_empty_cmd_completion
shopt -s nocaseglob
shopt -s progcomp
shopt -u sourcepath

# shellcheck disable=SC2155
export GPG_TTY="$(tty)"
# shellcheck disable=SC2155
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

if [[ "$UID" -ne 0 ]]; then
	PS1="\[\033[31m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\W\[\033[m\]\$ "
fi

if [ -f /etc/bash_completion ]; then
  # shellcheck disable=SC1091
	source /etc/bash_completion
fi
# source supplementary aliases definitions, functions and PATH
for file in ~/.{bash_aliases,functions,path,env,bash_prompt}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		source "$file"
	fi
done

unset -v file
