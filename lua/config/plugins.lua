require('config.lualine')
require('config.packer')
require('config.options')
local vim = vim
--
-- {{{ colorschemes

require('rose-pine').setup({
  variant = 'moon',
  bold_vert_split = true,
  groups = {
    background='#191724',
    punctuation = 'text',
  }
})

require("catppuccin").setup({})

vim.cmd('colorscheme catppuccin')

-- }}}

-- {{{ treesitter lsp

require("nvim-treesitter.install").prefer_git = true
local parsers = require("nvim-treesitter.parsers").get_parser_configs()
for _, p in pairs(parsers) do
    p.install_info_url = p.install_info.url:gsub(
        "https://github.com/",
        "git@github.com:"
    )
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"help", "c", "lua", "python", "javascript"},
  sync_install = false,
  highlight = {enable = true,}
}

local lspconfig = require'lspconfig'
local completion = require'completion'

local function custom_on_attach(client)
  print('Attaching to ' .. client.name)
  completion.on_attach(client)
end

local default_config = {
  on_attach = custom_on_attach,
}

-- setup language servers here

local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true,
})
lsp.setup()

lspconfig.pylsp.setup{}
lspconfig.clangd.setup{}
lspconfig.lua_ls.setup{}
lspconfig.denols.setup{}
lspconfig.rust_analyzer.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
    update_in_insert = true,
  }
)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = false
})

-- These are for making pop-up diagnostic windows
-- vim.o.updatetime = 250
-- vim.cmd[[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

--- }}}

-- {{{ troubles
require'trouble'.setup{}
-- }}} 

-- {{{ Indent line setup
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

require("indent_blankline").setup {
  space_char_blankline = " ",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
  show_current_context_start = true,
  show_current_context = true,
}
--- }}}

-- {{{ filetree setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
-- }}}

--- {{{ completion

local has_words_before = function ()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line -1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Set up nvim-cmp.
local cmp = require'cmp'
local luasnip = require'luasnip'
local lspkind = require'lspkind'

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  view = {
    entries = {name = 'custom', selection_order = 'near_cursor'}
  },

  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = '...',
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = {

     ["<CR>"] = cmp.mapping({
       i = function(fallback)
         if cmp.visible() and cmp.get_active_entry() then
           cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
         else
           fallback()
         end
       end,
       s = cmp.mapping.confirm({ select = true }),
       c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
     }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
      -- they way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {'i', 's', 'c'}),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's', 'c'}),

    ["<Up>"] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's', 'c'}),

    ["<Down>"] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's', 'c'}),

    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-a>'] = cmp.mapping.confirm({ select = true }),
    ['<C-q>'] = cmp.mapping.abort(),

  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
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

-- Enable `buffer` and `buffer-lines` for `/` and `?` in the command-line
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    completion = {autocomplete = false},
    view = {
      entries = {name = 'wildmenu', seperator = '|'}
    },
    sources = {
        {
            name = "buffer",
        },
        { name = "buffer-lines" }
    }
})
--
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  completion = {autocomplete = false},
  view = {
    entries = {name = 'wildmenu', seperator = '|'}
  },
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline',}
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pylsp'].setup {
  capabilities = capabilities
}
require('lspconfig')['clangd'].setup {
  capabilities = capabilities
}
require('lspconfig')['lua_ls'].setup {
  capabilities = capabilities
}
require('lspconfig')['denols'].setup {
  capabilities = capabilities
}

-- }}} 

require("harpoon").setup({
  menu = {
    width = vim.api.nvim_win_get_width(0) - 4,
  }
})
