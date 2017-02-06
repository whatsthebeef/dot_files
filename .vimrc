"--------------------Vundle---------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rvm'
Plugin 'pangloss/vim-javascript'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'JulesWang/css.vim' 
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'toyamarinyon/vim-swift'

" Optional
Plugin 'honza/vim-snippets'

call vundle#end()
" file type not working for ultisnip. Try playing with this.
filetype plugin indent on     " required

"" To install packets run :PluginInstall

"--------------------- Variables ----------------------

let g:tempDir = "~/dev/.swptmp/"

" ------------------ Configuration --------------------

""" General
let mapleader=','

syntax on           " syntax highlighing

"
""" Syntastic
set laststatus=2
set statusline=%f
" set statusline=%{fugitive#statusline()} " This means the status is only useful when working in git repo
" set statusline+=%#file#
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
set tabstop=2       " numbers of spaces of tab character
set shiftwidth=2    " numbers of spaces to (auto)indent
set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set ruler           " show the cursor position all the time
set visualbell t_vb=    " turn off error beep/flash
set novisualbell    " turn off visual bell
set nobackup        " do not keep a backup file
set number          " show line numbers
set ignorecase      " ignore case when searching
set smartcase       " If capitals are included in the search then take note
set title           " show title in console title bar
set ttyfast         " smoother changes
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
set shortmess=atI   " Abbreviate messages
set nostartofline   " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files
set backspace=indent,eol,start
"set viminfo='20,<50,s10,h

""" Folding
set foldmethod=indent
set foldlevelstart=4

" search settings
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set wildignorecase

""" Wild menu
set wildmenu
set wildmode=list:full
set wildignore=*.swp,*.bak
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignore+=*.tar.*

" should have ~/dev/swptmp/
exec 'set backupdir=' . g:tempDir
exec 'set directory=' . g:tempDir

set autoindent     " always set autoindenting on
set smartindent        " smart indent
set cindent            " cindent

" set autowrite      " auto saves changes when quitting and swiching buffer
set expandtab      " tabs are converted to spaces, use only when required
" set invlist         " Shows white space as characters
set sm             " show matching braces
"set nowrap         " don't wrap lines

""" Tags
set tags=./tags,tags
set tagstack

colorscheme grb256
hi StatusLineNC ctermbg=242
hi rubyConstant ctermfg=red
hi rubyFunction ctermfg=green
hi cssClassName ctermfg=blue
hi cssClassNameDot ctermfg=blue
hi cssIdentifier ctermfg=blue
hi cssProp ctermfg=blue
hi funcName ctermfg=blue
hi jsFunction ctermfg=green
hi jsNull ctermfg=green
hi jsThis ctermfg=blue
hi shOption ctermfg=black
hi shFunction ctermfg=red
hi htmlArg ctermfg=green

""" Tmux
" Tmux and vim creates problem copying to the system keyboard
" To resolve install reattach-to-user-namespace
" Not using as it is very disruptive
if $TMUX == ''
  set clipboard+=unnamed
endif

"" Maybe should be 1 for java
" let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
"" Jump only if it is an error
let g:syntastic_auto_jump = 2
"" Show error window automatically
let g:syntastic_auto_loc_list = 1

let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['jshint']

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-", 
      \ " proprietary attribute \"snap-",  
      \ " proprietary attribute \"md-",  
      \ " proprietary attribute \"layout",  
      \ "plain text isn't allowed in <head> elements",  
      \ " is not recognized!", 
      \ "trimming empty <i>",
      \ "discarding unexpected "]
" let g:syntastic_quiet_messages = { "level": "warnings" } 
let g:syntastic_html_tidy_exec = '/usr/local/bin/tidy5'
"" Java checkers - checkstyle is faster but doesn't check syntax
" let g:syntastic_java_checkers = ['javac', 'checkstyle']
let g:syntastic_java_checkers = ['checkstyle']

let g:syntastic_loc_list_height=3

""" Ultisnip
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"

" If you want :UltiSnipsEdit to split your window.

" --------------------------- Autocommand ------------------------------------


if has("autocmd")

  autocmd BufLeave *.css  normal! mC
  autocmd BufLeave *.scss  normal! mC
  autocmd BufLeave *.html normal! mH
  autocmd BufLeave *.erb normal! mH
  autocmd BufLeave *.js   normal! mJ
  autocmd BufLeave *.php  normal! mP
  autocmd BufLeave *.rb  normal! mR

  " Restore cursor position
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

  "" Filetypes (au = autocmd)
  au FileType helpfile set nonumber      " no line numbers when viewing help

  au FileType java set tabstop=4
  au FileType java set shiftwidth=4
  au FileType java set shiftwidth=4
  au Syntax java setlocal foldlevel=1

  au Syntax html setlocal foldmethod=indent
  au Syntax html setlocal foldlevel=2

  au FileType mail set textwidth=72" 
  au FileType mail set wrap
  au FileType mail set nocp
  au FileType mail set syntax=mail
  au FileType mail set spell
  au FileType mail set spelllang=en,es
  au FileType mail 0

  au FileType websearch nmap <CR> :call FunSearchWebWithLine()<CR>

  " Opens quickfix window when grepping in fugitive 
  au QuickFixCmdPost *grep* cwindow

  au FileType javascript :UltiSnipsAddFiletypes angular_js 
  au FileType javascript :UltiSnipsAddFiletypes javascript 

  au FileType ruby :UltiSnipsAddFiletypes ruby 

  au FileType html :UltiSnipsAddFiletypes html 
  au FileType html.erb :UltiSnipsAddFiletypes html 

  au FileType scss :UltiSnipsAddFiletypes scss 
  au FileType scss :UltiSnipsAddFiletypes css 
endif

" ------------------- Mappings and commands --------------------------------

"" Saving
" nmap <Leader>w :w!<CR>
" nmap <Leader>q :q!<CR>

"" General insert mappings EVERY ONE BE CAREFUL
" imap <BS> <Nop>
" inoremap <BS> <Nop>

"" Clipboard
" Copy/paste with the system buffer 
" noremap <Leader>p :call PasteFromSystemBuffer()<CR>
" noremap <Leader>y "+y
" function! PasteFromSystemBuffer()
"   exec "set paste"
"   call feedkeys('"+p')
"   exec "set nopaste"
" endfunction


"" Ex Commands
" By default enter ex-command for search and command
nmap : :<C-F>i
nmap / :<C-F>/

"" Deleting into an oblivion
nmap <leader>d "_d
nmap x "_dl

"" Don't record
nmap q <Nop>

nmap <C-w><Down> <C-w>-
nmap <C-w><Up> CTRL-W_<Up>

""" Sort out line endings and file types
command! RemoveWindowLineEndings :%s/$//g
command! ChangeFileType :set ff=unix

nmap <Leader>ds :call FunDeleteSwapFile()<CR>
"" Delete swap file of current file
function! FunDeleteSwapFile()
  let l:swpFile = g:tempDir.expand('%:t').".swp"
  echo l:swpFile
  execute "!rm ".l:swpFile
endfunction

""" Html
imap ,/ </<C-X><C-O>

""" Buffers
"" Buffers
map <Leader>n :silent b#<CR>
set wildcharm=<C-z>
nnoremap <leader>m :<C-f>isilent buffer<Space>
nnoremap <leader>B :<C-f>isbuffer<Space>

""" File
set path=.,**
nnoremap <leader>f :<C-f>isilent find *
nnoremap <leader>s :<C-f>isfind *
nnoremap <leader>v :<C-f>ivert sfind *
nnoremap <leader>t :<C-f>itabfind *
"" Under directory of current file
nnoremap <leader>F :silent find <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>S :sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>V :vert sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>T :tabfind <C-R>=expand('%:h').'/*'<CR>

"" Open a new file in the same directory as the file in the current buffer
"" using the name provided in the prompt
" nmap ,nf :call NewFileInDirOfCurrentBuffer()<CR>
function! NewFileInDirOfCurrentBuffer()
  call inputsave()
  let name = input("Enter file name: ")
  call inputrestore()
  execute "e %:p:h/".l:name
endfunction

"" Copies the file in the current buffer using the name provided in the prompt
nmap ,cf :call CopyCurrentBufferIntoFileInSameDir()<CR>
function! CopyCurrentBufferIntoFileInSameDir()
  call inputsave()
  let name = input("Enter file name: ")
  call inputrestore()
  let path = '%:p:h/'.l:name
  execute '!cp %:p '.l:path
  execute 'edit '.l:path
endfunction

function! DeleteFileInCurrentBuffer()
  call delete(expand('%')) | bdelete!
endfunction

"" Not necessary as I am using the notes.vim plugin which manages such commands 
command! -nargs=1 CreateTemporaryFile :exec g:tempDir . "<args>.txt"

""" Execute commands
command! -nargs=1 CLOutputToWindow :let res = system(expand('<args>')) | new | put=res

""" Config
nmap <Leader>u :tabedit $MYVIMRC<CR>      " edit my vimrc file
nmap <Leader>U :!tabedit $MYVIMRC<CR>      " edit my vimrc file !EVERYONE BE CAREFUL"
nmap <Leader>r :source $MYVIMRC<CR> " update the system settings from my vimrc file
nmap <Leader>R :!source $MYVIMRC<CR> " update the system settings from my vimrc file
nmap <Leader>J :tabedit ~/.jshintrc<CR>      " edit my jshint file

""" Grep
" turn off highlighted search
map <silent> <C-N> :silent noh<CR>

nmap <Leader>g :execute 'Ggrep ' . expand("<cword>")<CR>
command! -nargs=1 GgrepRev :execute 'Git! grep <args> $(git rev-list --all)'<CR>

" Extracts class name from value in clipboard and does tag search - called at start up in tmux script
" Also if it can find a line number it will add it to the 'l' register
function! FunSearchTagFromClipboard()
  set noignorecase
  let l:clipboard = getreg("*")
  let l:classWithLineNum = matchstr(l:clipboard, '[(]\zs[A-Za-z0-9:.]\+\ze[)]')
  if l:classWithLineNum != ""
    let l:class = matchstr(getreg("*"), '[A-Z][a-zA-Z]\+')
    let l:lineNum = matchstr(getreg("*"), '[:]\zs[0-9]\+')
    echo l:lineNum
    call setreg("0", l:lineNum)
  else
    let l:class = matchstr(getreg("*"), '\([A-Z][a-zA-Z]\+\)')
  endif
  execute 'FindTag '.l:class
  set ignorecase
endfunction

""" Tags
nmap g[ :tag<CR>
nnoremap <leader>j :<C-f>itjump /

"" TODO
function! FunCreateTagsAtDir()
  let l:query = getcwd()
  execute '!ctags -f ./tags -R '.l:query 
endfunction
"" Very stange behaviour
command! CreateTagsAtDir call FunCreateTagsAtDir()

""" Web
command! -nargs=* SearchWeb :!ws <args><CR>
nmap <Leader>ws :execute 'SearchWeb '.expand("<cword>")<CR>
function! FunSearchWebWithLine()
  execute "yank w"
  let l:query = shellescape(getreg("w"), 1)
  echo l:query
  execute 'SearchWeb '.l:query
endfunction
