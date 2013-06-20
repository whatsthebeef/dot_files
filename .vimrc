" -------------------------

if has("win32")
   let g:xmlLint = "c:\\dev\\bin\\xmllint.exe"
   let g:tempDir = "c:\\tmp\\"
else   
   let g:xmlLint = "/usr/bin/xmllint" 
   let g:tempDir = "~/dev/.swptmp/"
endif

" -------------------------------------------------

let mapleader=',' 

syntax on           " syntax highlighing

set nocompatible    " use vim defaults
set ls=2            " always show status line
set tabstop=3       " numbers of spaces of tab character
set shiftwidth=3    " numbers of spaces to (auto)indent
set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set ruler           " show the cursor position all the time
set visualbell t_vb=    " turn off error beep/flash
set novisualbell    " turn off visual bell
set nobackup        " do not keep a backup file
set number          " show line numbers
set ignorecase      " ignore case when searching
set title           " show title in console title bar
set ttyfast         " smoother changes
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
set shortmess=atI   " Abbreviate messages
set nostartofline   " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files
set backspace=indent,eol,start
"set viminfo='20,<50,s10,h

" Tmux and vim creates problem copying to the system keyboard
" To resolve install reattach-to-user-namespace
" if $TMUX == ''
set clipboard+=unnamed
" endif

" Eclim stuff
filetype plugin on 
filetype indent on
set cot-=preview

set wildmenu      " nice command auto completion

" search settings
set hlsearch        " highlight searches
set incsearch       " do incremental searching

" should have ~/dev/swptmp/
exec 'set backupdir=' . g:tempDir 
exec 'set directory=' . g:tempDir 


set autoindent     " always set autoindenting on
set smartindent        " smart indent
set cindent            " cindent

" set autowrite      " auto saves changes when quitting and swiching buffer
set expandtab      " tabs are converted to spaces, use only when required
set invlist         " tabs are converted to spaces, use only when required
set sm             " show matching braces, somewhat annoying...
"set nowrap         " don't wrap lines

if has("gui_running")
 " See ~/.gvimrc
   set guifont=ProggyClean  " use this font
   set lines=60       " height = 50 lines
   set columns=100        " width = 100 columns

 " set background=light   " adapt colors for background
 " colorscheme Desert 
 " set selectmode=mouse,key,cmd

	set background=dark   " adapt colors for background
	colorscheme ir_black 
else
   set background=dark   " adapt colors for background
	colorscheme ir_black 
endif

if has("autocmd")
    " Restore cursor position
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " Filetypes (au = autocmd)
    au FileType helpfile set nonumber      " no line numbers when viewing help
    au FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
    au FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back
    
    " When using mutt, text width=72
    au FileType mail,tex set textwidth=72
    au FileType cpp,c,java,sh,pl,php,asp,rb,py  set autoindent
    au FileType cpp,c,java,sh,pl,php,asp,rb,py  set smartindent
    au FileType cpp,c,java,h,pl,php,asp,rb,py  set cindent
    "au BufRead mutt*[0-9] set tw=72
    
    " File formats
    au BufNewFile,BufRead  *.pls    set syntax=dosini
    au BufNewFile,BufRead  modprobe.conf    set syntax=modconf

	 "----- Open Nerd tree on start up
	 autocmd VimEnter * NERDTree 
	 au GUIEnter * simalt ~x
endif

map <Esc>[B <Down>

" clipboard magic
noremap <Leader>p "+p
noremap <Leader>y "+y

" ----------------- Keyboard mappings --------------------------

" General insert mappings EVERY ONE BE CAREFUL 
imap jj <ESC>

imap hh <BS>

" General Normal mappings
" map { <CR>
nmap c /
nmap <Leader>w :w!<CR>
nmap <Leader>q :q!<CR>
nmap mm a<BS><ESC>

" Buffers 
map <Leader>bp :bp<CR> 
map <Leader>bn :bn<CR>   
map <Leader>bq :bd<CR>   

" Greps
map <F4> :execute "vimgrep /" . expand("<cword>") . "/gj **" <Bar> cw<CR>
map <silent> <C-N> :silent noh<CR> " turn off highlighted search

" Config
nmap <Leader>r :e $MYVIMRC<cr>      " edit my vimrc file
nmap <Leader>R :!e $MYVIMRC<cr>      " edit my vimrc file !EVERYONE BE CAREFUL"
nmap ,u :source $MYVIMRC<cr> " update the system settings from my vimrc file
nmap ,U :!source $MYVIMRC<cr> " update the system settings from my vimrc file

" Xml
nmap <Leader>xt :exec '% !' . g:xmlLint . ' % --format'

" Nerd Tree
nmap <Leader>nb :NERDTree cruces<CR>
nmap <Leader>nh :NERDTree ~/.<CR>
nmap <Leader>nv :NERDTree vim_setup<CR>
nmap <Leader>na :NERDTree rabin<CR>
nmap <Leader>nr :NERDTree republico<CR>

" Inserts in normal mode 
nmap <Leader>O o<Esc>k
nmap <Leader>o o<Esc>

" Copying from Vim  
nmap <Leader>rn :set nonumber<CR>
nmap <Leader>rrn :set number<CR>

" ------------------ mvn stuff ------------------------------

" nmap ,mt :CLOutputToWindow mvn test<CR>
" nmap ,mp :CLOutputToWindow mvn package<CR>
" nmap ,me :CLOutputToWindow mvn eclipse:eclipse<CR>
" nmap ,mi :CLOutputToWindow mvn clean install<CR>

" ------------------ Eclim stuff ------------------------------

" nmap ,ei :JavaImport<CR>
" nmap ,ec :JavaCorrect<CR>
" nmap ,ef :%JavaFormat<CR>

" --------------------------------------------------------


" ------------------Commands------------------------------

" Nerd Tree
command NTH :NERDTree ~/.
command -nargs=1 NT :NERDTree <args>

" Search and replace 
command GREPT :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%') | copen
command -nargs=1 GREPQ :execute 'vimgrep /<args>/gj **' | copen
command -nargs=* Sub call FunSub(<f-args>)

" File 
command -nargs=1 NFT :exec g:tempDir . "<args>.txt"

" Wrapped VCSCommand function commands 
command -nargs=1 NTVCSCommit :execute 'call NewVCSCommit("<args>")'

" Command line stuff
command -nargs=1 CLOutputToWindow :let res = system(expand('<args>')) | new | put=res

" mvn
command -nargs=* MvnAddToRepositoy call FunMvnAddToRepository(<f-args>)

" --------------------------------------------------------

" ------------------ Functions ------------------------------

" Wrapper function for VCSAdd to enable it to work with Nerd tree
fun! NewVCSAdd()
   call DisableNERDTree()
   edit . "start netrw
   execute 'VCSAdd'
   call HijackNERTW()
   quit " quit add windows 
   quit " quit out of netrw-NerdTree window (we want it pure)
   NERDTree . 
endfunction

" Wrapper function for VCSCommit to enable it to work with Nerd tree
fun! NewVCSCommit(comment)
   call DisableNERDTree()
   edit . "start netrw
   execute 'VCSCommit ' . a:comment
   call HijackNERTW()
   quit " quit commit windows 
   quit " quit out of netrw-NerdTree window (we want it pure)
   NERDTree . 
endfunction

" Adds dependencies to local m2 repo
fun! FunMvnAddToRepository(artifactid, pathtojar)
    execute "!sudo mvn install:install-file -DgroupId=mx.com.root -DartifactId=" . 
       \   a:artifactid . " -Dversion=1.0 -Dpackaging=jar -Dfile=" . a:pathtojar
endfunction

" Adds dependencies to local m2 repo
fun! FunSub(original, new)
    execute "%s/" . a:original . "/" . a:new "/g"
endfunction

nnoremap <silent> <Leader>m :CommandT<CR>
nnoremap <silent> <Leader>t :CommandTBuffer<CR>
