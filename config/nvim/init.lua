vim.g.mapleader = ','
-- Lazy Dependencies {{{
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
  {'vimwiki/vimwiki',
    init = function()
      local vimwiki_path = os.getenv("HOME") .. '/Google Drive/My Drive/vimwiki'
      vim.g.vimwiki_list = {
        {
          path = vimwiki_path,
          ext = '.md',
          syntax = 'markdown',
        },
      }
    end,
    config = function()
      vim.treesitter.language.register('markdown', 'vimwiki')
    end,
  },
  {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
  },
  'folke/tokyonight.nvim',
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
    build = function()
      require("go.install").update_all_sync()
    end,
    config = function()
      require('go').setup({
        goimports = "gopls", -- if set to 'gopls' will use gopls format, also goimport
        fillstruct = "gopls",
        gofmt = "gopls", -- if set to gopls will use gopls format
        iferr_vertical_shift = 3,
      })
    end,
  },
  'neomake/neomake',
  'honza/vim-snippets',
  {
    'MeanderingProgrammer/markdown.nvim',
    dependencies = {'nvim-treesitter/nvim-treesitter', 'echanoviski/mini.nvim'},
    config = function()
      require('render-markdown').setup({
        file_types = { 'markdown', 'vimwiki' },
      })
    end,
  },
  {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({})
  end},
  'ntpeters/vim-better-whitespace',
  'hdima/python-syntax',
  'jelera/vim-javascript-syntax',
  'junegunn/vim-easy-align',
  'godlygeek/tabular',
  'google/vim-searchindex',
  'hashivim/vim-terraform',
  'cohama/agit.vim',
  'kristijanhusak/vim-carbon-now-sh',
  'neovim/nvim-lspconfig',
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      'echasnovski/mini.nvim',
    },
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
  {
      "petertriho/cmp-git",
      dependencies = { 'hrsh7th/nvim-cmp' },
      opts = {},
      init = function()
          table.insert(require("cmp").get_config().sources, { name = "git" })
      end,
   },
   {
     "digitaltoad/vim-pug",
     lazy = true,
     ft = { "pug" },
   },
   {
     'klen/nvim-config-local',
     config = function()
       require('config-local').setup()
     end,
   }
})
-- }}}

-- GitHub Copilot {{{
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = "*.md",
  callback = function()
    vim.keymap.set('i', '<M-Tab>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, buffer = true})
  end,
})
-- }}}

vim.opt.rtp:prepend(lazypath)
if vim.loop.fs_stat(os.getenv("HOME") .. "/.config/nvim/undo") == nil then
  vim.loop.fs_mkdir(os.getenv("HOME") .. "/.config/nvim/undo", 493)
end
vim.o.undodir = os.getenv("HOME") .. "/.config/nvim/undo"
vim.o.undofile = true
require('fundo').setup()


-- Lualine {{{
require'lualine'.setup{
  options = {
    theme = 'tokyonight',
    section_separators = {
      left = '▓▒░',
      right = '░▒▓',
    },
    component_separators = {
      left = '',
      right = '',
    },
  },
}
-- }}}

require'gitsigns'.setup{}
require'nvim-tree'.setup{}

-- LuaSnip {{{
require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})

local luasnip = require("luasnip")
local cmp = require('cmp')

vim.keymap.set({"i", "s"}, "<C-L>", function() luasnip.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() luasnip.jump(-1) end, {silent = true})

-- }}}

-- cmp Setup {{{
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
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
    { name = 'buffer' },
    { name = 'path' },
    { name = 'git' },
  })
})

require("cmp_git").setup({
  filetypes = { "gitcommit", "octo", "NeogitCommitMessage", "vimwiki" },
})

-- }}}

-- LSP keybindings {{{
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
on_attach = function(client, bufnr)
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

-- }}}
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- LSP Servers {{{
local servers = { 'gopls', 'terraformls', 'tflint', 'pyright', 'lua_ls', 'eslint'}
lsp_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  capabilities = lsp_capabilities,
  cmd = {"typescript-language-server", "--stdio"}
}

lspconfig.helm_ls.setup {}

lspconfig.java_language_server.setup {
  on_attach = on_attach,
  capabilities = lsp_capabilities,
  cmd = {'/Users/jessed/Documents/code/java-language-server/dist/lang_server_mac.sh'},
}

lspconfig.yamlls.setup {
  on_attach = on_attach,
  flags = {
  },
  capabilities = lsp_capabilities,
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
    capabilities = lsp_capabilities,
  }
end


vim.g.rustaceanvim = {
  server = {
    on_attach = on_attach
  }
}

-- }}}
-- vim.lsp.set_log_level('debug')

-- Diffview {{{
require('diffview').setup({})
-- }}}

-- Treesitter {{{
require'nvim-treesitter.configs'.setup({
  -- A list of parser names, or "all"
  ensure_installed = 'all',

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

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

-- }}}

-- Mini {{{
require('mini.comment').setup({})
require('mini.splitjoin').setup()
require('mini.align').setup()
require('mini.pairs').setup()
require('mini.surround').setup()
--- }}}

vim.cmd.colorscheme "tokyonight-moon"

vim.cmd.source "~/.config/nvim/nvim.vim"

-- GUI Specific Settings {{{
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

-- }}}

-- FZF Lua {{{

local fzflua = require('fzf-lua')
vim.keymap.set('n', '<leader>ff', fzflua.files, {desc = "FZF Files"})
vim.keymap.set('n', '<leader>fb', fzflua.buffers, {desc = "FZF Buffers"})
vim.keymap.set('n', '<leader>ll', fzflua.loclist, {desc = "Location List"})
vim.keymap.set('n', '<leader>fj', fzflua.jumps, {desc = "Jumps"})
vim.keymap.set('n', '\\', fzflua.grep, {desc = "Grep"})
vim.keymap.set('v' , '<leader>fg', fzflua.grep_visual, {desc = "Grep Visual"})

-- }}}

vim.g.snips_author = "Jesse Dearing"

-- vim: foldenable
