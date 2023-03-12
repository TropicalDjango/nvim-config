require("config.options")

-- {{{ Packer init
local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn

-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone git@github.com:wbthomason/packer.nvim.git '..install_path)
  execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})
-- }}}

-- {{{ Packer Startup
--- startup and add configure plugins
packer.startup(function()
  local use = use
  use 'github@github.com:nvim-treesitter/nvim-treesitter.git'
  use 'github@github.com:sheerun/vim-polyglot.git'
  -- themes
  use ({'github@github.com:rose-pine/neovim.git', as = 'rose-pine'})
  -- sneaking some formatting in here too
  use 'github@github.com:neovim/nvim-lspconfig.git'
  use 'github@github.com:nvim-lua/completion-nvim.git'
  use 'github@github.com:anott03/nvim-lspinstall.git'

  -- Fuzzy searching
  use 'github@github.com:nvim-lua/popup.nvim.git'
  use 'github@github.com:nvim-lua/plenary.nvim.git'
  use 'github@github.com:nvim-lua/telescope.nvim.git'
  use 'github@github.com:jremmen/vim-ripgrep.git'

  
  -- Indent lines
  use "github@github.com:lukas-reineke/indent-blankline.nvim.git"

  -- Status line
  use {
    'github@github.com:nvim-lualine/lualine.nvim.git',
    requires = {
      'github@github.com:kyazdani42/nvim-web-devicons.git',
      opt = true
    },
    sort_by = "case_sensitive",
    filters = {
      dotfiles = true
      }
  }

  -- File Tree
  use {'github@github.com:nvim-tree/nvim-tree.lua.git',requires = {'github@github.com:nvim-tree/nvim-web-devicons.git',},tag='nightly'}

  -- LSP
  use {
    'github@github.com:VonHeikemen/lsp-zero.nvim.git',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'github@github.com:neovim/nvim-lspconfig.git'},
      {'github@github.com:williamboman/mason.nvim.git'},
      {'github@github.com:williamboman/mason-lspconfig.nvim.git'},
      --Autocompletion
      {'github@github.com:hrsh7th/nvim-cmp.git'},
      {'github@github.com:hrsh7th/cmp-buffer.git'},
      {'github@github.com:hrsh7th/cmp-path.git'},
      {'github@github.com:hrsh7th/cmp-cmdline.git'},
      {'github@github.com:saadparwaiz1/cmp_luasnip.git'},
      {'github@github.com:hrsh7th/cmp-nvim-lsp.git'},
      {'github@github.com:hrsh7th/cmp-nvim-lua.git'},
      {'github@github.com:onsnails/lspkind.nvim.git'},
      --Snippets
      {'github@github.com:L3MON4D3/LuaSnip.git'},
      {'github@github.com:rafamadriz/friendly-snippets.git'},
    }
  }
  use 'github@github.com:plasticboy/vim-markdown.git'
end
)
--- }}}
