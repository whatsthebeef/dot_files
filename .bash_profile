####################################################### BASH CONFIG ##########################################

#--------------------------------- Environment variables----------------------------------#
## Path
PATH=${PATH}:${HOME}/dev/apps/glassfish/bin
PATH=${PATH}:${MYSQL_HOME}/bin

PATH=/usr/local/bin:${PATH}
PATH=${HOME}/bin:${PATH}
PATH=$PATH:${HOME}/.rvm/bin # Add RVM to PATH for scripting
PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

export PATH

## Others
export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)
# JAVA_HOME=/Library/Java/JavaVirtualMachines/1.6.0_65-b14-462.jdk/Contents/Home
# JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_45.jdk/Contents/Home

export MAVEN_OPTS="-Xmx1024M -XX:MaxPermSize=512M"

export SMX=${HOME}/dev/apps/apache-servicemix-5.0.0
export DL=${HOME}/Downloads
export DEV=${HOME}/dev
export VIMHOME=${HOME}/.vim
export MUTTHOME=${HOME}/.mutt
export ANDROID_HOME=${HOME}/dev/apps/android-adk/sdk

export CWD=${GOV}

export MYSQL_HOME=${HOME}/dev/apps/mysql

export MYVIFMRC=${HOME}/.vifmrc

export EDITOR=/usr/bin/vim

#--------------------------------------- Config -------------------------------------------#

### Vim in bash
set -o vi

### RVM
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && source "${HOME}/.rvm/scripts/rvm" 

### Tmux
if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi

### Source control
## Git
# git difftool --tool=vimdiff --no-prompt
# git mergetool --tool=vimdiff --no-prompt
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff
git config --global difftool.prompt false

#--------------------------------------- Aliases ------------------------------------------#

### Navigation
alias ..="cd .."
alias ...="cd ../../../"
alias ....="cd ../../../../"
alias .....="cd ../../../../"
alias .4="cd ../../../../"
alias .5="cd ../../../../.."
alias cddl="cd ${DL}"
alias cdsmx="cd ${SMX}"
alias cddev="cd ${DEV}"
alias cdvim="cd ${VIMHOME}"
alias cdmutt="cd ${MUTTHOME}"

### Standard bash
alias la="ls -alG"
alias psa="ps aux"

## Maven
alias mvni="mvn clean install -Dmaven.test.skip=true"

## Gradle
alias grr="gradle bootRun"
alias grb="gradle build"

## Pretty colours
PS1="\[\033[01;32m\]\u\[\033[01;34m\]::\[\033[01;31m\]\h \[\033[00;34m\]{ \[\033[01;34m\]\w \[\033[00;34m\]}\[\033[01;32m\]-> \[\033[00m\]"

### Config files
alias cb="vim ${HOME}/.bash_profile"
alias ct="vim ${HOME}/.tmux.conf"
alias cv="vim ${HOME}/.vimrc"
alias cl="vim ${HOME}/.lynxrc"
alias cm="vim ${HOME}/.muttrc"
alias ca="vim ${HOME}/.mutt/aliases"
# alias cvp="vim ${HOME}/.vimperatorrc"
alias cvp="vim ${HOME}/.pentadactylrc"
alias cvf="vim ${HOME}/.vifm"
alias cws="vim ${HOME}/bin/ws"

alias cvf="vim ${HOME}/.vifmrc"
alias cbr="source ${HOME}/.bash_profile"
alias ctr="tmux source-file ${HOME}/.tmux.conf"
alias cmr="source ${HOME}/.muttrc"
alias cvfr="source ${HOME}/.vifmrc"

### Vifm
## hack to make vifm close into current vifm location
alias vifm='source ~/bin/vf'

### Vim
## open in note search
function vimn() {
   vim -c "SearchNotes /$@/";
}

### Databases 
alias mysqld="${MYSQL_HOME}/bin/mysqld --basedir=${MYSQL_HOME} &"

#----------------------------------- Helper functions ----------------------------------#

# kill mysql process
function killMySql() {
   kill -9 `ps ax | awk '$5~/.*mysql.*/ { print $1 }'`
}

# kill diff process
function killDiff() {
   kill -9 `ps ax | awk '$6~/.*difftool.*/ { print $1 }'`
}

# kill ServiceMix process
function killSMX() {
   kill -9 `ps ax | awk '$12~/.*servicemix*/ { print $1 }'`
}

# kill gradle process
function killGradle() {
   kill -9 `ps ax | awk '$6~/.*Gradle*/ { print $1 }'`
}

# kill gradle process
function killSolr() {
   kill -9 `ps ax | awk '$12~/.*runSolr*/ { print $1 }'`
}

#------------------------------------- Project specific -----------------------------------#
## GeMaS
export G=${HOME}/dev/gemas/gemas_z/gemas-osgi
alias cdg="cd ${G}"
alias mysqlg="mysql -Dgemas -ugemas -pgemas"

## Visiens
export GOV=${HOME}/dev/govcountability
alias cdgov="cd ${GOV}"

## SVIMS
export SVIMS=${HOME}/dev/svims
alias cdsv="cd ${SVIMS}"
alias mysqls="mysql -Dsvims -usvims -psvims"
alias grf="gradle flow"

## Zuma 
export ZUMA=${DEV}/zuma_cms
export ZUMA_S3_BUCKET_NAME=zuma-webapp
export ZUMA_AWS_ACCESS_KEY_ID=AKIAJJ4BGGRL5UYGXHRA
export ZUMA_AWS_SECRET_ACCESS_KEY=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
alias cdz="cd ${ZUMA}"

