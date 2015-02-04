"--------------------Vundle---------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

filetype plugin indent on     " required

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "scrooloose/syntastic"
Bundle "Shougo/unite.vim"
Bundle "Shougo/vimproc"
Bundle "tsukkee/unite-tag"
Bundle "xolox/vim-misc"
Bundle "xolox/vim-notes"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-surround"
Bundle "tpope/vim-rails"
Bundle "tomtom/tcomment_vim"

" Optional
Bundle "honza/vim-snippets"

"" To install packets run :PluginInstall

"--------------------- Variables ----------------------

if has("win32")
   let g:tempDir = "c:\\tmp\\"
else
   let g:tempDir = "~/dev/.swptmp/"
endif

" ------------------ Configuration --------------------

""" General
let mapleader=','

syntax on           " syntax highlighing

" set statusline=%{fugitive#statusline()} " This means the status is only useful when working in git repo
set ls=2            " always show status line
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

set foldmethod=syntax
set foldlevel=10

set wildmenu      " nice command auto completion

" search settings
set hlsearch        " highlight searches
set incsearch       " do incremental searching

" should have ~/dev/swptmp/
exec 'set backupdir=' . g:tempDir
exec 'set directory=' . g:tempDir

"  set autoindent     " always set autoindenting on
"  set smartindent        " smart indent
"  set cindent            " cindent

" set autowrite      " auto saves changes when quitting and swiching buffer
set expandtab      " tabs are converted to spaces, use only when required
" set invlist         " Shows white space as characters
set sm             " show matching braces
"set nowrap         " don't wrap lines

""" Tags
set tags=./tags,tags
set tagstack

""" Font and colours
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
   " Color scheme is linked with change-scheme bash script so terminal
   " and vim colors can be changed at the same time
   "
   " set background=dark   " adapt colors for background
   " colorscheme ir_black
   " set background=dark " adapt colors for background
   " colorscheme solarized
   colorscheme $SCHEME
   " colorscheme grb256
   hi StatusLine   ctermfg=15  guifg=#ffffff ctermbg=239 guibg=#4e4e4e cterm=bold gui=bold
   hi StatusLineNC ctermfg=249 guifg=#b2b2b2 ctermbg=237 guibg=#3a3a3a cterm=none gui=none
end

""" Tmux
" Tmux and vim creates problem copying to the system keyboard
" To resolve install reattach-to-user-namespace
" Not using as it is very disruptive
" if TMUX == ''
"   set clipboard+=unnamed
" endif

""" Syntastic
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 0
"" Jump only if it is an error
let g:syntastic_auto_jump = 2
"" Show error window automatically
" let g:syntastic_auto_loc_list = 1
"" Java checkers - checkstyle is faster but doesn't check syntax
let g:syntastic_java_checkers = ['javac', 'checkstyle']
"
""" Unite
" Doesn't seem to work DEPRECATED 
"let g:unite_source_grep_max_candidates = 1000
" Doesn't seem to work either DEPRECATED 
let g:unite_source_grep_command = 'Ggrep'
" let g:unite_source_grep_default_opts = '--exclude-dir={target,.git}'
" let g:unite_source_rec_async_command='ag --nocolor --nogroup --ignore ".hg" 
" --ignore ".svn" --ignore ".git" --ignore ".bzr" --ignore "target" --hidden -g ""'
let g:unite_source_file_rec_max_cache_files = 0
let g:unite_winheight=10

call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 0)
call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern',
         \ '\.git/\|target/\|tmp/\|rails_docs/\|vendor\|bin\|build\|.settings\|.classpath\|.project')
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

""" Fugitive works by opening up new file in the index so we need to open 
" the file first then run Gedit
let my_gedit = {}
function! my_gedit.func(candidate)
   call unite#take_action("open", a:candidate)
   exec "Gedit"
endfunction
call unite#custom#action("file,buffer", "gedit", my_gedit)
unlet my_gedit

let my_gedit_vsplit = {}
function! my_gedit_vsplit.func(candidate)
   vsplit
   call unite#take_action("open", a:candidate)
   exec "Gedit"
endfunction
call unite#custom#action("file,buffer", "gedit_vsplit", my_gedit_vsplit)
unlet my_gedit_vsplit

"" call unite#custom#default_action("file,buffer", "gedit") 
""" Notes
let g:notes_directories = ['~/Documents/Notes']

" --------------------------- Autocommand ------------------------------------

if has("autocmd")
   " Restore cursor position
   au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

   "" Filetypes (au = autocmd)
   au FileType helpfile set nonumber      " no line numbers when viewing help
   au FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
   au FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back

   au FileType java set tabstop=4
   au FileType java set shiftwidth=4
   au FileType java set shiftwidth=4
   au Syntax java setlocal foldlevel=1

   " File formats
   au BufNewFile,BufRead  *.pls    set syntax=dosini
   au BufNewFile,BufRead  modprobe.conf    set syntax=modconf

   au Syntax html setlocal foldmethod=indent
   au Syntax html setlocal foldlevel=2

   au FileType vim set noswapfile
   au FileType conf set noswapfile
   au FileType sh  set noswapfile

   au FileType mail set textwidth=72" 
   au FileType mail set wrap
   au FileType mail set nocp
   au FileType mail set syntax=mail
   au FileType mail set spell
   au FileType mail set spelllang=en,es
   au FileType mail 0

   au FileType notes set spell
   au FileType notes set spelllang=en,es
   au FileType notes set textwidth=72" 
   au FileType notes set noautoindent
   au FileType notes set nosmartindent

   au FileType websearch nmap <CR> :call FunSearchWebWithLine()<CR>
   "----- Open Nerd tree on start up
   " autocmd VimEnter * NERDTree
   " au GUIEnter * simalt ~x
   
   " Opens quickfix window when grepping in fugitive 
   autocmd QuickFixCmdPost *grep* cwindow
endif

" ------------------- Mappings and commands --------------------------------

""" Fundamentals
"" Inserts in normal mode
nmap <Leader>O o<Esc>k
nmap <Leader>o o<Esc>
"" Buffers
" Using Unite buffers
" map <Leader>bp :bp<CR>
" map <Leader>bn :bn<CR>
" map <Leader>bq :bd<CR>
"" Movements
" map { <CR>
" nmap c /
"" Need the double for creating markers
" nmap mm a<BS><ESC>
"" Saving
nmap <Leader>w :w!<CR>
nmap <Leader>q :q!<CR>
nmap q :q!<CR>
"" General insert mappings EVERY ONE BE CAREFUL
" imap jj <ESC>
imap <BS> <Nop>
inoremap <BS> <Nop>
"" Nasty delete
" imap hh <BS>

"" Clipboard
" Copy/paste with the system buffer 
noremap <Leader>p :call PasteFromSystemBuffer()<CR>
noremap <Leader>y "+y
function! PasteFromSystemBuffer()
   exec "set paste"
   call feedkeys('"+p')
   exec "set nopaste"
endfunction

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
command RemoveWindowLineEndings :%s/$//g
command ChangeFileType :set ff=unix

nmap <Leader>ds :call FunDeleteSwapFile()<CR>
"" Delete swap file of current file
function! FunDeleteSwapFile()
   let l:swpFile = g:tempDir.expand('%:t').".swp"
   echo l:swpFile
   execute "!rm ".l:swpFile
   " Delete doesn't seem to want to work. We don't get 
   " return value with rm but at least it works
   " let l:delSuccess = delete(l:swpFile)
   " if l:delSuccess == 0 
   "    echo l:swpFile." deleted"
   " else
   "    echo l:swpFile." delete failed"
   " endif
endfunction

""" Html
imap ,/ </<C-X><C-O>

""" Clear spaces at end of lines, also removes all the other $
" map <leader>W :%s/\s\+\$$//<CR>:let @/=''<CR>

""" Change to cwd 
nmap <Leader>wd :cd $CWD<CR>

""" File
"" Open a new file in the same directory as the file in the current buffer
"" using the name provided in the prompt
nmap ,nf :call NewFileInDirOfCurrentBuffer()<CR>
function NewFileInDirOfCurrentBuffer()
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
   execute "!cp %:p %:p:h/".l:name
endfunction

function DeleteFileInCurrentBuffer()
   call delete(expand('%')) | bdelete!
endfunction

"" Not necessary as I am using the notes.vim plugin which manages such commands 
" command -nargs=1 CreateTemporaryFile :exec g:tempDir . "<args>.txt"

""" Execute commands
command -nargs=1 CLOutputToWindow :let res = system(expand('<args>')) | new | put=res

""" Config
nmap <Leader>u :sp $MYVIMRC<CR>      " edit my vimrc file
nmap <Leader>U :!sp $MYVIMRC<CR>      " edit my vimrc file !EVERYONE BE CAREFUL"
nmap <Leader>r :source $MYVIMRC<CR> " update the system settings from my vimrc file
nmap <Leader>R :!source $MYVIMRC<CR> " update the system settings from my vimrc file


""" Copying
nmap <Leader>rn :set nonumber<CR>
nmap <Leader>rrn :set number<CR>

""" Grep
"" Vimgrep - slow
command GREPT :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%') | copen
command -nargs=1 GREPQ :execute 'vimgrep /<args>/gj **' | copen
map <F4> :execute "vimgrep /" . expand("<cword>") . "/gj **" <Bar> cw<CR>
" turn off highlighted search
map <silent> <C-N> :silent noh<CR>
"" External Grep
function FunGrep(text, dir)
   execute 'silent grep! -ir '.a:text.' '.a:dir.' --exclude-dir={target,bin,.settings}' | copen
endfunction

""" Maven
function FunAddJarToRepository(artifactid, pathtojar)
   execute "!sudo mvn install:install-file -DgroupId=mx.com.root -DartifactId=" .
            \   a:artifactid . " -Dversion=1.0 -Dpackaging=jar -Dfile=" . a:pathtojar
endfunction

""" CommandT
"" Using Unite instead of CommandT as it doesn't need the ruby calls and it is
"" more async
" nnoremap <silent> <Leader>m :CommandTJump<CR>
" Current directory file search not so useful while using vifm
" nnoremap <silent> <Leader>m :CommandT<CR>
" nnoremap <silent> <Leader>t :CommandTBuffer<CR>

""" Unite
"" Open files in split
" Like most unite configs - doesn't work
" General
nnoremap <silent><leader>ll :<C-u>UniteResume<CR>

au FileType unite call s:unite_settings()
" TODO make open in split window on command
function s:unite_settings()
   " inoremap <silent><buffer><expr><C-v> :call unite#mappings#do_action('vsplit')
   nmap <C-x> :call unite#mappings#do_action("gedit_vsplit")<CR>
   " imap <C-v> <Esc>j:call unite#mappings#do_action('vsplit')<CR>
endfunction

"" Tag search
" Not sure on default vsplit
" command -nargs=1 FindTag :Unite -keep-focus -no-quit -default-action=vsplit -input=<args> tag
command -nargs=1 FindTag :Unite -keep-focus -input=<args> -silent tag
nmap <Leader>tf :FindTag<Space>
command AllTags :Unite -keep-focus -no-quit tag
nmap <Leader>ta :AllTags<CR>
nmap <Leader>t :execute 'FindTag ' . expand("<cword>")<CR>

nmap <Leader>g :execute 'Ggrep ' . expand("<cword>")<CR>

" Extracts class name from value in clipboard and does tag search - called at start up in tmux script
" Also if it can find a line number it will add it to the 'l' register
function FunSearchTagFromClipboard()
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

"" File search
" Not sure on using vsplit
" command -nargs=1 FindFileCurrentDir :Unite -default-action=vsplit -input=<args> file_rec
command -nargs=1 FindFileCurrentDir :Unite -input=<args> file_rec
nmap <Leader>fc :FindFileCurrentDir<Space>

function FunFileSearch(name, dir, ...)
   let l:cwd = getcwd()
   let l:absDir = a:0 > 0 ? a:1 : ""
   if stridx(a:dir, "/") == 0
      let l:absDir .= a:dir
   else
      let l:absDir .= "/".a:dir
   endif
   execute "cd" l:absDir
   execute "FindFileCurrentDir" a:name
   execute "cd" l:cwd
endfunction
command -nargs=* FindFileDir call FunFileSearch(<f-args>, "/")
nmap <Leader>fd :FindFileDir<Space>

command AllFilesCurrentDir :Unite file
nmap <Leader>f :AllFilesCurrentDir<CR>
command AllFilesCurrentDirRec :Unite -start-insert -silent file_rec 
nmap <Leader>m :AllFilesCurrentDirRec<CR>

"" Jump search
command -nargs=1 FindJump :Unite -input=<args> jump
command AllJumps :Unite jump
nmap <Leader>js :FindJump<Space>
nmap <Leader>ja :AllJumps<CR>

"" Buffer search
command AllBuffers :Unite buffer
nmap <Leader>ba :AllBuffers<CR>

""" Vifm
nmap <Leader>sp :VsplitVifm<CR>

""" Helptags
nmap <Leader>ht :helptags $VIMRUNTIME/doc<CR>

""" Tags
nmap g[ :tag<CR>

"" TODO
function FunCreateTagsAtDir(dir)
endfunction
"" Very stange behaviour
command -nargs=* CreateTagsAtDir :!ctags -f "/Users/john/dev/gemas/gemas_z/gemas-osgi/tags" -R "/Users/john/dev/gemas/gemas_z/gemas-osgi"<CR>

""" Web
command -nargs=* SearchWeb :!ws <args><CR>
nmap <Leader>ws :execute 'SearchWeb '.expand("<cword>")<CR>
function FunSearchWebWithLine()
   execute "yank w"
   let l:query = shellescape(getreg("w"), 1)
   echo l:query
   execute 'SearchWeb '.l:query
endfunction

""" Notes
command -nargs=* FindNote :SearchNotes /<args>/<CR>
nmap <Leader>fn :FindNote<Space>

"----------------- Project specific ------------------------"

""" GeMaS
"" Unite
command -nargs=* FindFileGemas call FunFileSearch(<f-args>, $G)
nmap <Leader>fg :FindFileGemas<Space>
command -nargs=1 FindFileVerificacion call FunFileSearch(<f-args>, "verificacion-app", $G)
nmap <Leader>fv :FindFileVerificacion<Space>
command -nargs=1 FindFileControl call FunFileSearch(<f-args>, "control-app", $G)
nmap <Leader>fc :FindFileControl<Space>
command -nargs=1 FindFileFlujo call FunFileSearch(<f-args>, "flujo-app", $G)
nmap <Leader>ff :FindFileFlujo<Space>

"" Grep
command -nargs=1 GrepGemas call FunGrep(<f-args>, $G)

""" Zuma
"" Grep
command -nargs=1 GrepZuma call FunGrep(<f-args>, $ZUMA)
nmap <Leader>gz :call FunGrep(expand("<cword>"), $ZUMA)<CR>

