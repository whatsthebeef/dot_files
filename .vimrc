
" ----------------- Varibles -------------------------

if has("win32")
   let g:xmlLint = "c:\\dev\\bin\\xmllint.exe"
   let g:tempDir = "c:\\tmp\\"
else   
   let g:xmlLint = "/usr/bin/xmllint" 
   let g:tempDir = "~/tmp/"
endif

" -------------------------------------------------

syntax on           " syntax highlighing

set nocompatible    " use vim defaults
set ls=2            " always show status line
set tabstop=3       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
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
"set viminfo='20,<50,s10,h

set wildmenu      " nice command auto completion

" search settings
set hlsearch        " highlight searches
set incsearch       " do incremental searching

" should have ~/tmp/.vimtmp  or ~/tmp created
exec 'set backupdir=' . g:tempDir . '.vimtmp,' . g:tempDir
exec 'set directory=' . g:tempDir . '.vimtmp,' . g:tempDir


set autoindent     " always set autoindenting on
set smartindent        " smart indent
set cindent            " cindent

"set autowrite      " auto saves changes when quitting and swiching buffer
set expandtab      " tabs are converted to spaces, use only when required
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
    au FileType cpp,c,java,sh,pl,php,asp,rb,py  set cindent
    "au BufRead mutt*[0-9] set tw=72
    
    " Automatically chmod +x Shell and Perl scripts
    "au BufWritePost   *.sh             !chmod +x %
    "au BufWritePost   *.pl             !chmod +x %

    " File formats
    au BufNewFile,BufRead  *.pls    set syntax=dosini
    au BufNewFile,BufRead  modprobe.conf    set syntax=modconf

	 "----- Open Nerd tree on start up
	 autocmd VimEnter * NERDTree 
	 au GUIEnter * simalt ~x
endif

" ----------------- Keyboard mappings --------------------------

" General insert mappings EVERY ONE BECAREFUL 
imap jj <ESC>

" General Normal mappings
" map { <CR>
nmap f /

" Buffers 
map <F1> :previous<CR>  " map F1 to open previous buffer
map <F2> :next<CR>      " map F2 to open next buffer

" Greps
map <F4> :execute "vimgrep /" . expand("<cword>") . "/gj **" <Bar> cw<CR>
map <silent> <C-N> :silent noh<CR> " turn off highlighted search

" Config
nmap ,e :e $MYVIMRC<cr>      " edit my vimrc file
nmap ,E :!e $MYVIMRC<cr>      " edit my vimrc file !EVERYONE BE CAREFUL"
nmap ,u :source $MYVIMRC<cr> " update the system settings from my vimrc file

" Xml
nmap ,xt :exec '% !' . g:xmlLint . ' % --format'

" Nerd Tree
nmap ,nb :NERDTree cruces<CR>
nmap ,nh :NERDTree ~/.<CR>

" Inserts in normal mode 
nmap ,O o<Esc>k
nmap ,o o<Esc>

" Copying from Vim  
nmap ,rn :set nonumber<CR>
nmap ,rrn :set number<CR>

" --------------------------------------------------------

" ------------------Commands------------------------------

" Nerd Tree
command NTH :NERDTree ~/.
command -nargs=1 NT :NERDTree <args>

" Greps
command GREPT :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%') | copen
command -nargs=1 GREPQ :execute 'vimgrep /<args>/gj **' | copen

" File 
command -nargs=1 NFT :exec g:tempDir . "<args>.txt"

" --------------------------------------------------------

" ------------------ Functions ------------------------------

" Wrapper function for VCSAdd to enable it to work with Nerd tree
fun! NewVCSAdd()
   call DisableNERDTree()
   edit . "start netrw
   VCSAdd<CR>
   call HijackNERTW()
   quit " quit add window
endfunction

" Wrapper function for VCSCommit to enable it to work with Nerd tree
fun! NewVCSCommit(comment)
   call DisableNERDTree()
   edit . "start netrw
   execute 'VCSCommit ' . a:comment
   call HijackNERTW()
   quit " quit commit window
endfunction
