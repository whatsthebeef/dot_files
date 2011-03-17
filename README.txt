My vim set up 

Has some customization to NERD_tree to allow it to function with directories in VCSCommand. This must be considered when upgrading.

There is a change to the netrw plugin which should sit in the vim installation plugin directory so it will need to moved to there on installation, eg. 

!sudo cp .vim/plugin/netrw.vim <VIM INSTALLATION DIR>/plugin


