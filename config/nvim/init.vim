" Plugins {{{1 "
call plug#begin('~/.config/nvim/plugged')
Plug 'tarekbecker/vim-yaml-formatter'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'RRethy/vim-illuminate'
"Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim'
Plug 'mxw/vim-jsx'
Plug 'isRuslan/vim-es6'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/scratch.vim'
"Plug 'vim-scripts/calendar.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'Shougo/neco-vim'
"Plug 'neoclide/coc-neco'
"Plug 'ervandew/supertab'
Plug 'fatih/vim-go', { 'tag': '*'}
Plug 'andrewstuart/vim-kubernetes'
Plug 'neomake/neomake'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'masukomi/vim-markdown-folding'
"Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'airblade/vim-gitgutter'
"Plug 'vim-syntastic/syntastic'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'hdima/python-syntax'
Plug 'jelera/vim-javascript-syntax'
Plug 'junegunn/vim-easy-align'
"Plug 'vim-scripts/SQLUtilities'
Plug 'vim-scripts/dbext.vim'
Plug 'godlygeek/tabular'
Plug 'liuchengxu/vista.vim'
Plug 'elzr/vim-json'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'vimwiki/vimwiki'
Plug 'Quramy/tsuquyomi'
"Plug 'leafgarland/typescript-vim'
Plug 'google/vim-searchindex'
"Plug 'artur-shaik/vim-javacomplete2'
"Plug 'junegunn/vim-emoji'
Plug 'hashivim/vim-terraform'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'cohama/agit.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-eunuch'
Plug 'skbolton/embark'
call plug#end()
" 1}}} "

" Stock nvim & vim settings {{{1 "
set termguicolors
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
else
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
endif
let python_highlight_all = 1

set updatetime=1000
set lazyredraw

let did_install_default_menus = 1
set synmaxcol=500
set maxmempattern=2000

runtime macros/matchit.vim

set pastetoggle=<F11>

set mouse=a
set hidden
set number
set relativenumber
set ruler
" Highlights current line
set nocursorline
set showcmd
set cmdheight=2
syntax on
set nofoldenable
set foldmethod=marker
" Puts a line on column 80 of the screen. This is a good indicator for methods
" that are too long
set colorcolumn=80

set shell=/usr/bin/zsh

" Undofile directory settings
if exists("+undofile")
	" Creates an undo file so undo history is saved and can be executed
	" after the file is reopened
	set undofile
	" :help undo-persistence
	" This is only present in 7.3+
  if isdirectory($HOME . '/.config/nvim/undo') == 0
		:silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
  endif
	set undodir=~/.config/nvim/undo//
endif

nnoremap ' `
nnoremap ` '

" QuickFix windows are always the bottomest
au FileType qf wincmd J

" Set encoding
set encoding=utf-8

" Whitespace stuff
set wrap
set lbr
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab
set listchars=tab:᠁\

set nolist

"""""""""""""""
"  Searching  "
"""""""""""""""
set hlsearch
set incsearch
set ignorecase
set smartcase

""""""""""""""""""""
"  Mapping leader  "
""""""""""""""""""""
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*/.vagrant/*,*/.bundle/*,*.o,*.obj,.git,*.rbc

" Status bar
set laststatus=2
" set statusline=[%n]\ %<%f\ %([%1*%M%*%R%Y]%)\ \ %{SyntasticStatuslineFlag()}\ \ %=%-19(\LINE\ [%l/%L]\ COL\ [%02c%03V]%)\ %P
"
" Remember last location in file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" 1}}} "

" NERDTree Configuration {{{1 "
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>nn :NERDTreeToggle<CR>
map <Leader>nf :NERDTreeFind<CR>

" 1}}} "

function! s:setupWrapping()
	setlocal wm=2
	setlocal textwidth=80
endfunction

function! s:setupMarkup()
	"call s:setupWrapping()
	setlocal expandtab
	setlocal list
endfunction

function! s:setupYaml()
	setlocal expandtab
	setlocal list
endfunction

function! s:setupMake()
	setlocal noexpandtab
endfunction

" make uses real tabs
au FileType make call s:setupMake()
au Filetype yaml,yml call s:setupYaml()
"au BufWrite *.{yaml,yml} %!prettier --parser yaml

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()
let vim_markdown_preview_toggle=1
let vim_markdown_preview_github=1
let vim_markdown_preview_browser='Firefox'

au BufRead,BufNewFile *.txt call s:setupWrapping()

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
"au FileType python  set tabstop=4 textwidth=79
let g:jedi#force_py_version = 3

au FileType taskpaper set noautoindent

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

nmap <Leader><Space> :nohlsearch<CR>
au InsertEnter * let @/ = ''
au BufReadPost quickfix map <C-n> :cn<CR>
au BufReadPost quickfix map <C-m> :cp<CR>
au BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
"let g:aldmeris_transparent = 0
" let g:aldmeris_termcolors = "tango"
" color aldmeris
"set background=light
let base16colorspace=256
"color base16-default
" color kalisi
" color material
" color crayon
"color base16-tomorrow-night
"let g:one_allow_italics = 1
"color one
 "color anderson
color dracula
"color darcula
"color tender
"color OceanicNext
let g:nord_italic = 1
let g:nord_underline = 1
let g:nord_italic_comments = 1
let g:nord_uniform_diff_background = 1
let g:nord_cursor_line_number_background = 1
"color nord
"color embark
"color papercolor

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

let g:sqlutil_align_comma = 1

" set clipboard="
set clipboard+=unnamedplus

"		Grep																																	 {{{
let Grep_Find_Use_Xargs = 0
let Grep_Default_Options = '-i'
nnoremap <silent> <F3> :Grep<CR>
" }}}

au BufRead,BufNewFile *.jbuilder setf ruby
au BufRead,BufNewFile *.thor setf ruby
au BufRead,BufNewFile *.{md,mkd,txt} setlocal spell
au BufRead,BufNewFile COMMIT_EDITMSG setlocal spell

" Python spacing
au BufRead,BufNewFile python setlocal tabstop=4
au BufRead,BufNewFile python setlocal shiftwidth=4
au BufRead,BufNewFile python setlocal softtabstop=4
au BufRead,BufNewFile python setlocal textwidth=79

" Airline {{{1 "
let g:airline_powerline_fonts = 1
"let g:airline_theme='papercolor'
let g:airline_theme='dracula'
let g:airline#extensions#wordcount#filetypes = '\vhelp|markdown|rst|org|text|asciidoc|tex|mail|wiki'
" 1}}} "

" Spell {{{1 "
set spelllang=en_us
" 1}}} "

" FZF {{{1 "
" Keybindings
map <Leader>ff :FZF<CR>
map <Leader>fb :Buffers<CR>
map <Leader>fc :Commits<CR>
noremap <Leader>\ :execute 'Rg! '.expand('<cword>')<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.<q-args>, 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
set rtp+=/usr/local/opt/fzf
" 1}}} "

" Vimwiki {{{1 "
let g:vimwiki_folding='custom'
let g:vimwiki_hl_cb_checked=1
au FileType vimwiki nnoremap <C-P> :Vimwiki2HTMLBrowse<CR>
"au BufRead,BufNewFile *.wiki call s:setupWrapping()
au FileType vimwiki setlocal spell
let g:vimwiki_list = [
  \ {'path': '~/.vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
autocmd BufWritePost $HOME/.vimwiki/*.md silent execute '! git --git-dir=$HOME/.vimwiki/.git --work-tree=$HOME/.vimwiki add "%" > /dev/null; git --git-dir=$HOME/.vimwiki/.git --work-tree=$HOME/.vimwiki commit -q -m "%" 2>&1 > /dev/null'
let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':0
          \ , 'ctagsbin':'~/.vimwiki/utils/vwtags.py'
          \ , 'ctagsargs': 'markdown'
          \ }
let g:taskwiki_markup_syntax = "markdown"

" Only run VimwikiReturn if the popup menu is not showing, otherwise close it
"au FileType /home/jesse/.vimwiki/*.md inoremap <silent> <buffer> <expr> <CR>   pumvisible() ? "\<CR>"   : "<Esc>:VimwikiReturn 3 5<CR>"
autocmd FileType vimwiki inoremap <silent><buffer> <expr> <CR> pumvisible() ? "<C-y>" : "<C-]><Esc>:VimwikiReturn 1 5<CR>"
" 1}}} "

map <Leader>> :bn<CR>
map <Leader>< :bp<CR>

let g:snips_author = 'Jesse Dearing'

" Golang {{{1 "
let g:LanguageClient_serverCommands = {
       \ 'go': ['gopls']
       \ }
" Run gofmt and goimports on save
"autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
let $GOPATH = $HOME."/go"
let g:go_fmt_command = "gofmt"
let g:go_autodetect_gopath = 0
let g:go_fmt_autosave = 1
let g:go_template_autocreate = 0
"let g:go_auto_sameids = 1
let g:go_list_type = ""
let g:go_auto_type_info = 0
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
"let g:go_def_mode = 'gopls'
"let g:go_info_mode = 'gopls'
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_gopls_enabled = 0
let g:go_gopls_options = ['-remote=auto']

augroup go
  au FileType go nmap <Leader>i <Plug>(go-implements)
	au FileType go nmap <Leader>gd <Plug>(go-doc)
  "au FileType go nmap <leader>r <Plug>(go-rename)
  au FileType go nmap <leader>/ <Plug>(go-referrers)
	au FileType go nmap <leader>t <Plug>(go-test)
	au FileType go nmap <leader>c <Plug>(go-callers)
	au FileType go imap <C-e> <C-o><Plug>(go-iferr)
  au FileType go nmap <Leader>y <Plug>(go-info)
	au FileType go setlocal foldmethod=syntax
  " It's a spacey world out there, thankfully not in Go
  au FileType go setlocal noexpandtab
  au BufWritePost *.go normal! zv
augroup END

" 1}}} "

" NerdCommenter {{{1 "
let g:NERDDefaultAlign = 'left'
" 1}}} "

" Platinum Searcher (Ag) {{{ "
if executable('rg')
	set grepprg=rg\ --vimgrep\ -g\ \\!\.git/\\*\ -g\ \\!vendor/\\*
	"let g:ctrlp_user_command = 'ag %s -l -U --ignore public --ignore .bundle --ignore node_modules --ignore vendor --nocolor -g ""'

  " bind \ (backward slash) to grep shortcut
  "command -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Rg<SPACE>
endif

map <leader>! :mode<cr>

"let g:ctrlsf_ackprg = '/usr/local/bin/ag'

" }}} Platinum Searcher (Ag) "
set exrc
set secure

autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"let g:deoplete#file#enable_buffer_path = 1
"autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Terraform {{{1 "
let g:terraform_completion_keys = 1

let g:terraform_fmt_on_save = 1
" 1}}} "

" Neomake {{{1 "
highlight NeomakeError ctermfg=168 ctermbg=16 guifg=#e06c75 guibg=#282c34
highlight NeomakeWarning ctermfg=180 guifg=#e5c07b
call neomake#configure#automake('w')

let g:neomake_error_sign = {
      \ 'text': '‼',
      \ 'texthl': 'NeomakeErrorSign',
      \ }
let g:neomake_warning_sign = {
      \ 'text': '⁉',
      \ 'texthl': 'NeomakeWarningSign',
      \ }

let g:neomake_go_go_maker = {}

let g:neomake_vimwiki_writegood_maker = {
      \ 'exe': 'writegood',
      \ 'args': ['--parse'],
      \ 'errorformat': '%W%f:%l:%c:%m,%C%m,%-G',
      \ 'postprocess': function('neomake#makers#ft#text#PostprocessWritegood')
      \ }
let g:neomake_vimwiki_enabled_makers = ['writegood']
" 1}}} "

if has('nvim')
  " This does in-place updates (as opposed to a split window) when doing
  " search and replace
  set inccommand=nosplit
endif

function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

nmap <silent> <C-h> :call WinMove('h')<cr>
nmap <silent> <C-j> :call WinMove('j')<cr>
nmap <silent> <C-k> :call WinMove('k')<cr>
nmap <silent> <C-l> :call WinMove('l')<cr>

hi illuminatedWord cterm=underline gui=underline

" JSON {{{1 "
au Filetype json setlocal foldmethod=syntax
" 1}}} "

" Crontab {{{1 "
au filetype crontab setlocal nobackup nowritebackup
" 1}}} "

" coc.nvim {{{1 "
inoremap <silent><expr> <c-\> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <c-j> pumvisible() ? "\<C-y>" : "\<CR>"
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" 1}}} "

" Better Whitesapce {{{1 "
let g:strip_whitespace_on_save = 1
" 1}}} "

" Vista {{{ "
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
" }}} Vista "
