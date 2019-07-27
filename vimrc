call plug#begin('~/.vim/plugged')
Plug 'tarekbecker/vim-yaml-formatter'
Plug 'pedrohdz/vim-yaml-folds'
"Plug 'rust-lang/rust.vim'
"Plug 'racer-rust/vim-racer'
"Plug 'christianrondeau/vim-base64'
Plug 'RRethy/vim-illuminate'
"Plug 'rakr/vim-one'
Plug 'arcticicestudio/nord-vim'
Plug 'mxw/vim-jsx'
Plug 'isRuslan/vim-es6'
"Plug 'chriskempson/base16-vim'
"Plug 'mhartington/oceanic-next'
"Plug 'tlhr/anderson.vim'
"Plug 'jacoborus/tender.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'vim-scripts/scratch.vim'
"Plug 'vim-scripts/calendar.vim'
if has('nvim')
"  Plug 'Shougo/denite.nvim'
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
endif
"Plug 'Shougo/neco-vim'
"Plug 'neoclide/coc-neco'
"Plug 'ervandew/supertab'
Plug 'fatih/vim-go', { 'tag': '*'}
Plug 'andrewstuart/vim-kubernetes'
Plug 'neomake/neomake'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'dyng/ctrlsf.vim'
Plug 'gabesoft/vim-ags'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'bronson/vim-trailing-whitespace'
Plug 'airblade/vim-gitgutter'
"Plug 'vim-syntastic/syntastic'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'hdima/python-syntax'
Plug 'jelera/vim-javascript-syntax'
Plug 'vim-scripts/Align'
"Plug 'vim-scripts/SQLUtilities'
Plug 'vim-scripts/dbext.vim'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'elzr/vim-json'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'vimwiki/vimwiki'
Plug 'Quramy/tsuquyomi'
"Plug 'leafgarland/typescript-vim'
Plug 'google/vim-searchindex'
"Plug 'artur-shaik/vim-javacomplete2'
"Plug 'junegunn/vim-emoji'
Plug 'hashivim/vim-terraform'
"Plug 'juliosueiras/vim-terraform-snippets'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'cohama/agit.vim'
Plug 'NLKNguyen/papercolor-theme'

call plug#end()
if (has("termguicolors") && has('nvim'))
 set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
let python_highlight_all = 1

set updatetime=1000
set lazyredraw

let did_install_default_menus = 1
set synmaxcol=500

runtime macros/matchit.vim

set pastetoggle=<F11>

set mouse=a
set hidden
set number
set relativenumber
set ruler
" Highlights current line
"set cursorline
set showcmd
set cmdheight=2
syntax on
set foldlevelstart=99
set foldmethod=marker
" Puts a line on column 80 of the screen. This is a good indicator for methods
" that are too long
set colorcolumn=80

set shell=/usr/local/bin/zsh

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

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>nn :NERDTreeToggle<CR>
map <Leader>nf :NERDTreeFind<CR>

" ZoomWin configuration
" map <Leader><Leader> :ZoomWin<CR>


" Remember last location in file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

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
au BufWrite *.{yaml,yml} %!prettier --parser yaml

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

" Unimpaired configuration
" Bubble single lines
nmap <Leader><Up> [e
nmap <Leader><Down> ]e
" Bubble multiple lines
vmap <Leader><Up> [egv
vmap <Leader><Down> ]egv

nmap <Leader><Space> :nohlsearch<CR>
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
set background=light
let base16colorspace=256
"color base16-default
" color kalisi
" color material
" color crayon
"color base16-tomorrow-night
"let g:one_allow_italics = 1
"color one
 "color anderson
"color dracula
"color darcula
"color tender
"color OceanicNext
let g:nord_italic = 1
let g:nord_underline = 1
let g:nord_italic_comments = 1
let g:nord_uniform_diff_background = 1
let g:nord_cursor_line_number_background = 1
"color nord
color papercolor

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

let g:sqlutil_align_comma = 1

" set clipboard="
set clipboard=unnamed

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

"		Airline
" ====================================================================
" Settings
let g:airline_powerline_fonts = 1
"let g:airline_theme='nord'
let g:airline_theme='papercolor'
let g:airline#extensions#wordcount#filetypes = '\vhelp|markdown|rst|org|text|asciidoc|tex|mail|wiki'

"		Spell
" ====================================================================
set spelllang=en_us

"		CtrlP
" ====================================================================
" Settings
let g:ctrlp_extensions = ['tag', 'line']
let g:ctrlp_open_multiple_files = 'h'
" Keybindings
map <Leader>ff :FZF<CR>
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30,results:30'


"		CTags
" ====================================================================
set tags=tags;/
"map <Leader>rt :!/usr/local/bin/ctags --exclude=.git --exclude=public --exclude=.bundle --exclude=doc --exclude=coverage -R<CR><CR>
map <Leader>gt :!.git/hooks/ctags<CR><CR>
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
" let g:tagbar_ctags_bin = "/usr/local/bin/ctags"
let Tlist_WinWidth = 50
map <Leader>tlt :TlistToggle<cr>
map <Leader>tll :TlistSessionLoad
map <Leader>tls :TlistSessionSave
map <Leader>tla :TlistAddFilesRecursive
map <Leader>tlg :TlistSessionLoad .git/taglist<CR>
map <Leader>tb :TagbarToggle<CR>

" Gundo
" ====================================================================
map <Leader>gd :GundoToggle<CR>

"""""""""""""
"  Vimwiki  "
"""""""""""""

" let g:vimwiki_folding='expr'
 let g:vimwiki_hl_cb_checked=1
au FileType vimwiki nnoremap <C-P> :Vimwiki2HTMLBrowse<CR>
"au BufRead,BufNewFile *.wiki call s:setupWrapping()
au FileType vimwiki setlocal spell
let g:vimwiki_list = [
  \ {'path': '~/.vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
autocmd BufWritePost /Users/jesse/.vimwiki/*.md silent execute '! git --git-dir=$HOME/.vimwiki/.git --work-tree=$HOME/.vimwiki add "%" > /dev/null; git --git-dir=$HOME/.vimwiki/.git --work-tree=$HOME/.vimwiki commit -q -m "%" 2>&1 > /dev/null; git --git-dir=$HOME/.vimwiki/.git --work-tree=$HOME/.vimwiki push origin master -q > /dev/null' |
let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':0
          \ , 'ctagsbin':'/Users/jesse/.vimwiki/utils/vwtags.py'
          \ , 'ctagsargs': 'markdown'
          \ }
let g:vimwiki_listsyms = ' ○◐●✓'

" AutoPairs
" ====================================================================
let g:AutoPairsShortcutToggle = '<C-\>'
let g:AutoPairsFlyMode = 1


" Vimux
" ====================================================================
map <Leader>vit :VimuxPromptCommand<CR>
map <Leader>vii :VimuxInspectRunner<CR>
map <Leader>vil :VimuxRunLastCommand<CR>


map <Leader>> :bn<CR>
map <Leader>< :bp<CR>

" Thrift Syntax
" ====================================================================

au BufRead,BufNewFile *.thrift setlocal filetype=thrift

"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"let g:UltiSnipsExpandTrigger = '<C-j>'
"let g:UltiSnipsJumpForwardTrigger = '<C-j>'
"let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
inoremap <expr> <c-j> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

let g:snips_author = 'Jesse Dearing'

""""""""""""
"  Golang  "
""""""""""""
let g:LanguageClient_serverCommands = {
       \ 'go': ['gopls']
       \ }
" Run gofmt and goimports on save
"autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
let $GOPATH = $HOME."/go"
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 0
let g:go_fmt_autosave = 1
"let g:go_auto_sameids = 1
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 1
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_def_mode = "gopls"
let g:go_info_mode = 'gopls'
" Disable because coc.vim handles this
let g:go_def_mapping_enabled = 0

augroup go
  au FileType go nmap <Leader>i <Plug>(go-implements)
	au FileType go nmap <Leader>gd <Plug>(go-doc)
  "au FileType go nmap <leader>r <Plug>(go-rename)
  au FileType go nmap <leader>/ <Plug>(go-referrers)
	au FileType go nmap <leader>t <Plug>(go-test)
	au FileType go nmap <leader>c <Plug>(go-callers)
	au FileType go imap <C-e> <C-o><Plug>(go-iferr)
	au FileType go setlocal foldmethod=syntax
  " It's a spacey world out there, thankfully not in Go
  au FileType go setlocal noexpandtab
augroup END

" NerdCommenter
" ==============================================================================
let g:NERDDefaultAlign = 'left'

" Ale
" ==============================================================================
" let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_delay = 500
let g:ale_linters = { 'go': ['gometalinter'] }
let g:ale_go_gometalinter_options = "--fast"

" Supertab
" ==============================================================================
" let g:SuperTabDefaultCompletionType = 'context'

" Platinum Searcher
" ==============================================================================
if executable('rg')
	"let g:ctrlp_user_command = 'rg --files --no-ignore --follow -g "!{.git,node_modules,vendor}/*"'
	"let g:ctrlp_use_caching = 0
	"let g:ackprg = 'rg --vimgrep -i -g "!{node_modules,vendor}/*"'
	"set grepprg=rg\ --vimgrep\ --no-heading
endif

if executable('ag')
	set grepprg=ag\ --nogroup\ --vimgrep\ --nocolor
	let g:ctrlp_user_command = 'ag %s -l -U --ignore public --ignore .bundle --ignore node_modules --ignore vendor --nocolor -g ""'
endif

nmap     <C-F>f <Plug>CtrlSFPrompt
let g:ctrlsf_ackprg = '/usr/local/bin/ag'

set exrc
set secure

autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"let g:deoplete#file#enable_buffer_path = 1
"autocmd FileType java setlocal omnifunc=javacomplete#Complete

"""""""""""""""
"  Terraform  "
"""""""""""""""
let g:terraform_completion_keys = 1

let g:terraform_fmt_on_save = 1
" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

set rtp+=/usr/local/opt/fzf

let g:ycm_python_binary_path = '/usr/local/opt/python3/bin/python3'
let g:ale_python_mypy_options = '--ignore-missing-imports'

if has('nvim')
  " Deoplete
  " ===========================================================================
  "call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy', 'matcher_length'])
  "let g:deoplete#enable_at_startup = 1
  "call deoplete#custom#option('omni_patterns', { 'java': '[^. *\t]\.\w*' })
  "call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
  ""call deoplete#custom#option('omni_patterns', { 'complete_method': 'omnifunc', 'terraform': '[^ *\t"{=$]\w*' })

  "call deoplete#initialize()


  highlight NeomakeError ctermfg=168 ctermbg=16 guifg=#e06c75 guibg=#282c34
  highlight NeomakeWarning ctermfg=180 guifg=#e5c07b
  let g:neomake_error_sign = {'text': '✖', 'texthl': 'NeomakeError'}
  let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeWarning'}
  call neomake#configure#automake('w')

  let g:neomake_vimwiki_writegood_maker = {
        \ 'exe': 'writegood',
        \ 'args': ['--parse'],
        \ 'errorformat': '%W%f:%l:%c:%m,%C%m,%-G',
        \ 'postprocess': function('neomake#makers#ft#text#PostprocessWritegood')
        \ }
  let g:neomake_vimwiki_enabled_makers = ['writegood']

  " This does in-place updates (as opposed to a split window) when doing
  " search and replace
  set inccommand=nosplit

  let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx'
                \ ]
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

map <silent> <C-h> :call WinMove('h')<cr>
map <silent> <C-j> :call WinMove('j')<cr>
map <silent> <C-k> :call WinMove('k')<cr>
map <silent> <C-l> :call WinMove('l')<cr>

hi illuminatedWord cterm=underline gui=underline

""""""""""
"  JSON  "
""""""""""
au Filetype json setlocal foldmethod=syntax

"""""""""""""
"  Crontab  "
"""""""""""""
au filetype crontab setlocal nobackup nowritebackup

"""""""""""""
"  coc.vim  "
"""""""""""""
inoremap <silent><expr> <c-space> coc#refresh()
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
