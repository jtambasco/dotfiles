" Installation
"
" trizen -S neovim
" pip2 install neovim
" pip3 install neovim neovim-remote
"
" Okular in vimtex:
" trizen -S okular
" okular > settings > Configure Okular > Editor
"   Editor: Custom Text Editor
"   Command: nvr --remote-silent %f -c %l

call plug#begin('~/.local/share/nvim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'iCyMind/NeoSolarized'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/csv.vim'
Plug 'mhinz/vim-signify'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'lervag/vimtex'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-syntastic/syntastic'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/echodoc.vim'
Plug 'justinmk/vim-gtfo'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-obsession'
Plug 'mhinz/vim-startify'
Plug 'reedes/vim-lexical'

call plug#end()

set nu
set mouse=a
:filetype plugin on
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

" Map SPACE to remove search highlighting
nmap <SPACE> <SPACE>:noh<CR>

" Setup tabs
filetype plugin indent on
syntax enable
set tabstop=4
set shiftwidth=4
set expandtab

set termguicolors
colorscheme NeoSolarized
set background=dark

" Airline Theme
let AirlineTheme='solarized'
let g:airline_solarized_bg='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" Easymotion
map <Leader> <Plug>(easymotion-prefix)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

" Nerdtree
map <C-n> :NERDTreeToggle<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Deoplete and Deoplete-Jedi
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#disable_auto_complete = 0

inoremap <silent><expr> <C-Space>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
    function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

set noshowmode
let g:echodoc_enable_at_startup = 1

" Jedi-Vim
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
" Uncomment the following to hide the preview window.
"autocmd FileType python set completeopt-=preview

" Vimtex
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
let g:vimtex_compiler_progname = 'latexmk'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_quickfix_mode = 2
let g:vimtex_quickfix_open_on_warning = 0
map <Leader>ls <Plug>(vimtex-compile-ss)

" Gtfo
let g:gtfo#terminals = { 'unix': 'termite -d' }

" Neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_completed_snippet = 1

" Vim-Lexical
let g:lexical#spell_key = '<leader>z'
set nocompatible
augroup lexical
  autocmd!
  autocmd FileType latex,tex,markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END
