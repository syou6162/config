set noswapfile
set nobackup
set expandtab
set tabstop=2
set shiftwidth=2
set autowrite

let mapleader=","

call plug#begin('~/.vim/plugged')
Plug 'vim-jp/vimdoc-ja'
Plug 'derekwyatt/vim-scala'
Plug 'mattn/vim-fz'
Plug 'fatih/vim-go'
Plug 'itchyny/calendar.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'dag/vim-fish'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'ivalkeen/vim-ctrlp-tjump'
Plug 'mhinz/vim-grepper'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/vim-easy-align'
Plug 'marijnh/tern_for_vim'
Plug 'majutsushi/tagbar'
Plug 'djoshea/vim-autoread'
call plug#end()

" カーソルを表示行で移動する
nnoremap j gj
nnoremap k gk
nnoremap <Leader>t :silent! !tig<CR>:redraw!<CR>
nnoremap <Leader>b :silent! !tig blame +<C-r>=line('.')<CR> %<CR>:redraw!<CR>
nnoremap <Leader>s :silent! !tig status<CR>:redraw!<CR>

noremap ; :
inoremap <silent> jj <ESC>

nnoremap <Leader>i :silent! !/usr/local/bin/idea --line <C-r>=line('.')<CR> %:p<CR>:redraw!<CR>
nnoremap <Leader>c :silent! !/usr/local/bin/charm --line <C-r>=line('.')<CR> %:p<CR>:redraw!<CR>
nnoremap <Leader>g :silent! !/usr/local/bin/gogland --line <C-r>=line('.')<CR> %:p<CR>:redraw!<CR>

if has("mouse")
  set mouse=a
endif

" ファイル名はフルパスで表示する
nnoremap <C-g> 1<C-g>

function! Memo()
  let f = strftime('~/Dropbox/_posts/%Y-%m-%d-日報.md', localtime())
  execute 'edit' f
endfunction
command! Memo call Memo()

" Statuslineの設定
set laststatus=2

let g:tagbar_left = 1
let g:tagbar_width = 30

set backspace=indent,eol,start

set hlsearch
nnoremap <ESC><ESC> :nohlsearch<CR>

let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_auto_type_info = 1
inoremap <buffer> <C-X><C-O> <C-X><C-O><C-P>
set completeopt=menuone

nnoremap gd :CtrlPtjump<cr>
vnoremap gd :CtrlPtjumpVisual<cr>
let g:ctrlp_tjump_only_silent = 1
let g:ctrlp_tjump_skip_tag_name = 1

autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap gd :GoDef<CR>

autocmd FileType javascript nmap gd :TernDef<CR>
let g:tern_show_argument_hints = "on_move"

autocmd FileType help nnoremap <buffer> q <C-w>c

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

let NERDTreeShowHidden = 1
" デフォルトでツリーを表示させる
let g:nerdtree_tabs_open_on_console_startup=1
let g:ctrlp_show_hidden = 1
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_types = ['mru']
let g:ctrlp_extensions = ['quickfix']
let g:ctrlp_max_height = 20
let g:ctrlp_highlight_match = [1, 'IncSearch'] " 絞り込みで一致した部分のハイライト

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

function! FallBackToCtrlP()
  cclose
  CtrlPQuickfix
endfunction

command! FallBackToCtrlP call FallBackToCtrlP()
autocmd FileType qf nnoremap <buffer> q :FallBackToCtrlP<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

set tags=tags,./tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags,../../../../../../tags,../../../../../../../tags

" Clipboard
set clipboard=unnamed
set clipboard+=unnamedplus

" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

let g:ctrlp_prompt_mappings = {
      \ 'PrtSelectMove("j")':   ['<c-n>'], 
      \ 'PrtSelectMove("k")':   ['<c-p>'],
      \ 'PrtHistory(-1)':       ['<down>'],
      \ 'PrtHistory(1)':        ['<up>'],
      \ }

" 補完時に<CR>で候補を決定すると改行までされてうざいので、挿入モードのときだけ<C-Y>にしておく
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

" Command line history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" like emacs
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-k> <c-o>D
