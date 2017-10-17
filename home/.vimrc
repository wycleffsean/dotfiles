" Vundle
set nocompatible "required
filetype off "required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Let Vundle manage itself
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'kchmck/vim-coffee-script'
Plugin 'fatih/vim-go'
Plugin 'mtscout6/vim-cjsx'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/vim-easy-align'
Plugin 'majutsushi/tagbar'
Plugin 'ludovicchabant/vim-gutentags'

" Colorschemes
Plugin 'endel/vim-github-colorscheme' "pretty diffs
Plugin 'KeitaNakamura/neodark.vim'

" Required, plugins available after
call vundle#end()
filetype plugin indent on

set nocompatible " Turn off vi compatibility
set smartindent
set autoindent
"filetype indent on " load indent file for the current filetype

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
"if exists('+colorcolumn')
"   set colorcolumn=80
"else
"  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"endif
let &colorcolumn=join(range(81,81),",")

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal sts=2 sw=2
" Align GitHub-flavored Markdown tables
autocmd FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

syntax on

let g:airline#extension#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t' "only show filename
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" let g:ctrlp_map = '<D-p>'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_dont_split = 'NERD_tree_1'
let g:ctrlp_extensions = ['tag']

if executable('rg')
  " Use ripgrep over ag
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  let g:ctrlp_user_command = 'rg -l --no-ignore --hidden --text %s'
  let g:ctrlp_use_caching = 0
elseif executable('ag')
  " Use ag over grep
  set grepprg=ag
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" bind \ to grep shortcut
command -nargs=+ -complete=file -bar Grep silent! grep! <args>|cwindow|redraw!
nnoremap \ :Grep<SPACE>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>


" Colors
colorscheme neodark
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


" Leader Mappings
let mapleader = " "
map <leader>k :NERDTree<cr>
nmap <leader>t :TagbarToggle<CR>
nmap <leader>p :CtrlPTag<CR>

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
"nnoremap <leader>p "+p
"nnoremap <leader>P "+P
"vnoremap <leader>p "+p
"vnoremap <leader>P "+P

" Ruby
" puts the caller
nnoremap <leader>wtf oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>

" ######
" NEOVIM
" ######
if has('nvim')
  "set termguicolors
  "let g:python_host_prog = '/usr/local/bin/python2'

  " Reload files when modified outside of editor
  " i.e. git
  " https://github.com/neovim/neovim/issues/2127#issuecomment-150954047
  augroup AutoSwap
          autocmd!
          autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
  augroup END

  function! AS_HandleSwapfile (filename, swapname)
          " if swapfile is older than file itself, just get rid of it
          if getftime(v:swapname) < getftime(a:filename)
                  call delete(v:swapname)
                  let v:swapchoice = 'e'
          endif
  endfunction
  autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
    \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

  augroup checktime
      au!
      if !has("gui_running")
          "silent! necessary otherwise throws errors when using command
          "line window.
          autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * checktime
      endif
  augroup END
endif
