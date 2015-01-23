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
export NEO4J=${DEV}/apps/neo4j-community-2.1.5

# There is a CWD environment set in initProject to avoid being reset

# Sets SCHEME environment variable and terminal color scheme
# using whats in the current_scheme.txt
eval `change-scheme $(head -n 1 ~/bin/current_scheme.txt)` 

export MYSQL_HOME=${HOME}/dev/apps/mysql

export MYVIFMRC=${HOME}/.vifmrc

export EDITOR=/usr/bin/vim

#--------------------------------------- Config -------------------------------------------#

### Tmux
if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi

### Vim in bash
set -o vi

### RVM
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && source "${HOME}/.rvm/scripts/rvm" 

### Source control
## Git
# git difftool --tool=vimdiff --no-prompt
# git mergetool --tool=vimdiff --no-prompt
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff
git config --global difftool.prompt false

#--------------------------------------- Aliases ------------------------------------------#

### Vim
alias vim=/usr/bin/vim

## open in note search
function vimn() {
   vim -c "SearchNotes /$@/";
}

### Vifm
## hack to make vifm close into current vifm location
alias vifm='source ~/bin/vf'

### Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias cddl="cd ${DL}"
alias cdsmx="cd ${SMX}"
alias cddev="cd ${DEV}"
alias cdvim="cd ${VIMHOME}"
alias cdmutt="cd ${MUTTHOME}"
alias cdn4="cd ${NEO4J}"

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

# http://linuxgazette.net/137/anonymous.html
cursor_style_default=0 # hardware cursor (blinking)
cursor_style_invisible=1 # hardware cursor (blinking)
cursor_style_underscore=2 # hardware cursor (blinking)
cursor_style_lower_third=3 # hardware cursor (blinking)
cursor_style_lower_half=4 # hardware cursor (blinking)
cursor_style_two_thirds=5 # hardware cursor (blinking)
cursor_style_full_block_blinking=6 # hardware cursor (blinking)
cursor_style_full_block=16 # software cursor (non-blinking)

cursor_background_black=0 # same color 0-15 and 128-infinity
cursor_background_blue=16 # same color 16-31
cursor_background_green=32 # same color 32-47
cursor_background_cyan=48 # same color 48-63
cursor_background_red=64 # same color 64-79
cursor_background_magenta=80 # same color 80-95
cursor_background_yellow=96 # same color 96-111
cursor_background_white=112 # same color 112-127

cursor_styles="\e[?${cursor_style_full_block};${cursor_foreground_black};${cursor_background_green};c" # only seems to work in tty

### Config files
alias cb="vim ${HOME}/.bash_profile"
alias ct="vim ${HOME}/.tmux.conf"
alias cv="vim ${HOME}/.vimrc"
alias cl="vim ${HOME}/.lynxrc"
alias cm="vim ${HOME}/.muttrc"
alias ca="vim ${HOME}/.mutt/aliases"
alias cvp="vim ${HOME}/.vimperatorrc"
# alias cvp="vim ${HOME}/.pentadactylrc"
alias cvf="vim ${HOME}/.vifmrc"
alias cws="vim ${HOME}/bin/ws"

alias cvf="vim ${HOME}/.vifmrc"
alias cbr="source ${HOME}/.bash_profile"
alias ctr="tmux source-file ${HOME}/.tmux.conf"
alias cmr="source ${HOME}/.muttrc"
alias cvfr="source ${HOME}/.vifmrc"

### Databases 
alias mysqld="${MYSQL_HOME}/bin/mysqld --basedir=${MYSQL_HOME} &"

### Scheme
alias schhb='eval `change-scheme grb256`'
alias schgh='eval `change-scheme github`'

#----------------------------------- Helper functions ----------------------------------#

rescueVifm() {
   rm ~/.vifm/vifminfo*
}

# To configure a kill function split the ps ax output by spaces and count the 
# in from the left until a string containing the identifier is found
# In the example below 'mysql' is in the path 5 from the left so we set the 
# number in the awk expression to $5
# 1809   ??  S      4:11.12 /Users/john/dev/apps/mysql/bin/mysqld --basedir=/Users/john/dev/apps/mysql
# kill mysql process

killVifm() {
   kill -9 `ps ax | awk '$5~/.*vifm.*/ { print $1 }'`
}

killMySql() {
   kill -9 `ps ax | awk '$5~/.*mysql.*/ { print $1 }'`
}

# kill diff process
killDiff() {
   kill -9 `ps ax | awk '$6~/.*difftool.*/ { print $1 }'`
}

# kill ServiceMix process
killSMX() {
   kill -9 `ps ax | awk '$12~/.*servicemix*/ { print $1 }'`
}

# kill gradle process
killGradle() {
   kill -9 `ps ax | awk '$6~/.*Gradle*/ { print $1 }'`
}

# kill gradle process
killSolr() {
   kill -9 `ps ax | awk '$12~/.*runSolr*/ { print $1 }'`
}

# kill rails process
killRails() {
   kill -9 `ps ax | awk '$6~/.*rails*/ { print $1 }'`
}

# kill rails process
killJava() {
   kill -9 `ps ax | awk '$5~/.*java*/ { print $1 }'`
}

# first argument is init directory and second is command run in bottom window
initProject() {
   # Don't close pane if one of the programs is closed (I think this needs to be set at   
   # the start of a session
   # tmux set -u set-remain-on-exit on
   # Editor pane
   tmux new-window -c $1 -n $1 "source ~/.bash_profile ; vim"
   tmux setenv CWD $1
   # Process pane
   tmux split-window -c "#{pane_current_path}" -v -p 25 
   # Spare pain 
   if [ ! -z "$2" ]; then
      tmux split-window -c "#{pane_current_path}" -h -p 50 "source ~/.bash_profile ; $2" 
   fi
   # Select editor pane
   tmux select-pane -U
   # for future windows, revert r-o-e to global value
   # tmux set -u set-remain-on-exit
}

# first argument is init directory, no second argument because no 
# process
initIDEProject() {
   # Editor pane
   tmux new-window -c $1 -n $1 "source ~/.bash_profile ; vim"
   tmux setenv CWD $1
   # Spare pane
   tmux split-window -c "#{pane_current_path}" -v -p 50 
   # Select editor pane
   tmux select-pane -L
}

initConfigs() {
   tmux new-window -c ~ -n "configurations" "vim ~/.bash_profile"
   tmux split-window -c ~ -v -p 50 "vim ~/.tmux.conf"
   tmux split-window -c ~ -h -p 50 "vim ~/.pentadactylrc"
   # Select upper pane and split that as well
   tmux select-pane -U
   tmux split-window -c ~ -h -p 50 "vim ~/.vimrc" 
}

### Prepare tar files

# android project
tarAndroid() {
   tar --exclude=./bin/ --exclude=./*.apk --exclude=./\.* --exclude=./gen -cvzf $1.tar.gz $1
}

# android project
tarRails() {
   tar --exclude=./tmp --exclude=*.log --exclude=./\.* -cvzf $1.tar.gz $1
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
svims() {
   initProject $SVIMS/$1 "gradle bootRun"
}

## Zuma 
export ZUMA=${DEV}/zuma_cms
alias cdz="cd ${ZUMA}"
alias psqlz="psql -d zuma"
zuma() {
   initProject $ZUMA "rails s"
}

# PocketLab
export POCKETLAB=${DEV}/pocketlab-android
pocketlab() {
   initIDEProject $POCKETLAB 
}

# Wedstival
export WEDSTIVAL=${DEV}/wedstival
wedstival() {
   initProject $WEDSTIVAL "rails s"
}

# Visiens
export VISIENS=${DEV}/govcountability
visiens() {
   initProject $VISIENS "rails s"
}

# Visiens server
export VISIENS_SERVER=${DEV}/visiens
visiensServer() {
   initProject $VISIENS_SERVER "cd $NEO4J"
}

# IICS wordpress server
export IICS=${DEV}/iics_wordpress
iics() {
   initProject $IICS 
}

# IICS main server
export IICS_MAIN=${DEV}/iics_main_site
iics_main() {
   initProject $IICS_MAIN 
}
