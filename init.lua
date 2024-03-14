vim.opt.number = true

vim.opt.syntax = 'on'

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.g.mapleader = ' '
vim.cmd.set "timeout timeoutlen=3000 ttimeoutlen=100"

vim.opt.wrap = false

local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('neoclide/coc.nvim', {branch = 'release'})
Plug 'prisma/vim-prisma'
Plug 'leafOfTree/vim-svelte-plugin'
Plug 'nathom/filetype.nvim'
Plug('daltonmenezes/aura-theme', { rtp = 'packages/neovim' })
Plug 'goolord/alpha-nvim'
Plug 'elkowar/yuck.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'L3MON4D3/LuaSnip'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mrcjkb/rustaceanvim'

vim.call('plug#end')

vim.cmd.colorscheme('aura-dark')

vim.g.did_load_filetypes = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

keyset("n", "<leader>do", "<Plug>(coc-codeaction)")

keyset("n", "<leader>e", ":NvimTreeToggle")

require('filetype').setup({
  overrides = {
     extensions = {
      c = 'c',
      h = 'c'
     },
     complex = {
       ["hyprland.conf"] = 'hyprlang'
     }
  }
})

require('alpha').setup(require('alpha.themes.startify').config)

require('lualine').setup {
  sections = {
    lualine_x = {'filetype'}
  }
}

require("nvim-autopairs").setup {}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = {'typescriptreact'},
  },
}

require("nvim-tree").setup()

local builtin = require('telescope.builtin')
keyset('n', '<leader>ff', builtin.find_files, {})
keyset('n', '<leader>fg', builtin.live_grep, {})
keyset('n', '<leader>fb', builtin.buffers, {})
keyset('n', '<leader>fh', builtin.help_tags, {})
keyset('n', '<leader>fj', builtin.oldfiles)
