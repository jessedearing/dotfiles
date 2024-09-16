set completeopt=menu,menuone,noselect
let g:python3_host_prog = $HOME."/.pyenv/shims/python3"

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
set maxmempattern=2000

runtime macros/matchit.vim

set pastetoggle=<F12>
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

set shell=/bin/zsh

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

""""""""""""""
"  DiffView  "
""""""""""""""

map <Leader>dvo :DiffviewOpen<CR>
map <Leader>dvc :DiffviewClose<CR>


" NERDTree Configuration {{{1 "
map <Leader>nn :NvimTreeToggle<CR>
map <Leader>nf :NvimTreeFindFile<CR>

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
au FileType yaml,yml call s:setupYaml()
"au BufWrite *.{yaml,yml} %!prettier --parser yaml

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
"au FileType python  set tabstop=4 textwidth=79
let g:jedi#force_py_version = 3

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

nmap <Leader><Space> :nohlsearch<CR>
au InsertEnter * let @/ = ''
"au BufReadPost quickfix map <C-n> :cn<CR>
"au BufReadPost quickfix map <C-m> :cp<CR>
"au BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
"let g:aldmeris_transparent = 0
" let g:aldmeris_termcolors = "tango"
" color aldmeris
"set background=light
let base16colorspace=256
" color dracula
let g:nord_italic = 1
let g:nord_underline = 1
let g:nord_italic_comments = 1
let g:nord_uniform_diff_background = 1
let g:nord_cursor_line_number_background = 1

" Directories for swp files
set backupdir=~/.config/nvim/backup
set directory=~/.config/nvim/backup

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

let g:sqlutil_align_comma = 1

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

" Spell {{{
set spelllang=en_us
" }}}

" Vimwiki {{{
let g:vimwiki_list = [{
      \ 'path': '~/vimwiki',
      \ 'syntax': 'markdown',
      \ 'ext': '.md' }]
map <Leader>ww :VimwikiIndex<CR>
map <Leader>w<Leader>w :VimwikiMakeDiaryNote<CR>

map <Leader>> :bn<CR>
map <Leader>< :bp<CR>
" }}}

" Golang {{{
autocmd BufWritePre *.go :silent! lua f = require('go.format'); f.gofmt(); f.org_imports()
" Run gofmt and goimports on save
"autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
let $GOPATH = $HOME."/go"
let g:go_fmt_command = "goimports"
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

" }}}

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

let g:neomake_yaml_yamllint_maker = {
      \ 'args': ['-f', 'parsable', '-d', 'relaxed'],
      \ 'errorformat': '%E%f:%l:%c: [error] %m,%W%f:%l:%c: [warning] %m',
      \ }

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

" JSON {{{
au Filetype json setlocal foldmethod=expr
au Filetype json setlocal foldexpr=nvim_treesitter#foldexpr()
" }}} "

" Crontab {{{1 "
au filetype crontab setlocal nobackup nowritebackup
" 1}}} "


" Better Whitesapce {{{1 "
let g:strip_whitespace_on_save = 1
" 1}}} "
