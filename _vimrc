"------------------------------------------------------------------------------
"Basic settings
"
set nocompatible            "disable vi compatible mode
set exrc                    "allow execution of .vimrc from working dir
set secure                  "disable unsecure calls in .vimrc 

"windows specific
if has("win32")
    behave mswin
    let $HOME = $VIM
    set directory=$VIM/vimfiles/vimtmp/
    set backupdir=$VIM/vimfiles/vimtmp/
    set undodir=$VIM/vimfiles/vimtmp/
    source $VIMRUNTIME/mswin.vim
    set fileencodings=utf-8,cp1251
endif

syntax on                   "Syntax highlighting
set spelllang=en_us,ru_ru   "spell
set noequalalways           "disable windows size auto change
set hidden                  "hidde buffers instead closing
set incsearch               "Incremental search
set hlsearch                "Highlight search
set wrap                    "Don't wrap text
set encoding=utf8           "Set encoding inside Vim
"set virtualedit=all         "Moving around empty lines
set nu                      "Show line numbers
set ic                      "Ignore case in search
set noerrorbells            "Disable error bells

"Russian keyboard 
set iskeyword=@,a-z,A-Z,48-57,_,128-175,192-255 
set keymap=russian-jcukenwin

"Set default lang eng
set iminsert=0
set imsearch=0

     
"Indents
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"Windows split settings
set splitright   
set splitbelow
"------------------------------------------------------------------------------
"VUNDLE plugins
"
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'molokai'                                " color scheme
if has("win32")
    Plugin 'derekmcloughlin/gvimfullscreen_win32' " hide window title <F11>
endif
Plugin 's3rvac/AutoFenc'                        " automatic encoding detection
Plugin 'mkitt/tabline.vim'                      " text tabs
Plugin 'itchyny/lightline.vim'                  " bottom status line
Plugin 'jlanzarotta/bufexplorer'                " :bs :be
Plugin 'tpope/vim-fugitive'                     " GIT
Plugin 'scrooloose/nerdtree'                    " <F3>
Plugin 'majutsushi/tagbar'                      " <F8>
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'maralla/completor.vim'
Plugin 'Raimondi/delimitMate'                   " automatic closing of quotes
Plugin 'nvie/vim-flake8'                        " PEP8 checks
Plugin 'google/yapf', { 'rtp': 'plugins/vim' }  " PEP8 autoformatting
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'heavenshell/vim-pydocstring'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
call vundle#end()
filetype plugin indent on   "Enable plugins and indents
"------------------------------------------------------------------------------
"Specific files types settings
"
"Python
au FileType python
    \ set autoindent|
    \ set smartindent|
    \ set smarttab|
    \ set tabstop=4|
    \ set softtabstop=4|
    \ set shiftwidth=4|
    \ set expandtab|:
    \ set colorcolumn=79|
    \ set textwidth=79|
    \ set fileformat=unix
au FileType python nnoremap <buffer> <F9> :exec '!python3' shellescape(@%, 1)<CR>

"Web
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2|
    \ set softtabstop=2|
    \ set shiftwidth=2|
    \ set expandtab
"------------------------------------------------------------------------------
"windows specific options
"
if has("win32")
    "tagbar
    let g:tagbar_ctags_bin='$HOME\\.vim\\bundle\\ctags58\\ctags.exe'
    "completor
    let g:completor_python_binary = 'C:\\Python37\\python.exe'
endif
"------------------------------------------------------------------------------
"Keymaps
"
let mapleader = ","

"up/down scroll by alt+j/k
noremap <A-k> <C-Y><Up>
noremap <A-j> <C-E><Down>

"toggle highlight
map <C-_> :nohl<CR>

"langurge switch
inoremap <C-L> <C-^>

"search and replace selected text
vnoremap <C-r> "hy:%s/<C-r>h//g\|''<left><left><left><left><left>

"navigate through windows
nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j

"paste from system's clipboard
nnoremap <A-p> :pu<CR>

"disable shift pressing
nnoremap ; :

"NERDTree toggle
map <F3> :NERDTreeToggle %:p:h<CR>

"tagbar
nmap <F8> :TagbarToggle<CR>

"fzf Rg search
nmap <c-f> :Rg<CR>
"------------------------------------------------------------------------------
"Plugins tweaks
"
"vim-bookmarks
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '♦'
let g:bookmark_highlight_lines = 1
let g:bookmark_auto_save = 1
let g:bookmark_center = 1
let g:bookmark_auto_close = 1

"lightline
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

"pydocstring templates
let g:pydocstring_templates_dir = '$HOME/.vim/bundle/vim-pydocstrings-temlates'

"fzf Rg search color tweak
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number
    \ --no-heading --color=always --smart-case ".shellescape(<q-args>),
    \ 1, { 'options': ['--color', 'hl:#ff8787,hl+:#ff0000'] }, <bang>0)

"UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
":UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:ultisnips_python_style='google'
"------------------------------------------------------------------------------
"Color scheme tweaks
"
"the color of the textwitdh line (e.g. 80 symbols in *.py files)
highlight ColorColumn ctermbg=green guibg=DarkSlateGray
"------------------------------------------------------------------------------
