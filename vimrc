set nocompatible

call pathogen#infect()

set number
set ruler
syntax on
" set foldmethod=syntax
" set foldlevelstart=99
set visualbell t_vb=


" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Mapping leader
let mapleader = ","
let g:mapleader = ","

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Status bar
set laststatus=2
set statusline=[%n]\ %<%f\ %([%1*%M%*%R%Y]%)\ \ \ [%{Tlist_Get_Tagname_By_Line()}]\ %=%-19(\LINE\ [%l/%L]\ COL\ [%02c%03V]%)\ %P

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" CTags
set tags=tags;/
map <Leader>rt :!/usr/local/bin/ctags --tag-relative -ftags --extra=+f --exclude=.git --exclude=doc --exclude=coverage -R<CR><CR>
map <Leader>gt :!.git/hooks/ctags<CR><CR>
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
" let g:tagbar_ctags_bin = "/usr/local/bin/ctags"
let Tlist_WinWidth = 50
map <Leader>tlt :TlistToggle<cr>
map <Leader>tll :TlistSessionLoad 
map <Leader>tls :TlistSessionSave 
map <Leader>tla :TlistAddFilesRecursive 
map <Leader>tlg :TlistSessionLoad .git/taglist<CR>
" map <Leader>tb :TagbarToggle<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" make uses real tabs
au FileType make                                     set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python  set tabstop=4 textwidth=79

au FileType taskpaper set noautoindent

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <Leader><Up> [e
nmap <Leader><Down> ]e
" Bubble multiple lines
vmap <Leader><Up> [egv
vmap <Leader><Down> ]egv

nmap <Leader><Esc> :nohlsearch<CR>

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
" color desert
" color twilight

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" set clipboard="
set clipboard=unnamed

" Gist
let g:gist_private = 1

" Grep
let Grep_Find_Use_Xargs = 0
let Grep_Default_Options = '-i'
nnoremap <silent> <F3> :Grep<CR>

au BufRead,BufNewFile *.jbuilder setf ruby
au BufRead,BufNewFile *.thor setf ruby

let g:Powerline_symbols = 'fancy'

let g:ctrlp_extensions = ['tag', 'line']
let g:ctrlp_open_multiple_files = 'h'

set ttyfast
set mouse=a
set ttymouse=xterm2
