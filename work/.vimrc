set laststatus=2
set number
set showcmd
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set expandtab
set tabstop=2
set shiftwidth=2
set t_ti= t_te= " don't clobber scrollbuffer
set hlsearch

set backspace=2
execute pathogen#infect()
syntax on
filetype plugin indent on

let mapleader = ","

" Indent Guides
let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black
" Airline
let g:airline#extension#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" let g:ctrlp_map = '<D-p>'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_dont_split = 'NERD_tree_2'
"let g:ctrlp_abbrev = {
"    \ 'gmode': 't',
"    \ 'abbrevs': [
"        \ {
"        \ 'pattern': '\(^@.\+\|\\\@<!:.\+\)\@<! ',
"        \ 'expanded': '_',
"        \ 'mode': 'pfrz',
"        \ },
"        \ ]
"    \ }

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

" File Settings
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
