vim.opt.number = true

vim.opt.syntax = 'on'

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.wrap = false

local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('neoclide/coc.nvim', {branch = 'release'})
Plug 'jonathanfilip/vim-lucius'
Plug 'prisma/vim-prisma'
Plug 'leafOfTree/vim-svelte-plugin'
Plug 'nathom/filetype.nvim'

vim.call('plug#end')

vim.cmd.colorscheme('lucius')
vim.cmd('LuciusBlack')

vim.g.did_load_filetypes = 1

-- Code snippet from https://github.com/neoclide/coc.nvim#example-lua-configuration

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local keyset = vim.keymap.set
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- End code snippet

require('filetype').setup({
  overrides = {
     literal = {
        config = "jsonc"
     }
  }
})
