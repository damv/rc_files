# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color | screen | tmux) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

# Add git branch if its present to PS1
parse_git_branch() {
	git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Add red X if last command exit with rc != 0
rc_check() {
	local rc=$?
	if [ ! ${rc} -eq 0 ]; then
		echo -e "\e[2mrc=${rc}\n\e[0m"
	fi
}

if [ "$color_prompt" = yes ]; then
	PS1='$(rc_check)${debian_chroot:+($debian_chroot)}\[\033[01;93m\]\u@\h\[\033[00m\] \[\033[01;33m\]$([ \j -gt 0 ] && echo "[\j] ")\[\033[00m\]\[\033[01;34m\]\w\[\033[01;35m\]$(parse_git_branch)\[\033[00m\]\n$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h \w\$(parse_git_branch) \$  '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*) ;;

esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias mygrep='grep -nrI --color=auto --exclude-dir={objs,.svn,.git} --exclude={*.map,*.swp,tags}'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:~/bin:/snap/bin:/usr/games/:/home/dvi/.local/bin:~/Applications:~/go/bin:~/scripts

# add ccache
export PATH="/usr/lib/ccache:${PATH}"

alias gits='gits -n -p 8'

export EDITOR=vim
set -o vi

PROMPT_COMMAND='echo -ne "\033]0; ${PWD##*/}\007"'

#PROMPT_DIRTRIM=2

alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

# cd shortuts
shopt -s cdable_vars
a=~/repos/argos
ca=~/repos/copy-argos

alias vim="vim -X"
alias t='date +%R'
alias g='git'

HISTCONTROL=ignoreboth

# Make exit detach tmux sessions instead of killing them
exit() {
	if [[ -z $TMUX ]]; then
		builtin exit
	else
		tmux detach
	fi
}

# Alias to use dedicated graphic card
alias 'nv'='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'

# Ask argos to use dedicated graphic card
export ARGOS_ENV_DEF="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"

# Intel Graphic Card driver
export MESA_LOADER_DRIVER_OVERRIDE=i965

alias sshwk='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa_factory -i ~/.ssh/id_rsa_customer'
alias scpwk='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa_factory -i ~/.ssh/id_rsa_customer'

source /opt/intel/openvino_2021/bin/setupvars.sh
source /opt/intel/vtune_profiler_2020.2.0.610396/vtune-vars.sh
source /usr/share/autojump/autojump.sh

function f () {
	TF_PYTHONIOENCODING=$PYTHONIOENCODING;
	export TF_SHELL=bash;
	export TF_ALIAS=fuck;
	export TF_SHELL_ALIASES=$(alias);
	export TF_HISTORY=$(fc -ln -10);
	export PYTHONIOENCODING=utf-8;
	TF_CMD=$(
	thefuck THEFUCK_ARGUMENT_PLACEHOLDER "$@"
	) && eval "$TF_CMD";
	unset TF_HISTORY;
	export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
	history -s $TF_CMD;
}
export THEFUCK_REQUIRE_CONFIRMATION='false'
