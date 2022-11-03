-- Packer things
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use "tanvirtin/monokai.nvim"
  use "ryanoasis/vim-devicons"
  use 'windwp/nvim-autopairs'
  use 'gruvbox-community/gruvbox'
  use 'rebelot/kanagawa.nvim'
  use 'arcticicestudio/nord-vim'
  use "EdenEast/nightfox.nvim"
  use 'kyazdani42/nvim-tree.lua'
  use "kyazdani42/nvim-web-devicons" 
  use "sheerun/vim-polyglot"
  use "akinsho/bufferline.nvim"
  use 'nvim-lualine/lualine.nvim'
  use "vim-scripts/AutoComplPop"
  use "brenoprata10/nvim-highlight-colors"
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  --use 'neoclide/coc.nvim'
end)
