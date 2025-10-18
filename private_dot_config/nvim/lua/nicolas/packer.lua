-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  --lsp server configs
  use 'neovim/nvim-lspconfig'
  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  --snippet engine
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
     'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use 'mbbill/undotree'
  use({
    'rose-pine/neovim', 
    as = 'rose-pine',
    config = function()
        vim.cmd('colorscheme rose-pine')
    end
  })
  use {
    "pmizio/typescript-tools.nvim",
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup {}
    end,
  }
end)
