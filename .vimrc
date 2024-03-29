" Filetype based identation
filetype plugin indent on

" Enables syntax coloring
set background=dark
syntax on

" Enables mouse integration
set mouse=a
if !has('nvim')
	set ttymouse=sgr
endif

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

" relative line numbers
set number relativenumber
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Highlight cursor line and 80th column in dark grey
" hi ColorColumn ctermbg=234
" autocmd FileType cpp,c,cxx,h,hpp,python,sh  setlocal cc=80
augroup CursorLine
	au!
	au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	au VimEnter,WinEnter,BufWinEnter * set cul
	au WinLeave * setlocal nocursorline
	au WinLeave * set nocul
augroup END
hi CursorLine cterm=NONE ctermbg=234

" Current line number bold, not underlined
hi CursorLineNr cterm=NONE

" Markdown syntax highlighting
augroup markdown
	au!
	au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Custom lighterstatus line
set statusline=%f\ %h%w%m%r

" Autocompletion in file names
set wildmenu
set wildmode=list:longest,full
set wildignore+=.git,.svn
set wildignore+=*.o,*.orig
set wildignore+=*.wav,*.jpeg,*.jpg,*.mp3,*.aac
set wildignore+=*.pyc

" fast redraw
set ttyfast

" A tab is 8 columns long
set tabstop=8
set softtabstop=8
set shiftwidth=8

" Except in javascript files
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType vue setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" Enables status line
hi StatusLine ctermbg=black ctermfg=darkgrey

" Ctags
set tags=tags;

" Present list if multiple tags match
nnoremap <C-]> g<C-]>

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
nnoremap <silent> <space> :noh<cr>

" show line numbers
set number

" show tabs
set listchars=tab:\|\ 
hi SpecialKey ctermfg=8

" show bad char
set listchars+=nbsp:X
set list

" Disable timeout
set timeoutlen=1000 ttimeoutlen=0

" Automatically reload modified files
set autoread

" Absolute line numbers
set norelativenumber

" Better active split highlight
hi StatusLine   ctermfg=15 guifg=#ffffff ctermbg=235 guibg=#4e4e4e cterm=none gui=none
hi StatusLineNC ctermfg=15 guifg=#b2b2b2 ctermbg=235 guibg=#3a3a3a cterm=none gui=none
hi VertSplit ctermbg=235 ctermfg=235
hi LineNr ctermfg=242

" Move easely between splits
nnoremap <silent> <c-h> <c-w><c-h>
nnoremap <silent> <c-j> <c-w><c-j>
nnoremap <silent> <c-k> <c-w><c-k>
nnoremap <silent> <c-l> <c-w><c-l>

" Resize splits easely
nnoremap <silent> + <c-w>+
nnoremap <silent> - <c-w>-
nnoremap <silent> = <c-w>=

" For rust : auto format on save
let g:rustfmt_autosave = 1

" Make the new split be the current
set splitbelow
set splitright

" Persistent undo
set undofile
set undodir=~/.vimundo

" Include vimrc of current dir
set exrc

" Add directories of source to path
" argos
set path+=$PWD/app/**
set path+=$PWD/modules/**
set path+=$PWD/config/**
set path+=$PWD/documentation/**
" dcs
set path+=$PWD/alb_server/**
set path+=$PWD/tests/**
set path+=$PWD/api_communication/**
set path+=$PWD/system_controller/**

" Ack use ag
let g:ackprg = 'ag --vimgrep --smart-case --ignore "ctags"'
cnoreabbrev ag Ack
cnoreabbrev ack Ack

" Prevent autocompletion to search in included files
setglobal complete-=i

" cp command copy to system clipboard
command -range Cp :silent :<line1>,<line2>w !xsel -i -b

" Customize ConflictsMarker plugin
let g:conflict_marker_highlight_group = ''
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'
hi ConflictMarkerBegin guibg=#2f7366
hi ConflictMarkerOurs guibg=#2e5049
hi ConflictMarkerTheirs guibg=#344f69
hi ConflictMarkerEnd guibg=#2f628e


hi ALESignColumnWithoutErrors guibg=#000000
hi SignColumn guibg=#000000 ctermbg=354


" File with .md extension are markdown files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Disable section folding by default
let g:vim_markdown_folding_disabled = 1

" Use black as python formatter
let g:formatters_python = ['black']
let g:formatters_cpp = ['clangformat']

autocmd FileType yaml let b:autoformat_autoindent=0
autocmd FileType yaml let b:autoformat_retab=0

let g:formatdef_yamllint = '"yamllint -"'

" Spell check
set spell spelllang=en_us
hi clear SpellBad
hi clear SpellCap
hi clear SpellLocal
hi clear SpellRare
hi SpellBad cterm=underline

" Autoformat then write
command Aw Autoformat | write
cnoreabbrev aw Aw

" ALE config
let g:ale_linters = { 'cpp': ['clangcheck', 'clangd'] , 'python3': ['flake8', 'mypy', 'pylint', 'pyright'] }
let g:ale_cpp_clangcheck_options = '--extra-arg=-std=c++17'
let g:ale_fixers = { 'cpp': ['clangtidy'] }
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_c_build_dir =  'obj/dev'
let g:ale_python_flake8_options = '--max-line-length=120'
let g:ale_completion_enabled = 1
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
let g:ale_sign_warning = '-'
let g:ale_python_pylint_options = '--disable=R,C,W'
set scl=no

nmap <silent> <space>p <Plug>(ale_previous_wrap)
nmap <silent> <space>n <Plug>(ale_next_wrap)

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

let g:rtagsRcCmd = "rtags-rc"
set completefunc=RtagsCompleteFunc
nnoremap <silent> <Plug>(goCalls) :ALEFindReferences -relative<Return>
nnoremap <silent> <Plug>(goDef) :ALEGoToDefinition -relative<Return>
nnoremap <silent> <Plug>(goDefSplit) :ALEGoToDefinition -relative -split<Return>
nnoremap <silent> <Plug>(goImpl) :ALEGoToImplementation -relative<Return>
nnoremap <silent> <Plug>(goImplSplit) :ALEGoToImplementation -relative -split<Return>
nnoremap <silent> <Plug>(goHover) :ALEHover<Return>
nmap gc <Plug>(goCalls)
nmap gd <Plug>(goDef)
nmap <C-w>gd <Plug>(goDefSplit)
nmap gD <Plug>(goImpl)
nmap <C-w>gD <Plug>(goImplSplit)
nmap gh <Plug>(goHover)
"noremap gc :ALEFindReferences<cr>
"noremap <C-w>gc :call rtags#JumpTo(g:H_SPLIT, { '--declaration-only' : '' })<CR>
"noremap gd :ALEGoToDefinition<cr>
"noremap <C-w>gd :call rtags#JumpTo(g:H_SPLIT)<CR>
"noremap gD :ALEGoToImplementation<cr>
"noremap <C-w>gD :call rtags#JumpTo(g:H_SPLIT, { '--declaration-only' : '' })<CR>
"noremap gh :ALEHover<cr>
" noremap gd :call rtags#JumpTo(g:SAME_WINDOW)<CR>
" noremap <C-w>gd :call rtags#JumpTo(g:H_SPLIT)<CR>
" noremap gD :call rtags#JumpTo(g:SAME_WINDOW, { '--declaration-only' : '' })<CR>
" noremap <C-w>gD :call rtags#JumpTo(g:H_SPLIT, { '--declaration-only' : '' })<CR>
" noremap gc :call rtags#FindRefs()<CR>
" noremap gC :call rtags#FindRefsCallTree()<CR>
command RefreshTags !rtags_update
cnoreabbrev refreshtags RefreshTags
