require("config.options")

-- {{{ Packer init
local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn

-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim.git '..install_path)
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
packer.startup({
 function(use)
  use 'nvim-treesitter/nvim-treesitter'
  use 'sheerun/vim-polyglot'

  -- themes
  use {'catppuccin/nvim', as = 'catppuccin'}

  -- sneaking some formatting in here too
  use 'neovim/nvim-lspconfig'

  -- Autocompletion
  use 'nvim-lua/completion-nvim'

  use 'anott03/nvim-lspinstall'

  -- Fuzzy searching
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/telescope.nvim'
  use 'jremmen/vim-ripgrep'

  -- Indent lines
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require('ibl').setup({
          exclude = {
            buftypes = { 'terminal' },
            filetypes = { 'dashboard', 'NvimTree', 'packer', 'lsp-installer'}
          },
          scope = {
            show_end = true
          }
        })
      end
  }

  -- Buffer lines (tabs window)
  use {
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = "nvim-tree/nvim-web-devicons"
  }

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'nvim-tree/nvim-web-devicons',
      opt = true
    },
    sort_by = "case_sensitive",
    filters = {
      dotfiles = true
      }
  }

  -- File Tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  }

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      --Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-cmdline'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},
      {'onsails/lspkind.nvim'},
      --Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

-- install without yarn or npm
use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
})

  -- Debug Window
  use {'folke/trouble.nvim', requires = "nvim-tree/nvim-web-devicons"}

  -- Harpoon
  use {'ThePrimeagen/harpoon'}

  -- terminal plugin
  use {"akinsho/toggleterm.nvim"}

end,
config = {
    git = {
        default_url_format = "github@.com:%s",
    },
},
})
--- }}}
