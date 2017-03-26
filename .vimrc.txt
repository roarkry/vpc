set backspace=indent,eol,start " allow backspacing over everything in insert mode
set nocompatible  " use VIM, not VI
set softtabstop=2 " tabbing
set shiftwidth=2  " tabbing
set tabstop=2     " tabbing
set expandtab     " tabbing
set smartindent   " indent "smartly" 
set showmatch     " show matching brackets
set scrolloff=10  " keep at least 5 lines above/below
set autochdir     " switch to the working file directory
set number        " show numbers in the side bar
set ignorecase    " ignore case during search
set incsearch		  " do incremental searching
set hlsearch      " highlight search
set history=50		" keep 50 lines of command line history
set ruler		      " show the cursor position all the time
set showcmd		    " display incomplete commands
"set cul          " highlight the current line
syntax on         " turn on syntax highlighting

colorscheme slate " use a dark color scheme

" -------------------------
" Plug Ins
" -------------------------
" TaskList
" NerdTree
" MiniBufExplorer
" -------------------------

"Handles backup files (~), which currently I care for, but I'm leaving it in for future use...
" if has("vms")
"   set nobackup		" do not keep a backup file, use versions instead
" else
"   "TODO: Create these directories - VIM won't create them for you
"   set backup		" keep a backup file
"   set backupdir=~/.vim/backup " keep all backup files here
"   set directory=~/.vim/tmp " keep all temporary files here
" endif

" remove tool bar from GUI (T) and remove scroll bars (lrb)
if has("gui_running")
   set guioptions-=l
   set guioptions-=r
   set guioptions-=b
   set guioptions-=T
endif

" Use English for spell checking but don't spell check by default
if version >= 700
   set spl=en spell
   set nospell
endif

" *****************************
" KEY MAPPINGS
" *****************************

" A very popular and common keymap to protect from typos
nnoremap ; : 

" helps traverse long wrapped lines (won't skip to next line, but rather the line below
noremap k gk
noremap j gj

"map <F3> turn on spell check - must have CR, Enter, or Return on the end to run command
nnoremap <F3> :set spell<CR>:echo "z= to check words!"<CR>

"find current word in document (<C-R><C-W> gets current word)
nnoremap <C-f> /<C-R><C-W><CR>

"reload the VIMRC using F5
nnoremap <F5> :so $MYVIMRC<CR>
inoremap <F5> <Esc>:w<CR>:so $MYVIMRC<CR>a

" Edit vimrc 
nnoremap <silent> <F6> :sp ~/.vimrc<CR>

"wrap visual text highlight in comments 
vnoremap c <Esc>`>a*/<Esc>`<i/*<Esc>

"Map control-s to save in insert and normal mode
nnoremap <C-s> :w<CR>
"inoremap <C-s> <C-O>:w<CR>   " stays in insert mode
inoremap <C-s> <Esc>:w<CR>   " goes to normal mode

" jj -> escapes insert mode
inoremap jj <Esc>

" Create Blank Newlines and stay in Normal mode - silent means no message will be output to bottom
nnoremap <silent> <leader>j o<Esc>
nnoremap <silent> <leader>k O<Esc>

" Space will toggle folds!
nnoremap <space> za
vnoremap <space> zf

" Fold like a champion
nnoremap <silent> ff v%zf " create fold to corresponding bracket, brace, paren
nnoremap <silent> df zd   " delete the current fold
nnoremap <silent> daf zE  " delete all folds in a dock
nnoremap <silent> fo zR   " open all folds
nnoremap <silent> fc zM   " collapse all folds 
au BufWinLeave * mkview   " save view state when closing
au BufWinEnter * silent loadview " load view state when opening

" A mapping for the leader key - leader is backslash unless "let mapleader = " is called
" use to switch back and forth from split windows
nnoremap <leader>] <C-W><C-W><CR>

" remap to use Control and navigation keys to switch between windows
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-h> :wincmd h<CR>

" Expand or contract window with shift + or -
nnoremap + <C-w>+
nnoremap _ <C-w>-

" Retab a file (get rid of all tabs)
" nnoremap <leader>t :retab<CR> " Currently conflicts with TaskList
