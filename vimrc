"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number

" set leaderkey
let mapleader=","

" Fast saving
nmap <leader>w :w!<cr>

" ---Keys remap---
imap jj <Esc>

" read chetsheet after startup
au VimEnter * :e ~/workspace/notes/vimstartup.md


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimWiki 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:vimwiki_list = [{'path': '~/vimwiki/',
"	       \ 'syntax': 'markdown', 'ext': '.md'}]
"let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.wiki'}]

let wiki_1 = {}
let wiki_1.path = '~/vimwiki/primary_wiki'
let wiki_1.auto_diary_index = 1
"let wiki_1.html_template = '~/public_html/template.tpl'
"let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}

let wiki_2 = {}
let wiki_2.path = '~/vimwiki/vimwiki_trading/'
let wiki_2.index = 'main'

let g:vimwiki_list = [wiki_1, wiki_2]


" VimWiki desired setup
set nocompatible
filetype plugin on
syntax on

" enable custom fold in vimwiki
let g:vimwiki_folding='expr'

" disable creation of temporaty wiki
let g:vimwiki_global_ext=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on the Wild menu
set wildmenu

" always show current position
set ruler

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
"set expandtab

" Be smart when using tabs ;)
"set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=80

"set ai "Auto indent
"set si "Smart indent
"set wrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Close the current buffer
" :Bclose is based on function at the end of this file
map <leader>q :Bclose<cr>:tabclose<cr>gT

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr> "better gt


" NERDTree mapings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" --- replaced for better use, ctrlp
" nnoremap <C-f> :NERDTreeFind<CR>


" vim_markdown setup
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_folding_level = 2

set foldlevel=2

" markdown fold mappings
nnoremap <leader>m zm
nnoremap <leader>r zr
nnoremap <leader>a za

" ctrlp.vim plugin
"Quickly find and open a file
let g:ctrlp_map = '<C-f>' 
"find and open a recently opened file
map <leader>f :CtrlPMRU<CR> 

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'powerline/fonts'
Plug 'scrooloose/nerdtree'
Plug 'plasticboy/vim-markdown'
Plug 'vimwiki/vimwiki'


" Initialize plugin system
call plug#end()

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

let g:airline_symbols.colnr = ' :'

" setup ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction
