vim.g.mapleader = ','
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
vim.opt.rtp:append('/opt/homebrew/opt/fzf')

require("lazy").setup({
  'folke/neoconf.nvim',
  'folke/neodev.nvim',
  {'vimwiki/vimwiki',
    init = function()
      local vimwiki_path = os.getenv("HOME") .. '/Google Drive/My Drive/vimwiki'
      if vim.loop.fs_stat(os.getenv("HOME") .. "/Nextcloud") then
        vimwiki_path = os.getenv("HOME") .. "/Nextcloud/Notes"
      end
      vim.g.vimwiki_list = {
        {
          path = vimwiki_path,
          ext = '.md',
          syntax = 'markdown',
        },
      }
    end
  },
  {'shaunsingh/nord.nvim'},
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  'pedrohdz/vim-yaml-folds',
  'RRethy/vim-illuminate',
  'Mofiqul/dracula.nvim',
  'ryanoasis/vim-devicons',
  'nvim-lualine/lualine.nvim',
  'nvim-lua/plenary.nvim',
  'lewis6991/gitsigns.nvim',
  'kyazdani42/nvim-web-devicons',
  'tpope/vim-fugitive',
  'kyazdani42/nvim-tree.lua',
  'vim-scripts/scratch.vim',
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  'neomake/neomake',
  'honza/vim-snippets',
  'masukomi/vim-markdown-folding',
  {'junegunn/fzf.vim', dependencies = {
      {'junegunn/fzf', dir = '/opt/homebrew/opt/fzf', build = './install --all'},
    },
  },
  'ntpeters/vim-better-whitespace',
  'mattn/gist-vim',
  'mattn/webapi-vim',
  'hdima/python-syntax',
  'jelera/vim-javascript-syntax',
  'junegunn/vim-easy-align',
  'godlygeek/tabular',
  'liuchengxu/vista.vim',
  'google/vim-searchindex',
  'hashivim/vim-terraform',
  'cohama/agit.vim',
  'kristijanhusak/vim-carbon-now-sh',
  'tpope/vim-eunuch',
  'neovim/nvim-lspconfig',
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  },
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'saadparwaiz1/cmp_luasnip',
  'sindrets/diffview.nvim',
  'DerSaidin/vim-urlencode',
  'Apeiros-46B/qalc.nvim',
  { 'echasnovski/mini.nvim', version = '*' },
  { "lukas-reineke/indent-blankline.nvim" },
  {'mrcjkb/rustaceanvim', version = "4.*" },
  'github/copilot.vim',
  {'towolf/vim-helm',
    ft = { 'helm' },
    event = { "BufReadPre", "BufNewFile", "BufEnter" },
  },
  {
    'kevinhwang91/nvim-fundo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    build = function()
      require('fundo').install()
    end,
  },
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = "*.md",
  callback = function()
    vim.keymap.set('i', '<M-Tab>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, buffer = true})
  end,
})
require("neodev").setup({
    override = function(_, library)
        library.enabled = true
        library.plugins = true
    end,
})
require("neoconf").setup({})

vim.opt.rtp:prepend(lazypath)
if vim.loop.fs_stat(os.getenv("HOME") .. "/.config/nvim/undo") == nil then
  vim.loop.fs_mkdir(os.getenv("HOME") .. "/.config/nvim/undo", 493)
end
vim.o.undodir = os.getenv("HOME") .. "/.config/nvim/undo"
vim.o.undofile = true
require('fundo').setup()

require('go').setup({
  goimports = "gopls", -- if set to 'gopls' will use gopls format, also goimport
  fillstruct = "gopls",
  gofmt = "gopls", -- if set to gopls will use gopls format
  iferr_vertical_shift = 3,
})
require'lualine'.setup{}
require'gitsigns'.setup{}
require'nvim-tree'.setup{}

require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
-- Setup nvim-cmp.
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require'cmp'
vim.keymap.set({"i", "s"}, "<C-L>", function() luasnip.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() luasnip.jump(-1) end, {silent = true})

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
    { name = 'luasnip' }, -- For luasnip users.
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
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = "*.go",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'i', '<c-e>', '<cmd>lua require("go.iferr").run()<CR>', {silent=true, noremap=true})
  end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format()
  end,
})
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls', 'terraformls', 'tflint', 'pyright', 'tsserver', 'lua_ls'}
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')

lspconfig.helm_ls.setup {}

lspconfig.java_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {'/Users/jessed/Documents/code/java-language-server/dist/lang_server_mac.sh'},
}

lspconfig.yamlls.setup {
  on_attach = on_attach,
  flags = {
  },
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = {
        kubernetes = {"kubectl-edit-*.yaml", "*-k8s.yaml", "deployment.yaml", "*cronjob*.yaml"},
        ["https://golangci-lint.run/jsonschema/golangci.jsonschema.json"] = ".golangci.yaml",
      },
    },
  },
}

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end


vim.g.rustaceanvim = {
  server = {
    on_attach = on_attach
  }
}

-- vim.lsp.set_log_level('debug')

require('diffview').setup({})

require'nvim-treesitter.configs'.setup({
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
})

require('mini.comment').setup({})
require('mini.splitjoin').setup()
require('mini.align').setup()
require('mini.pairs').setup()
require('mini.surround').setup()

vim.cmd.colorscheme "nord"

vim.cmd.source "~/.config/nvim/nvim.vim"

if vim.g.neovide then
  vim.o.guifont = "CaskaydiaCove Nerd Font:h16"
  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_cursor_trail_length = 0.5
  vim.defer_fn(function()
    vim.cmd("NeovideFocus")
  end, 7)
end

if vim.g.gui_vimr then
  vim.o.guifont = "CaskaydiaCove Nerd Font:h16"
end
