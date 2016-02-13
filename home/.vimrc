" Vundle
set nocompatible "required
filetype off "required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Let Vundle manage itself
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'kchmck/vim-coffee-script'
Plugin 'fatih/vim-go'
Plugin 'mtscout6/vim-cjsx'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'

" Colorschemes
Plugin 'endel/vim-github-colorscheme' "pretty diffs

" Required, plugins available after
call vundle#end()
filetype plugin indent on

set nocompatible " Turn off vi compatibility
set smartindent
set autoindent
filetype indent on " load indent file for the current filetype

set laststatus=2
set number
set showcmd
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set splitbelow
set splitright
set backspace=2 "make backspace work like most other apps
set ignorecase          " searches are case insensitive...
set smartcase           " ... unless they contain at least one capital letter
set expandtab
set shiftwidth=2
set softtabstop=2
"set t_ti= t_te= " don't clobber scrollbuffer
set hlsearch
if exists('+colorcolumn')
   set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal sts=2 sw=2

syntax on

let g:airline#extension#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t' "only show filename
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" let g:ctrlp_map = '<D-p>'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_dont_split = 'NERD_tree_1'
" The Silver Searcher
if executable('ag')
	" Use ag over grep
	set grepprg=ag
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

if &diff
  colorscheme github
endif

" mappings
"set winminheight=0
"set winheight=999
"nmap <c-h> <c-w>h<c-w>_
"nmap <c-j> <c-w>j<c-w>_
"nmap <c-k> <c-w>k<c-w>_
"nmap <c-l> <c-w>l<c-w>_
let mapleader = " "
map <leader>k :NERDTree<cr>
