set nocompatible

" Input stuff
set encoding=utf-8
set t_Co=256
setlocal spell spelllang=es
autocmd BufWinEnter * set spell
"
" Colorscheme
colorscheme koehler
colorscheme 256-jungle
highlight OverLength ctermbg=203 ctermfg=white
match OverLength /\%81v.\+/
autocmd BufWinEnter * match OverLength /\%81v.\+/

" Lightline
let g:lightline = {
    \'colorscheme': 'wombat',
\}

" General stuff
set number
set hlsearch
set history=50
set ruler
set showcmd
set laststatus=2
set wildmode=full
set list
set listchars=tab:▸\ ,eol:¶
let mapleader=","

" Indentation stuff
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

" Mouse stuff
set selectmode=mouse
set mouse=n

" Open vimrc in another tab
map <Leader>v :tabnew $MYVIMRC<CR>

" Recursively find a tags file
set tags=./tags;/

" Initialize pathogen
execute pathogen#infect()
filetype plugin indent on
syntax on

" Spell keys
map <Leader>o :set spell!<CR>
map <Leader>so :set spelllang=es<CR>
map <Leader>eo :set spelllang=en<CR>
map <C-l> gt
map <C-h> gT

" Shift between header/source file on c++
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Diff stuff
hi! DiffAdd cterm=None ctermbg=Green ctermfg=234
hi! DiffChange cterm=None ctermbg=Yellow ctermfg=234
hi! DiffDelete cterm=None ctermbg=Red ctermfg=234
hi! DiffText cterm=None ctermbg=Blue ctermfg=234
set diffopt+=vertical
map <Leader>ds :windo diffthis<CR>
map <Leader>de :windo diffoff<CR>
map <Leader>dg :diffget<CR> :diffupdate<CR>
map <Leader>dp :diffput<CR> :diffupdate<CR>

" vimgrep key
map <Leader>* :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR><C-w>j

" ====================================
" From now on it's mostly plugin's stuff
" ====================================

" Some random keys
map <Leader>z :GundoToggle<CR>
map <Leader>t :TagbarToggle<CR> <C-w>=<CR>
map <Leader>fo :fold<CR>
map <Leader><F1> :syntax sync fromstart <CR>

" NERDTree stuff
hi! Directory ctermfg=172 ctermbg=None cterm=Bold
map <Leader>n :NERDTreeFind<CR>C

" For vim-latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'evince'

" Autoclean fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Sessions stuff
let g:session_autosave = 'no'
map <Leader>os :OpenSession<CR>
map <Leader>ss :SaveSession<CR>

" Unite keys
map <Leader>b  :Unite -no-split -start-insert -buffer-name=buffer -quick-match buffer<CR>
map <Leader>vb :vs<CR>:Unite -no-split -start-insert -buffer-name=buffer -quick-match buffer<CR>
map <Leader>sb :sp<CR>:Unite -no-split -start-insert -buffer-name=buffer -quick-match buffer<CR>
map <Leader>tb :tabnew<CR>:Unite -no-split -start-insert -buffer-name=buffer -quick-match buffer<CR>

map <Leader>f  :Unite -no-split -start-insert -buffer-name=files file_rec/async<CR>
map <Leader>vf :vs<CR>:Unite -no-split -start-insert -buffer-name=files file_rec/async<CR>
map <Leader>sf :sp<CR>:Unite -no-split -start-insert -buffer-name=files file_rec/async<CR>
map <Leader>tf :tabnew<CR>:Unite -no-split -start-insert -buffer-name=files file_rec/async<CR>

map <Leader>g  :Unite -no-split -start-insert -buffer-name=grep grep:.<CR>
map <Leader>vg :vs<CR>:Unite -no-split -start-insert -buffer-name=grep grep:.<CR>
map <Leader>sg :sp<CR>:Unite -no-split -start-insert -buffer-name=grep grep:.<CR>
map <Leader>tg :tabnew<CR>:Unite -no-split -start-insert -buffer-name=grep grep:.<CR>

map <Leader>co <C-_>b<CR>
