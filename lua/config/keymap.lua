require("config.plugins")

local key_map = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
    )
end

-- move to previous position 
key_map('n', '<C-q>', ':Explore<CR>')
key_map('n', '\\', "''")

-- terminal in new Windows
key_map('n', '<C-a>', ':ToggleTerm<CR>')

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
key_map('v', '>', ">`[v`]")
key_map('v', '<', "<`[v`]")

-- The greatest remap of all time (delete without changing buffer)
key_map('n', '<leader>p', "\"_dP")

-- leave insert after copy 
key_map('n', 'c', "c<ESC>")
key_map('n', 'C', "C<ESC>")

function capital(str)
  return (str:gsub("^%l", string.upper))
end
local coms = {'y', 'p', 'c'}
for _, com in ipairs(coms) do
  key_map('n', '<leader>' .. com, '"+' .. com)
  key_map('v', '<leader>' .. com, '"+' .. com)
  key_map('n', '<leader>' .. capital(com), '"+' .. capital(com))
end


-- newline doesn't go into insert mode 
key_map('n', 'o', "o<ESC>")
key_map('n', 'O', "O<ESC>")

-- append lines without moving cursor
key_map('n', 'J', "mzJ`z")

-- semi colon to colon
key_map('n',';', ':')

-- LSP server functions
-- key_map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
-- key_map('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
-- key_map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
-- key_map('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
-- key_map('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
-- key_map('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
-- key_map('n', 'gt', ':lua+vim.lsp.buf.type_definition()<CR>')
key_map('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
key_map('n', '<C-s>', ':lua vim.lsp.buf.signature_help()<CR>')
-- key_map('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
key_map('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
key_map('n', '<leader>e', ':lua vim.diagnostic.open_float()<CR>')

-- Fuzzy searching
key_map('n', '<leader>ff', ':lua require"telescope.builtin".find_files()<CR>')
key_map('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_map('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_map('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')

-- Buffers
key_map('n', '<leader>n', ':bnext<CR>')
key_map('n', '<leader>b', ':buffer <C-z>')

-- Windows
key_map('n', '<C-h>', ':split<CR>')
key_map('n','=',':res +5<CR>')
key_map('n','-',':res -5<CR>')

-- Troubles
key_map('n','<leader>d', ':TroubleToggle<CR>')

-- Harpoon
key_map('n','<leader>ah',":lua require('harpoon.mark').add_file()<CR>")
key_map('n','<leader>h',":lua require('harpoon.ui').toggle_quick_menu()<CR>")

