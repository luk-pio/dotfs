" Vim native plugins
:filetype plugin on

" VimPlug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'davidhalter/jedi-vim'
Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'chrisbra/csv.vim'
Plug 'wellle/targets.vim'
Plug 'justinmk/vim-sneak'

" To try in the future:
" Plug 'easymotion/vim-easymotion'

call plug#end()

" Plugin specific configuration:
" vim-sneak
let g:sneak#label = 1

" Powerline 
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_gruvbox_dark_hard'
:set laststatus=2

" CtrlP
let g:ctrlp_switch_buffer = 'Et'

" jedi-vim
let g:jedi#use_splits_not_buffers = "top"
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = 0
