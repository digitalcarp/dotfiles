"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "

set history=100
set updatetime=50

" Buffer becomes hidden when it is abandoned
set hidden

set ignorecase
set smartcase
set incsearch

set noswapfile
set nobackup

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors

set ruler
set number
set relativenumber

set signcolumn="yes:1"
set colorcolumn="80"

set scrolloff=8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set linebreak
set nowrap

set smartindent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <leader>l :bnext<CR>
map <leader>h :bprevious<CR>

set splitbelow
set splitright

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Remaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move selection by one line
xnoremap <S-j> :m '>+1<CR>gv=gv
xnoremap <S-k> :m -2<CR>gv=gv

" Keep cursor in middle
nnoremap <S-J> mzJ`z
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <PageDown> <C-d>zz
nnoremap <PageDown> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" Yank to system clipboard
nnoremap <leader>y \"+y
xnoremap <leader>y \"+y
nnoremap <leader>Y \"+Y

nnoremap <S-q> <Nop>

nnoremap <CR> :nohlsearch<CR>





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Settings not in neovim config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath+=~/.vim

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Auto read when file is changed from outside vim
set autoread

" Turn on the wild menu
set wildmenu
set wildmode=longest:full,full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.pchsem,*.def
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set lazyredraw
set magic

" Show matching brackets
set showmatch
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Allow for mouse scrolling
set mouse=a

filetype plugin on
filetype indent on
syntax enable

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8
set fileencoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

set noundofile

if !has('gui_running') && &term =~ '\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Close the current buffer
map <leader>bd :Bclose<CR>:tabclose<CR>gT
" Close all the buffers
map <leader>ba :bufdo bd<CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<CR>:pwd<CR>



" Ensure vim-plug is installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Plugins
Plug 'ngemily/vim-vp4'
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'

" Colorschemes
Plug 'lifepillar/vim-gruvbox8'
Plug 'vim-airline/vim-airline-themes'

" CLI
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
call plug#end()

" Colorscheme
""""""""""""""""""""""""""""""
set background=dark
colorscheme gruvbox8

" Airline
""""""""""""""""""""""""""""""
set noshowmode
set showtabline=0
"let g:airline_theme='bubblegum'
let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '<'
let g:airline_symbols.paste = 'P'
let g:airline_symbols.notexists = 'NE'
let g:airline_symbols.whitespace = '_'

" fzf
""""""""""""""""""""""""""""""
nmap <silent> <leader>p :Files<CR>
nmap <silent> <leader>b :Buffers<CR>
nmap <silent> <leader>m :History<CR>

" Hide statusline
autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_layout = { 'down': '40%' }

" vp4
""""""""""""""""""""""""""""""
let g:vp4_prompt_on_write = 1
let g:vp4_allow_open_depot_file = 1
nmap <leader>e :Vp4Edit<CR>
