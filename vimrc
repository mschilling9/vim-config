""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Matthew Schilling VIMRC
"(YMMV)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"
"
"Use English regardless of system
set langmenu=en_US.UTF-8
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"TODO: why?
set nocompatible

"Turn on line numbers
set number

set history=500

"Detect file type
"load ftplugin.vim
"load indent.vim
filetype plugin indent on

"Enable file syntax
syntax on

"A buffer becomes hidden when it is abandoned
set hid

"show file info
set ruler

"Blink cursor on error instead of beeping
set visualbell
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"File encoding
set encoding=utf-8

"File type
set ffs=unix,mac,dos

"Wrap line when bigger than terminal size
set wrap

"TODO: why?
set textwidth=79

"tab characters appear 2 spaces wide
set tabstop=2

"size of indent
set shiftwidth=2

"simulate tab stops at this width with spaces and tabs
set softtabstop=2

"insert spaces instead of tabs. Effects retab
set expandtab

"Insert spaces or tabs to go to the next indent of the next tabstop
set smarttab

set noshiftround

"Apply indentation of current line to next
set autoindent

"Reacts to syntax of code you're editing
set smartindent

"Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime


"Use wildmenu
set wildmenu
set wildmode=longest:full,full

"Ignore certain files (binaries, repo info)
set wildignore=*.o,*~,*.pyc,*.exe
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"Ignore case when searching
set ignorecase

"When searching try to be smart about cases
set smartcase

"Highlight search results
set hlsearch

"Makes search act like search in modern browsers
set incsearch

"Don't redraw while executing macros (good performance config)
set ttyfast
set lazyredraw
set updatetime=300

"For regular expressions turn magic on
set magic

"Show matching brackets when text indicator is over them
set showmatch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowritebackup
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Additional Functionality
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> override permission denied error (sudo save)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> Spell checking
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing \ss will toggle and untoggle spell checking
"  <leader> is \ by default
map <leader>ss :setlocal spell!<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=>  Remove Windows ^M
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> Toggle Paste Mode (fix annoying paste errors)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>pp :setlocal paste!<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> Use system clipboard
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set clipboard^=unnamed,unnamedplus

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> Trim Whitespace
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

autocmd BufWritePre * if !&binary && &ft !=# 'mail' && &ft !=# 'markdown'
                   \|   call TrimWhitespace()
                   \| endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"UI Improvement
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> Shell section
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('$TMUX')
    if has('nvim')
        set termguicolors
    else
        set term=screen-256color
    endif
endif

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX
"check and use tmux's 24-bit color support
"(see <http://sunaku.github.io/tmux-24bit-color.html#usage>
"for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198>
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799
  "<https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162>
  "Based on Vim patch 7.4.1770 (`guicolors` option)
  "<https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd>
  "<https://github.com/neovim/neovim/wiki/Following-HEAD#20160511>
  if (has("termguicolors"))
    set termguicolors
  endif
endif

let &t_ut=''

set background=dark
"Use Gruvbox Colorscheme
"https://github.com/morhetz/gruvbox.git ~/.vim/pack/default/start/gruvbox
try
  autocmd vimenter * ++nested colorscheme gruvbox
catch /.*/
  colorscheme industry
endtry

"C++ syntax highlighting
"
"Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

"Put all standard C and C++ keywords under Vim's highlight group 'Statement'
"(affects both C and C++ files)
let g:cpp_simple_highlight = 1

" source ./vimrc-coc.vim
