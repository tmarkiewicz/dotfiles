# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

PS1='\[\033[0;36m\]\u@\h\[\033[0;33m\] \w\[\033[00m\]: '

alias free="free -m"
alias l="ls -l"
alias cd..="cd .."
alias c="clear"
alias df="df -h"

alias update="sudo aptitude update"
alias install="sudo aptitude install"
alias upgrade="sudo aptitude safe-upgrade"
alias remove="sudo aptitude remove"

alias ebash="nano ~/.bashrc"
alias bash_reload="source ~/.bashrc"
alias reload_bash="source ~/.bashrc"
alias pms="sudo passenger-memory-stats"
alias pss="sudo passenger-status"
alias view_logs="sudo nano /var/log/syslog"

# Apache
alias reload_apache="sudo /etc/init.d/apache2 reload"
alias restart_apache="sudo /etc/init.d/apache2 restart"
# asks apache to restart, but to do it in a way that won't interfere with existing connections
alias restart_apache_graceful="sudo /usr/sbin/apache2ctl graceful"
alias edit_apache="sudo nano /etc/apache2/apache2.conf"
alias configtest="sudo /usr/sbin/apache2ctl configtest"
alias apache_error_log="sudo nano /var/log/apache2/error.log"

# Nginx
alias edit_nginx="sudo nano /etc/nginx/nginx.conf"
alias restart_nginx="sudo service nginx restart"

# Monit
alias edit_monit="sudo nano /etc/monit/monitrc"

# Delayed Job
alias start_delayed_job="RAILS_ENV=production bin/delayed_job -n 5 start"
alias stop_delayed_job="RAILS_ENV=production bin/delayed_job stop"

alias restart_investify="touch /home/deploy/apps/investify/current/tmp/restart.txt"

alias rwi="cd /home/deploy/apps/investify/current"

alias tail_log="cd /home/deploy/apps/investify/current/log && tail -f production.log"

alias rc="rails console -e production"

alias pbcopy='xsel --clipboard'
alias pbpaste='xsel --clipboard'

# Git aliases
alias gs='git status'
alias gl='git log'
alias gp='git push'
alias ga='git add .'
alias gb='git branch'
alias gc='git commit'
alias gpull='git pull origin master'
function git-help() {
    echo "Git Custom Aliases Usage"
  	echo
  	echo " ga    = git add"
  	echo " gl    = git log"
	  echo " gp    = git push"
	  echo " gs    = git status"
  	echo " gpull = git pull origin master"
  	echo " gc    = git commit"
  	echo " gb    = git branch"
  	echo
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
