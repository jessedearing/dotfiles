" Plugins {{{1 "
call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tarekbecker/vim-yaml-formatter'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'RRethy/vim-illuminate'
Plug 'Mofiqul/dracula.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'vim-scripts/scratch.vim'
"Plug 'fatih/vim-go', { 'tag': '*'}
Plug 'ray-x/go.nvim', { 'dir': '~/Documents/code/go.nvim'}
Plug 'andrewstuart/vim-kubernetes'
Plug 'neomake/neomake'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'masukomi/vim-markdown-folding'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'hdima/python-syntax'
Plug 'jelera/vim-javascript-syntax'
Plug 'junegunn/vim-easy-align'
Plug 'vim-scripts/dbext.vim'
Plug 'godlygeek/tabular'
Plug 'liuchengxu/vista.vim'
"Plug 'elzr/vim-json'
Plug 'vimwiki/vimwiki'
Plug 'Quramy/tsuquyomi'
Plug 'google/vim-searchindex'
Plug 'hashivim/vim-terraform'
Plug 'cohama/agit.vim'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'tpope/vim-eunuch'
Plug 'tools-life/taskwiki'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'neovim/nvim-lspconfig'
Plug 'L3MON4D3/LuaSnip'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'windwp/nvim-autopairs'
Plug 'sindrets/diffview.nvim'
call plug#end()
" 1}}} "
set completeopt=menu,menuone,noselect

lua << END
require('go').setup({
  goimport = "gopls", -- if set to 'gopls' will use gopls format, also goimport
  fillstruct = "gopls",
  gofmt = "gopls", -- if set to gopls will use gopls format
})
require'lualine'.setup{}
require'gitsigns'.setup{}
require'nvim-tree'.setup{}

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' }, -- For ultisnips users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-/>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

vim.api.nvim_set_keymap('i', '<c-e>','<cmd>lua require("go.iferr").run()<CR>', { silent=true, noremap=true})
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls', 'terraformls', 'pylsp' }
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
    capabilities = capabilities
  }
end
lspconfig['yamlls'].setup {
  on_attach = on_attach,
  flags = {
  },
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = {
        kubernetes = {"kubectl-edit-*.yaml", "*-k8s.yaml"},
      },
    },
  },
}

-- vim.lsp.set_log_level('debug')

local cb = require'diffview.config'.diffview_callback

require'diffview'.setup {
  diff_binaries = false,    -- Show diffs for binaries
  enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
  use_icons = true,         -- Requires nvim-web-devicons
  icons = {                 -- Only applies when use_icons is true.
    folder_closed = "",
    folder_open = "",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
  },
  file_panel = {
    win_config = {
      position = "left",                  -- One of 'left', 'right', 'top', 'bottom'
      width = 35,                         -- Only applies when position is 'left' or 'right'
      height = 10,                        -- Only applies when position is 'top' or 'bottom'
    },
    listing_style = "tree",             -- One of 'list' or 'tree'
    tree_options = {                    -- Only applies when listing_style is 'tree'
      flatten_dirs = true,              -- Flatten dirs that only contain one single dir
      folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
    },
  },
  file_history_panel = {
    win_config = {
      position = "bottom",
      width = 35,
      height = 16,
    },
    log_options = {
      single_file = {
        max_count = 256,      -- Limit the number of commits
        follow = false,       -- Follow renames (only for single file)
        all = false,          -- Include all refs under 'refs/' including HEAD
        merges = false,       -- List only merge commits
        no_merges = false,    -- List no merge commits
        reverse = false,      -- List commits in reverse order
      },
    },
  },
  default_args = {    -- Default args prepended to the arg-list for the listed commands
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  hooks = {},         -- See ':h diffview-config-hooks'
  key_bindings = {
    disable_defaults = false,                   -- Disable the default key bindings
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"]      = cb("select_next_entry"),  -- Open the diff for the next file
      ["<s-tab>"]    = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["gf"]         = cb("goto_file"),          -- Open the file in a new split in previous tabpage
      ["<C-w><C-f>"] = cb("goto_file_split"),    -- Open the file in a new split
      ["<C-w>gf"]    = cb("goto_file_tab"),      -- Open the file in a new tabpage
      ["<leader>e"]  = cb("focus_files"),        -- Bring focus to the files panel
      ["<leader>b"]  = cb("toggle_files"),       -- Toggle the files panel.
    },
    file_panel = {
      ["j"]             = cb("next_entry"),           -- Bring the cursor to the next file entry
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),           -- Bring the cursor to the previous file entry.
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),         -- Open the diff for the selected entry.
      ["o"]             = cb("select_entry"),
      ["<2-LeftMouse>"] = cb("select_entry"),
      ["-"]             = cb("toggle_stage_entry"),   -- Stage / unstage the selected entry.
      ["S"]             = cb("stage_all"),            -- Stage all entries.
      ["U"]             = cb("unstage_all"),          -- Unstage all entries.
      ["X"]             = cb("restore_entry"),        -- Restore entry to the state on the left side.
      ["R"]             = cb("refresh_files"),        -- Update stats and entries in the file list.
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["gf"]            = cb("goto_file"),
      ["<C-w><C-f>"]    = cb("goto_file_split"),
      ["<C-w>gf"]       = cb("goto_file_tab"),
      ["i"]             = cb("listing_style"),        -- Toggle between 'list' and 'tree' views
      ["f"]             = cb("toggle_flatten_dirs"),  -- Flatten empty subdirectories in tree listing style.
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>b"]     = cb("toggle_files"),
    },
    file_history_panel = {
      ["g!"]            = cb("options"),            -- Open the option panel
      ["<C-A-d>"]       = cb("open_in_diffview"),   -- Open the entry under the cursor in a diffview
      ["y"]             = cb("copy_hash"),          -- Copy the commit hash of the entry under the cursor
      ["zR"]            = cb("open_all_folds"),
      ["zM"]            = cb("close_all_folds"),
      ["j"]             = cb("next_entry"),
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),
      ["o"]             = cb("select_entry"),
      ["<2-LeftMouse>"] = cb("select_entry"),
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["gf"]            = cb("goto_file"),
      ["<C-w><C-f>"]    = cb("goto_file_split"),
      ["<C-w>gf"]       = cb("goto_file_tab"),
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>b"]     = cb("toggle_files"),
    },
    option_panel = {
      ["<tab>"] = cb("select"),
      ["q"]     = cb("close"),
    },
  },
}

require('nvim-autopairs').setup{}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "lua",
    "json",
    "yaml",
    "go",
    },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = { },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

END

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
let vim_markdown_preview_toggle=1
let vim_markdown_preview_github=1
let vim_markdown_preview_browser='Chromium'

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
color dracula
let g:nord_italic = 1
let g:nord_underline = 1
let g:nord_italic_comments = 1
let g:nord_uniform_diff_background = 1
let g:nord_cursor_line_number_background = 1

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

let g:clipboard = {
		\   'name': 'myClipboard',
		\   'copy': {
		\      '+': ['tmux', 'load-buffer', '-w', '-'],
		\      '*': ['tmux', 'load-buffer', '-w', '-'],
		\    },
		\   'paste': {
		\      '+': ['tmux', 'save-buffer', '-'],
		\      '*': ['tmux', 'save-buffer', '-'],
		\   },
		\   'cache_enabled': 1,
		\ }

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
au FileType vimwiki :DisableWhitespace
let g:vimwiki_list = [{
  \ 'syntax': 'markdown',
  \ 'ext': '.md',
  \ 'automatic_nested_syntaxes':1,
  \ 'path': '$HOME/.vimwiki',
  \ 'template_path': '$HOME/.vimwiki/templates/',
  \ 'template_default':'markdown',
  \ 'template_ext':'.html'
  \ }]
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

" JSON {{{1 "
au Filetype json setlocal foldmethod=expr
au Filetype json setlocal foldexpr=nvim_treesitter#foldexpr()
" 1}}} "

" Crontab {{{1 "
au filetype crontab setlocal nobackup nowritebackup
" 1}}} "


" Better Whitesapce {{{1 "
let g:strip_whitespace_on_save = 1
" 1}}} "

" Vista {{{ "
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
" }}} Vista "
