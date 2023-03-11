require("config.plugins")

local key_map = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

-- leave insert/visual mode
key_map('v','jj', '<ESC>')

-- search centers cursor
key_map('n', 'n', "nzzzv")
key_map('n', 'N', "Nzzzv")

-- movement centers cursor
key_map('n', '{', "{zz")
key_map('n', '}', "}zz")
key_map('n', '<C-d>', "<C-d>zz")
key_map('n', '<C-u>', "<C-u>zz")

-- move block of text with auto indenting
key_map('v', 'J', ":m '>+1<CR>gv=gv")
key_map('v', 'K', ":m '<-2<CR>gv=gv")

-- The greatest remap of all time (delete without changing buffer)
key_map('n', '<leader>p', "\"_dP")

-- leave insert after copy 
key_map('n', 'c', "c<ESC>")
key_map('n', 'C', "C<ESC>")

-- open new project 
key_map('n', '<C-f>', "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- copy into SYSTEM clipboard
key_map('n', '<leader>y', "\"+y")
key_map('v', '<leader>y', "\"+y")
key_map('n', '<leader>Y', "\"+Y")

-- newline doesn't go into insert mode 
key_map('n', 'o', "o<ESC>")
key_map('n', 'O', "O<ESC>")

-- append lines without moving cursor
key_map('n', 'J', "mzJ`z")

-- semi colon to colon
key_map('n',';', ':')

-- LSP server functions
key_map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
key_map('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
key_map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
key_map('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
key_map('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
key_map('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
key_map('n', 'gt', ':lua+vim.lsp.buf.type_definition()<CR>')
key_map('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
key_map('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>')
key_map('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
key_map('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')

-- Fuzzy searching
key_map('n', '<leader>ff', ':lua require"telescope.builtin".find_files()<CR>')
key_map('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_map('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_map('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')

-- File Tree
key_map('n', '<leader>tt', ':NvimTreeToggle<CR>')
key_map('n', '<leader>tc',':NvimTreeCollapse<CR>')
key_map('n', '<leader>tf', ':NvimTreeFindFileToggle<CR>')

-- Tabs
key_map('n', '<leader>tn', ':tabnext<CR>')
key_map('n', '<leader>tN', ':tabnew<CR>')

-- Buffers
key_map('n', '<leader>', ':vsplit<CR>')
key_map('n', '<leader>', ':split<CR>')

-- Windows
key_map('n', '<leader>v', ':vsplit<CR>')
key_map('n', '<leader>h', ':split<CR>')

-- Folding
key_map('n', '<leader>m', ':fold<CR>f}i<CR><CR><ESC>kdwdwk$')
key_map('n', '<leader>mc', 'i-- }}} <ESC>')
key_map('n', '<leader>mo', 'i-- {{{ <ESC>')

