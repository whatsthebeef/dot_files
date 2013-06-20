## My vim set up 

#### Summary

Project includes my .vimrc configuration file and plugins used

#### Instructions

##### SWP files and xmllint

To begin with your will see this code block.

    if has("win32")$
        let g:xmlLint = "c:\\dev\\bin\\xmllint.exe"
        let g:tempDir = "c:\\tmp\\"
    else
        let g:xmlLint = "/usr/bin/xmllint" 
        let g:tempDir = "~/dev/.swptmp/"
    endif
    
To get xmllint working so you can analyze and format your xml files download xmllint for your system and set the variable

    g:xmlLint = <xmllint location>
    
Corresponding to your system (if windows - under "win32" otherwise the other)

To make vim save swp files in a specific location so they aren't scattered about your system set the variable

    g:tempDir = <smp file location>
    
Corresponding to your system. The directory must exist.

##### CommandT

To use commandT plugin download from here https://github.com/wincent/Command-T

    nnoremap <silent> <Leader>m :CommandT<CR>
    nnoremap <silent> <Leader>t :CommandTBuffer<CR>
    
These lines already exist in our .vimrc which provide the shortcut

##### Update help

To update held run

    :helptags $HOME/.vim/doc to update vim help
    
##### Hidden chars

To toggle hidden characters (useful for github)

    :set invlist

##### reattach-to-user-namespace

The tmux + vim combination create problems copying to the system keyboard in MacOSX

To resolve install using homebrew (or compile from https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard)

    brew install reattach-to-user-namespace --wrap-pbcopy-and-pbpaste
    
Add this line to the beginning of .tmux.conf

    set-option -g default-command "reattach-to-user-namespace -l zsh"
    
And this line which is already in our .vimrc

    set clipboard+=unnamed

    
