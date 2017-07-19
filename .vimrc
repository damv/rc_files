" Pathogen
execute pathogen#infect()

" Filetype based identation
filetype plugin indent on

" Enables syntax coloring
set background=dark
syntax on

" Enables mouse integration
set mouse=a
set ttymouse=sgr

" utf8 encoding
set encoding=utf-8

" always show at least 3 lines above and below the cursor
set scrolloff=3

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" show matching when typing
set showmatch
set matchtime=3

" display incomplete commands
set showcmd

" Highlight cursor line
set cursorline
hi CursorLine cterm=NONE ctermbg=234 guibg=darkgrey

" Autocompletion in file names
set wildmenu
set wildmode=list:longest,full
set wildignore+=.git,.svn
set wildignore+=*.o,*.orig
set wildignore+=*.wav,*.jpeg,*.jpg,*.mp3,*.aac

" fast redraw
set ttyfast

" A tab is 8 columns long
set tabstop=8
set softtabstop=8
set shiftwidth=8

" Enables status line
hi StatusLine ctermbg=black ctermfg=darkgrey

" Ctags
set tags=tags;

" remap / to ignore regex
nnoremap / /\V
vnoremap / /\V
" ignore case when performing a search
set ignorecase
" ignore case only when typing in lower case
set smartcase
" highlights results of a search
set hlsearch
" disables highlighting from previous search
nnoremap <space> :noh<cr>

" show line numbers
set number

" show trailing whitespaces
highlight ExtraWhitespace ctermbg=52 guibg=darkred
match ExtraWhitespace /\s\+$/

" show tabs
set listchars=tab:\|\ 
highlight SpecialKey ctermfg=8
" show bad char
set listchars+=nbsp:X
set list

" Hihghlight 80th column in dark grey
hi ColorColumn ctermbg=234 guibg=darkgrey
autocmd FileType cpp,c,cxx,h,hpp,python,sh  setlocal cc=80

" Disable timeout
set timeoutlen=1000 ttimeoutlen=0

" Automatically reload modified files
set autoread

" Absolute line numbers
set norelativenumber

" Move easely between splits
nnoremap <silent> <c-h> <c-w><c-h>
nnoremap <silent> <c-j> <c-w><c-j>
nnoremap <silent> <c-k> <c-w><c-k>
nnoremap <silent> <c-l> <c-w><c-l>

" For rust : auto format on save
let g:rustfmt_autosave = 1

" Make the new split be the current
set splitbelow
set splitright

" Persistent undo
set undofile

set undodir=~/.vimundo
