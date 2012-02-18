# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -f ~/.bashrc_ticketsolve ]; then
  . ~/.bashrc_ticketsolve
fi

######################################################
# Common
alias mv='mv -i'
alias rd='rm -rf'
alias ls='ls --color=auto' # All ls listings should have colour
alias ll='ls -l'
alias la='ls -lA'
alias lt='ls -lrt'
export GREP_COLOR=4 # Underline found text
alias gp='ack-grep -i'
alias ddiff='diff -qr' # Compare directoies, reporting differences file by file.
alias rake='rake -sN'
alias g='git'
function f() { find -iname "*$1*"; }

######################################################
# Processes
# Show all processes and commands
alias psl='ps ax -o pid,command -ww'
# Find matching processes 
alias psgrep='psl | grep'

######################################################
# Exports
export PS1='\[\e[1;34m\]${PWD}>\[\e[0m\]'
export FLEX_HOME=/Applications/Adobe\ Flex\ Builder\ 3/sdks/3.2.0
export PATH=~/bin:$PATH:/sbin:$FLEX_HOME/bin
export INPUTRC=~/.inputrc
export HISTIGNORE="&"
export HISTCONTROL=erasedups
export HISTFILESIZE=100000
export HOSTNAME
export EDITOR=~/bin/em

# http://wiki.bash-hackers.org/internals/shell_options
shopt -s histappend
shopt -s cmdhist                          # Save multilines as single
shopt -s dotglob
shopt -s extglob                          # Handle ?/*/+/@/!(...) patterns
shopt -s no_empty_cmd_completion
shopt -s checkhash                        # Check whether programs saved in path cache are still present
# "$BASH_VERSION" >= "4"
# shopt -s dirspell                         # Correct spelling of directory names
# shopt -s globstar

case $TERM in
  xterm*)
    export PROMPT_COMMAND='history -a && echo -ne "\033]0;${PWD}\007"'
    ;;
  *)
    export PROMPT_COMMAND=''
    ;;
esac
export XDG_DATA_HOME=~/.local

function set_screen_path() {
  screen -X chdir "`pwd`"
}

case $TERM in
screen*)
  PROMPT_COMMAND=set_screen_path
  ;;
esac

# Start a screen session
function scr() {
  ScreenSessions=$(screen -ls  | grep -E '(Attached|Detached)')
  ScreenSessionCount=$(echo "$ScreenSessions" | grep -E '.' | wc -l | grep -oE '[0-9]+')
  if [ "x$ScreenSessionCount" == 'x0' ]; then
    # Start a screen session
    if [ "x$SSH_TTY" == "x" ]; then
      screen
    else
      screen -c $HOME/.screenrc-remote
    fi
  else
    if [ "x$ScreenSessionCount" == 'x1' ]; then
      SessionStatus=$(echo "$ScreenSessions" | grep -oE 'Detached')
      if [ "x$SessionStatus" == 'xDetached' ]; then
        # Reattach to detached screen session
        screen -R
      fi
    else
      echo "$ScreenSessionCount screen sessions running."
    fi
  fi
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

