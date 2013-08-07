MYSQL_HOME=${HOME}/dev/apps/mysql

PATH=${PATH}:${HOME}/dev/apps/glassfish/bin
PATH=${PATH}:${MYSQL_HOME}/bin

PATH=/usr/local/bin:${PATH}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PATH

set -o vi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# ...other stuff...

if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi

## a quick way to get out of current directory ##
alias ..="cd .."
alias ...="cd ../../../"
alias ....="cd ../../../../"
alias .....="cd ../../../../"
alias .4="cd ../../../../"
alias .5="cd ../../../../.."

PS1="\[\033[01;32m\]\u\[\033[01;34m\]::\[\033[01;31m\]\h \[\033[00;34m\]{ \[\033[01;34m\]\w \[\033[00;34m\]}\[\033[01;32m\]-> \[\033[00m\]"

alias mvni="mvn clean install -Dmaven.test.skip=true"
alias la="ls -alG"
alias psa="ps aux"
 
