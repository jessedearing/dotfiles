set nocompatible

call pathogen#infect()

set hidden
" Shows relative numbers on the side
set relativenumber
set number
set ruler
" Highlights current line
set cursorline
set showcmd
syntax on
" set foldmethod=syntax
" set foldlevelstart=99
set visualbell t_vb=
" Puts a line on column 80 of the screen. This is a good indicator for methods
" that are too long
set colorcolumn=80

" Undofile directory settings
if exists("+undofile")
  " Creates an undo file so undo history is saved and can be executed
  " after the file is reopened
  set undofile
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=~/.vim/undo//
endif

nnoremap ' `
nnoremap ` '

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab
" set list listchars=tab:\ \ ,trail:·
" Disables autoindent for current file (helpful for XML and HTML)
nnoremap <F8> :setl noai nocin nosi inde=<CR>

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
set wildignore+=*/.vagrant/*,*/.bundle/*,*.o,*.obj,.git,*.rbc

" Status bar
set laststatus=2
" set statusline=[%n]\ %<%f\ %([%1*%M%*%R%Y]%)\ \ %{SyntasticStatuslineFlag()}\ \ %=%-19(\LINE\ [%l/%L]\ COL\ [%02c%03V]%)\ %P

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>nn :NERDTreeToggle<CR>

" ZoomWin configuration
" map <Leader><Leader> :ZoomWin<CR>


" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=80
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

" Unimpaired configuration
" Bubble single lines
nmap <Leader><Up> [e
nmap <Leader><Down> ]e
" Bubble multiple lines
vmap <Leader><Up> [egv
vmap <Leader><Down> ]egv

nmap <Leader><Esc> :nohlsearch<CR>


" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
" color desert
" color twilight
" color lucius
" color wombat
" color tubster
let g:aldmeris_transparent = 1
let g:aldmeris_termcolors = "tango"
color aldmeris

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" set clipboard="
set clipboard=unnamed

" Testing 
map <Leader>r :!~/.rbenv/shims/bundle exec rake<CR>

" GNUpg
" ====================================================================
map <Leader>cd :%!gpg -d --batch -<CR>

"   Syntastic
" ====================================================================
" Enable syntastic syntax checking
let g:syntastic_enable_signs=1

"   Gist
" ====================================================================
let g:gist_private = 1
let g:gist_clip_command = 'pbcopy'
" let g:gist_open_browser_after_post = 1

"   Grep
" ====================================================================
let Grep_Find_Use_Xargs = 0
let Grep_Default_Options = '-i'
nnoremap <silent> <F3> :Grep<CR>

au BufRead,BufNewFile *.jbuilder setf ruby
au BufRead,BufNewFile *.thor setf ruby
au BufRead,BufNewFile *.{md,mkd,txt} set spell
au BufRead,BufNewFile COMMIT_EDITMSG set spell
au BufRead,BufNewFile *.rb set keywordprg=rvm\ default-with-rvmrc\ do\ ri

" Python spacing
au BufRead,BufNewFIle *.py set tabstop=4
au BufRead,BufNewFIle *.py set shiftwidth=4
au BufRead,BufNewFIle *.py set softtabstop=4

"   Powerline
" ====================================================================
" Settings
set rtp+=~/.dotfiles/vim/bundle/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'
set fillchars+=stl:\ ,stlnc:\ 

"   Spell
" ====================================================================
set spelllang=en_us
map <Leader>ds :set nospell<CR>

"   CtrlP
" ====================================================================
" Settings
let g:ctrlp_extensions = ['tag', 'line']
let g:ctrlp_open_multiple_files = 'h'
" Keybindings
map <Leader>ff :CtrlP<CR>
map <Leader>fv :CtrlP app/views<CR>
map <Leader>fm :CtrlP app/models<CR>
map <Leader>fs :CtrlP spec/<CR>
map <Leader>fw :CtrlP app/workers<CR>
map <Leader>fc :CtrlP app/controllers<CR>
map <Leader>fo :CtrlP app/concerns<CR>
map <Leader>fa :CtrlP app/assets<CR>


"   CTags
" ====================================================================
set tags=tags;/
map <Leader>rt :!/usr/local/bin/ctags --tag-relative -ftags --extra=+q --extra=+f --exclude=.git --exclude=.bundle --exclude=doc --exclude=coverage -R<CR><CR>
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

"   VimOrganizer
" ====================================================================
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org            call org#SetOrgFileType()

"   NarrowRegion
" ====================================================================
map <Leader>nr :NarrowRegion<CR>

"   Numbers
" ====================================================================
nmap <F3> :NumbersToggle<CR>

" Syntastic
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

" Gundo
" ====================================================================
map <Leader>gd :GundoToggle<CR>

" Vimwiki
" ====================================================================
let g:vimwiki_folding=1

" AutoPairs
" ====================================================================
let g:AutoPairsShortcutJump = '<C-\>'

" Vimux
" ====================================================================
map <Leader>vit :VimuxPromptCommand<CR>
map <Leader>vii :VimuxInspectRunner<CR>
map <Leader>vil :VimuxRunLastCommand<CR>


map <Leader>> :bn<CR>
map <Leader>< :bp<CR>

" Thrift Syntax
" ====================================================================

au BufRead,BufNewFile *.thrift set filetype=thrift
