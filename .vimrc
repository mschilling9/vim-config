" Matthew Schilling VIMRC 
" (YMMV) 
" 
"
"
" Use English regardless of system
set langmenu=en_US.UTF-8  
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" TODO: why?
set nocompatible

" Turn on line numbers
set number

set history=500

" Detect file type 
" load ftplugin.vim
" load indent.vim
filetype plugin indent on 

" Enable file syntax
syntax on

" show file info
set ruler

" Blink cursor on error instead of beeping
set visualbell

" File encoding
set encoding=utf-8

" Wrap line when bigger than terminal size
set wrap

" TODO: why?
set textwidth=79

" tab characters appear 2 spaces wide
set tabstop=2

" size of indent
set shiftwidth=2

" simulate tab stops at this width with spaces and tabs
set softtabstop=2

" insert spaces instead of tabs. Effects retab
set expandtab

" Insert spaces or tabs to go to the next indent of the next tabstop
set smarttab

set noshiftround

" Apply indentation of current line to next
set autoindent 

" Reacts to syntax of code you're editing
set smartindent

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime


" use wildmenu 
set wildmenu
set wildmode=longest:full,full

" Ignore certain files (binaries, repo info)
set wildignore=*.o,*~,*.pyc,*.exe
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set ttyfast
set lazyredraw

" For regular expressions turn magic on
set magic
  
" Show matching brackets when text indicator is over them
set showmatch


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Additional Functionality 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => override permission denied error (sudo save)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing \ss will toggle and untoggle spell checking
"  <leader> is \ by default
map <leader>ss :setlocal spell!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  Remove Windows ^M
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Toggle Paste Mode (fix annoying paste errors)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Use system clipboard
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set clipboard^=unnamed,unnamedplus
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI Improvement
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark

" Use Gruvbox Colorscheme 
" git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/default/start/gruvbox 
autocmd vimenter * ++nested colorscheme gruvbox
