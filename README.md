## My vim set up 

##### Summary

Project includes my .vimrc configuration file and plugins used

##### Instructions

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

Uses commandT plugin which requires vim to be compiled with ruby, will probably need to recompile the plugin to make it work

To update hepl run

    :helptags $HOME/.vim/doc to update vim help
    
To toggle hidden characters (useful for github)

    :set invlist
