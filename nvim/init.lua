vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.syntax = 'on'

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = ' '
vim.cmd.set "timeout timeoutlen=3000 ttimeoutlen=100"

vim.g.vimtex_view_method = 'zathura'

vim.opt.wrap = false

local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('neoclide/coc.nvim', { branch = 'release' })
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
Plug('catppuccin/nvim', { as = 'catppuccin' })
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'laktak/tome'
Plug 'scottmckendry/cyberdream.nvim'
Plug 'sbdchd/neoformat'
Plug 'lervag/vimtex'
Plug 'sakhnik/nvim-gdb'
Plug 'OXY2DEV/markview.nvim'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'yuttie/comfortable-motion.vim'
Plug 'mrloop/telescope-git-branch.nvim'
Plug 'tris203/precognition.nvim'
Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'vague2k/vague.nvim'

vim.call('plug#end')

require "catppuccin".setup {
  color_overrides = {
    all = {
      base = "#000000",
      mantle = "#000000",
      crust = "#000000",
    },
  },
}

vim.cmd.colorscheme('vague')

vim.g.did_load_filetypes = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Code snippet from https://github.com/neoclide/coc.nvim#example-lua-configuration

vim.opt.signcolumn = "yes"

function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local keyset = vim.keymap.set
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })

keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
  'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
  'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

function _G.show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end

keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })

vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
  group = "CocGroup",
  command = "silent call CocActionAsync('highlight')",
  desc = "Highlight symbol under cursor on CursorHold"
})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

-- End code snippet

keyset("n", "<leader>do", "<Plug>(coc-codeaction)")

keyset("n", "<leader>tf", ":NvimTreeToggle<CR>")
keyset("n", "<leader>e", ":NvimTreeFocus<CR>")

require('filetype').setup({
  overrides = {
    extensions = {
      c = 'c',
      h = 'c',
      sh = 'bash',
      html = 'html',
      tex = 'tex'
    },
    complex = {
      ["hyprland.conf"] = 'hyprlang'
    }
  }
})

require('alpha').setup(require('alpha.themes.startify').config)

require('lualine').setup {
  sections = {
    lualine_x = { 'filetype' }
  }
}

require("nvim-autopairs").setup {}

require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'typescriptreact' },
  },
}

require "nvim-tree".setup {
  view = {
    number = true,
    relativenumber = true,
    float = {
      enable = true,
      open_win_config = {
        width = 80,
        row = 2
      }
    },
    signcolumn = "yes"
  },
  renderer = {
    group_empty = true,
    highlight_opened_files = "all",
    icons = {
      git_placement = "signcolumn"
    }
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true
  }
}

local builtin = require('telescope.builtin')
keyset('n', '<leader>ff', builtin.find_files, {})
keyset('n', '<leader>fg', builtin.live_grep, {})
keyset('n', '<leader>fb', builtin.buffers, {})
keyset('n', '<leader>fh', builtin.help_tags, {})
keyset('n', '<leader>fj', builtin.oldfiles)
keyset({ 'n', 'v' }, '<leader>gf', function()
  require('git_branch').files()
end)

require('telescope').load_extension('git_branch')

local precognition = require("precognition")

precognition.setup {
  highlightColor = { link = "Comment" },
}

precognition.toggle()

require('noice').setup({
  lsp = {
    progress = {
      enabled = true,
      format = "lsp_progress",
      format_done = "lsp_progress_done",
      throttle = 1000 / 30,
      view = "notify",
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
    hover = {
      enabled = true,
      silent = false,
      view = nil,
      opts = {},
    }
  },
  presets = {
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
})

keyset('n', '<leader>w', ":w<CR>")
keyset('n', '<leader>sq', ":wq<CR>")
keyset('n', '<leader>q', ":q<CR>")

keyset({ "n", "i", "s" }, "<c-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-f>"
  end
end, { silent = true, expr = true })

keyset({ "n", "i", "s" }, "<c-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-b>"
  end
end, { silent = true, expr = true })
