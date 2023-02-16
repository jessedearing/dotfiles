local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
{'catppuccin/nvim',  name = 'catppuccin' },
{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
'tarekbecker/vim-yaml-formatter',
'pedrohdz/vim-yaml-folds',
'RRethy/vim-illuminate',
'Mofiqul/dracula.nvim',
'ryanoasis/vim-devicons',
'nvim-lualine/lualine.nvim',
'nvim-lua/plenary.nvim',
'lewis6991/gitsigns.nvim',
'kyazdani42/nvim-web-devicons',
'tpope/vim-fugitive',
'scrooloose/nerdcommenter',
'kyazdani42/nvim-tree.lua',
'vim-scripts/scratch.vim',
'jessedearing/go.nvim',
'andrewstuart/vim-kubernetes',
'neomake/neomake',
'SirVer/ultisnips',
'honza/vim-snippets',
'masukomi/vim-markdown-folding',
{'junegunn/fzf.vim', dependencies = {
    {'junegunn/fzf', dir = '~/.fzf', build = './install --all'},
  },
},
'ntpeters/vim-better-whitespace',
'mattn/gist-vim',
'mattn/webapi-vim',
'hdima/python-syntax',
'jelera/vim-javascript-syntax',
'junegunn/vim-easy-align',
'vim-scripts/dbext.vim',
'godlygeek/tabular',
'liuchengxu/vista.vim',
'vimwiki/vimwiki',
'Quramy/tsuquyomi',
'google/vim-searchindex',
'hashivim/vim-terraform',
'cohama/agit.vim',
'kristijanhusak/vim-carbon-now-sh',
'tpope/vim-eunuch',
'tools-life/taskwiki',
'powerman/vim-plugin-AnsiEsc',
'neovim/nvim-lspconfig',
'L3MON4D3/LuaSnip',
'quangnguyen30192/cmp-nvim-ultisnips',
'hrsh7th/nvim-cmp',
'hrsh7th/cmp-nvim-lsp',
'hrsh7th/cmp-buffer',
'hrsh7th/cmp-path',
'hrsh7th/cmp-cmdline',
'hrsh7th/nvim-cmp',
'windwp/nvim-autopairs',
'sindrets/diffview.nvim',
'towolf/vim-helm',
})

vim.opt.rtp:prepend(lazypath)
require('catppuccin').setup()

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
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
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

local on_attach_yaml = function(client, bufnr)
  on_attach(client, bufnr)
  if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
    vim.diagnostic.disable()
  end
end

lspconfig['yamlls'].setup {
  on_attach = on_attach_yaml,
  flags = {
  },
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = {
        kubernetes = {"kubectl-edit-*.yaml", "*-k8s.yaml", "deployment.yaml"},
      },
    },
  },
}

-- vim.lsp.set_log_level('debug')

require('diffview').setup({})

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

vim.cmd.colorscheme "catppuccin"

vim.cmd.source "~/.config/nvim/nvim.vim"
