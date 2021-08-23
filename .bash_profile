####################################################### BASH CONFIG ##########################################

#------------------------------------ bash config ----------------------------------------#

unset MAILCHECK

#--------------------------------- Environment variables----------------------------------#

export MYSQL_HOME=${HOME}/dev/apps/mysql
export DEV=${HOME}/dev 
export ANDROID_HOME=${HOME}/dev/apps/android-adk/sdk
export MONGO_HOME=${HOME}/dev/apps/mongodb-osx-x86_64-3.4.4
export NEO4J=${DEV}/apps/neo4j
# export CL_PARSE_APP_ID=kQoQ6C13go1v6OHlHr25NhVO7qxd7QWAf2SQq2jJ
export APP_ID=d7d8909ee4f8ac570212b6daeaef7e33
export MONGODB_URI=mongodb://localhost:27017/dev
export SERVER_URL=http://localhost:1337/parse
export MASTER_KEY=myMasterKey
export REDISCLOUD_URL=redis://localhost:6379
# export PIP_TARGET=/usr/local/lib/python3.6/site-packages/pip
export AWS_DEFAULT_REGION=us-east-1

# export GEM_PATH=${HOME}/.gem

## Because tmux is broken on OSX
export EVENT_NOKQUEUE=1

## Path
PATH=${PATH}:${HOME}/dev/apps/glassfish/bin
PATH=${PATH}:${MYSQL_HOME}/bin

PATH=/usr/local/bin:${PATH}
PATH=${HOME}/bin:${PATH}
PATH=${PATH}:${HOME}/.rvm/bin # Add RVM to PATH for scripting
PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
PATH=${ANDROID_HOME}/platform-tools:${PATH}
PATH=${MONGO_HOME}/bin:${PATH}
PATH=${NEO4J}/bin:${PATH}
PATH="/usr/local/opt/apr-util/bin:$PATH"
PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
PATH="$HOME/Library/Python/3.7/bin:$PATH"

export PATH

## Others
# export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
# JAVA_HOME=/Library/Java/JavaVirtualMachines/1.6.0_65-b14-462.jdk/Contents/Home
# JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_45.jdk/Contents/Home

export MAVEN_OPTS="-Xmx1024M -XX:MaxPermSize=512M"

export SMX=${HOME}/dev/apps/apache-servicemix-5.0.0
export DL=${HOME}/Downloads
export VIMHOME=${HOME}/.vim
export MUTTHOME=${HOME}/.mutt

SHELL_SESSION_HISTORY=0

# There is a CWD environment set in initSplitWindowProject to avoid being reset

# Sets SCHEME environment variable and terminal color scheme
# using whats in the current_scheme.txt
# eval `change-scheme $(head -n 1 ~/bin/current_scheme.txt)` 

export MYVIFMRC=${HOME}/.vifmrc

export EDITOR=vim

# export PHANTOMJS_BIN=${HOME}/.npm/phantomjs/1.9.15/package/bin/phantomjs

export MYSHELL=$(ps $$ | awk 'NR>1 {print $5}') 

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='mac'
fi

#--------------------------------------- Config -------------------------------------------#

### Tmux
if [[ ! $TERM =~ screen ]]; then
  exec tmux -S ~/tmp/default new-session # -s default 
fi

# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups

# append history entries.. (true so it is ignored) 
shopt -s histappend || true

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

### command to rescue 'can't connect to server'
# ps aux | grep -w [t]mux
# kill -USR1 <uid>
# tmux ls

### Vim in bash
if [[ $MYSHELL =~ bash ]]; 
then
  set -o vi
elif [[ $MYSHELL =~ zsh ]]; 
then
  bindkey -v
else 
  set -o vi
fi

### Source control
## Git
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff
git config --global difftool.prompt false
git config --global user.name 'John Bower'
git config --global user.email 'john@zode64.com'
git config --global alias.xpush '!git push $1 $2 && sh .git/hooks/post-push'

git config --global alias.accept-ours '!f() { git checkout --ours -- "${@:-.}"; git add -u "${@:-.}"; }; f'
git config --global alias.accept-theirs '!f() { git checkout --theirs -- "${@:-.}"; git add -u "${@:-.}"; }; f'

#--------------------------------------- Aliases ------------------------------------------#

### Use python 3 (for YCM vim plugin)
alias python='python3'

alias vim='/usr/local/bin/vim'

### Vim

# if [[ "$platform" == 'mac' ]]; then
#   alias vim='reattach-to-user-namespace -l ~/dev/apps/vim/src/vim'
#   defaults write com.apple.finder AppleShowAllFiles YES
# fi

### Vifm
## hack to make vifm close into current vifm location
# alias vifm='source ~/bin/vf'

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

## Camera 
alias killcam="sudo killall VDCAssistant"

## Pretty colours

if [[ $MYSHELL =~ bash ]]; then
  PS1="\[\033[01;32m\]\u\[\033[01;34m\]::\[\033[01;31m\]\h \[\033[00;34m\]{ \[\033[01;34m\]\w \[\033[00;34m\]}\[\033[01;32m\]-> \[\033[00m\]"
fi

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
# alias schhb='eval `change-scheme grb256`'
# alias schgh='eval `change-scheme github`'

if [[ "$platform" == 'mac' ]]; then
  alias sftpd="sudo launchctl start com.apple.ftpd"  
  alias sftpdstop="sudo launchctl stop com.apple.ftpd"  
  # alias sftpd="sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist"  
  # alias sftpdstop="sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist"  
fi

# find . -type f -exec sed -i -e 's/\$modal/\$uibModal/g' {} \;

alias parse-dashboard-local='parse-dashboard --serverURL="$SERVER_URL" --appId="$APP_ID" --masterKey="$MASTER_KEY"' 
alias parse-dashboard-staging='parse-dashboard --serverURL="https://pocketlab-parse-staging.herokuapp.com/parse" --appId="$APP_ID" --masterKey="$MASTER_KEY"' 

alias mongod-local='$MONGO_HOME/bin/mongod --dbpath=$MONGO_HOME/data'

alias redis-local='$REDIS_HOME/src/redis-server'

# from inside app
alias ng-serve-https='ng serve --host=0.0.0.0 --ssl 1 --ssl-key /usr/local/etc/httpd/server.key --ssl-cert /usr/local/etc/httpd/server.crt'
alias http-server-https='http-server -S -K /usr/local/etc/httpd/server.key -C /usr/local/etc/httpd/server.crt -o'
#----------------------------------- Compile functions ----------------------------------#

# Ensure python 3 is available
compileVim() {
  cd ~/dev/apps/vim
  ./configure --enable-python3interp
  make VIMRUNTIMEDIR=~/dev/apps/vim/runtime
  cd -
}

#----------------------------------- Helper functions ----------------------------------#

memUsage() {
  if [[ "$platform" == 'mac' ]]; then
    ps aux -m | less 
  else
    ps aux --sort -%mem | less 
  fi
}

cpuUsage() {
  if [[ "$platform" == 'mac' ]]; then
    ps aux -c | less 
  else
    ps aux --sort -%cpu | less 
  fi
}

rubyFindAndReplace() {
  # find . -name '*.rb' -type f -exec sed -i -e 's/$1/$2/g' {} +
  find . -name '*.rb' -o -name '*.html.erb' -type f -exec vim -c "%s/$1/$2/gIc" -c "wq" {} \;
}

rescueVifm() {
  rm ~/.vifm/vifminfo*
}

# To configure a kill function split the ps ax output by spaces and count the 
# in from the left until a string containing the identifier is found
# In the example below 'mysql' is in the path 5 from the left so we set the 
# number in the awk expression to $5
# 1809   ??  S      4:11.12 /Users/john/dev/apps/mysql/bin/mysqld --basedir=/Users/john/dev/apps/mysql
# kill mysql process

killChrome() {
  kill -9 `ps ax | awk '$6~/.*Chrome.app*/ { print $1 }'`
}

killVifm() {
  kill -9 `ps ax | awk '$5~/.*vifm.*/ { print $1 }'`
}

killVim() {
  kill -9 `ps ax | awk '$6~/.*vim.*/ { print $1 }'`
}

killMySql() {
  kill -9 `ps ax | awk '$5~/.*mysql.*/ { print $1 }'`
}

# kill diff process
killDiff() {
  kill -9 `ps ax | awk '$6~/.*difftool.*/ { print $1 }'`
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

# kill ionic process
killIonic() {
  kill -9 `ps ax | awk '$5~/.*ionic*/ { print $1 }'`
}

# kill  xcode
killXcode() {
  kill -9 `ps ax | awk '$5~/.*Xcode*/ { print $1 }'`
}

# first argument is init directory and second is command run in the second window

initDoubleWindowProject() {
  tmux new-window -c $1 -n $1 "source ~/.bash_profile ; vim"
  tmux setenv CWD $1
  if [ ! -z "$4" ]; then
    initSplit $2 $3 $4 $5
  else 
    tmux new-window -c $2 -n "$2 $3" "source ~/.bash_profile ; $3"
    tmux split-window -c "#{pane_current_path}" -v -p 50 
  fi
  tmux previous-window
}

# first argument is init directory and second is command run in bottom window
initSplitWindowProject() {
  # Don't close pane if one of the programs is closed (I think this needs to be set at   
  # the start of a session
  # tmux set -u set-remain-on-exit on
  # Editor pane
  # tmux new-window -c $1 -n $1 "source ~/.bash_profile ; vim"
  tmux new-window -c $1 -n $1 "vim"
  tmux setenv CWD $1
  # Process pane
  tmux split-window -c "#{pane_current_path}" -v -p 25 
  # Spare pane 
  if [ ! -z "$2" ]; then
    # tmux split-window -c "#{pane_current_path}" -h -p 50 "source ~/.bash_profile ; $2" 
    tmux split-window -c "#{pane_current_path}" -h -p 50 
    tmux run-shell "[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm"
    tmux run-shell "$2"
  fi
  if [ ! -z "$3" ]; then
    tmux select-pane -U
    # tmux split-window -c "#{pane_current_path}" -v -p 33 "source ~/.bash_profile ; $3"
    tmux split-window -c "#{pane_current_path}" -v -p 33 "$3"
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

# first argument is directory, second argument command to run, 
# third argument is second directory, fourth argument is fourth command
initSplit() {
  # tmux new-window -c $1 "source ~/.bash_profile ; $2"
  # tmux split-window -c $3 -v -p 50 "source ~/.bash_profile ; $4" 

  tmux new-window -c $1 "source ~/.bash_profile ; $2"
  tmux split-window -c $3 -v -p 50 "source ~/.bash_profile ; $4" 
}

initConfigs() {
  tmux new-window -c ~ -n "configurations" "vim ~/.bash_profile"
  tmux split-window -c ~ -v -p 50 "vim ~/.tmux.conf"
  # tmux split-window -c ~ -h -p 50 "vim ~/.pentadactylrc"
  # Select upper pane and split that as well
  tmux select-pane -U
  # tmux split-window -c ~ -h -p 50 "vim ~/.vimrc" 
}

### Prepare tar files
tarPLServices() {
  tar --exclude='./node_modules' --exclude='./dist' --exclude='./.git' -zvcf pocketlab-services.tar.gz pocketlab-services
}

# android project
tarAndroid() {
  tar --exclude=./bin/ --exclude=./*.apk --exclude=./\.* --exclude=./gen -cvzf $1.tar.gz $1
}

# android project
tarRails() {
  tar --exclude=./tmp --exclude=*.log --exclude=./\.* -cvzf $1.tar.gz $1
}


# Git search in revisions
gitRevisionSearch() {
  git rev-list --all | xargs git grep $1
}

# Andriody stuff
mountAndroid() { 
  hdiutil attach ~/dev/android/android.dmg.sparseimage -mountpoint /Volumes/android; 
}

umountAndroid() { 
  hdiutil detach -force /Volumes/android; 
}

ngServeHttps() {
  ng serve --env=local --host 0.0.0.0 --ssl 1 --ssl-cert '/usr/local/etc/httpd/server.crt' --ssl-key '/usr/local/etc/httpd/server.key'
}

# find, replace with, files with extensions
findAndReplace() {
  find . -type f -regex '.*.$3' -exec sed -i -e 's/$1/$2/g' {} \;
}

#------------------------------------- Project specific -----------------------------------#

# PocketLab android
export POCKETLAB=${DEV}/pocketlab-android
pocketlab() {
  initIDEProject $POCKETLAB 
}

# PocketLab chrome
export POCKETLAB_CHROME=${DEV}/pocketlab-chrome
pocketlabChrome() {
  initDoubleWindowProject $POCKETLAB_CHROME/app $POCKETLAB_CHROME "npm start" # "$POCKETLAB_CHROME" "npm test"
}

export POCKETLAB_CLOUDLAB=${DEV}/pocketlab-labnotebook
pocketlabCloudlab() {
  initSplit "$POCKETLAB_CLOUDLAB" "parse-server-local" "$MONGO_HOME" "bin/mongodb --dbpath=data" 
  initSplit "$POCKETLAB_CLOUDLAB" "parse-dashboard-local" "$REDIS_HOME" "src/redis-server" 
  initSplit "$POCKETLAB_CLOUDLAB" "rails s" "$POCKETLAB_CLOUDLAB" "vim" 
}

export VISIENS_SEARCH=${DEV}/visiens-search/solr-server
export VISIENS_SERVER=${DEV}/visiens
export VISIENS_FRONTEND=${DEV}/visiens-frontend
visiens() {
  initDoubleWindowProject $VISIENS_FRONTEND/app $VISIENS_FRONTEND "rails s" 
  $NEO4J/bin/neo4j start  
  initSplit "$VISIENS_SEARCH" "java -jar start.jar" "$NEO4J/logs" "tail -f neo4j.log" 
}

# NuvoLets 
export NUVOLETS=${DEV}/nuvolets
nuvolets() {
  initSplitWindowProject $NUVOLETS "rails s" 
}

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

invalidateNotebook() {
  # aws cloudfront create-invalidation --distribution-id $1 --paths # "/index.html" "/assets/i18n/en.json" "/assets/i18n/ja.json" "/assets/i18n/es.json" "/assets/i18n/vi.json" "/assets/i18n/ms.json" "/lab-report/xk00IeGK0001bppz" "/lab-report/pCnKv_U10001qsCB" "/sw.js" "/home" "/" "/trials"
  aws cloudfront create-invalidation --distribution-id $1 --paths "/*"

}

invalidateStaging() {
  invalidateNotebook E714R1X2HU58V
}

invalidateProd() {
  invalidateNotebook E2CX9KASQ2ZMXZ
}

invalidateDev() {
  invalidateNotebook EWZ39J47GE9R1
}

invalidateTaylor() {
  invalidateNotebook E2J79ESMM6RCKH
}

invalidateSeo() {
  invalidateNotebook EQXIDEBNZ7VBA
}
