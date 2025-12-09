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

# number of commands to remember in command history
HISTSIZE=8192 #$((1 << 13))

# maximum number of lines contained in history file
HISTFILESIZE=$((1 << 18))

# ignore duplicate commands and whitespace in history
HISTCONTROL=ignoredups

#HISTIGNORE="&:bg:fg:ls:history:cd -:pwd:exit:date:* --help:*"

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

# GPG agent for SSH authentication
export GPG_TTY="$(tty)"
if command -v gpgconf >/dev/null 2>&1; then
	_ssh_sock="$(gpgconf --list-dirs agent-ssh-socket)"
	if [[ -S "$_ssh_sock" ]]; then
		export SSH_AUTH_SOCK="$_ssh_sock"
	fi
	unset _ssh_sock
	gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
fi

if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi
if command -v terraform >/dev/null 2>&1; then
	complete -C /usr/bin/terraform terraform
fi
# source supplementary aliases definitions, functions and PATH
for file in ~/.{bash_aliases,functions,path,env,bash_prompt}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		source "$file"
	fi
done

unset -v file
