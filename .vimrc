set noswapfile
set nobackup
set expandtab
set tabstop=2
set shiftwidth=2
set autowrite

let mapleader=","

call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/mru.vim'
Plug 'vim-jp/vimdoc-ja'
Plug 'tpope/vim-fugitive'
Plug 'derekwyatt/vim-scala'
Plug 'mattn/vim-fz'
Plug 'fatih/vim-go'
Plug 'itchyny/calendar.vim'
call plug#end()

nnoremap <Leader>t :MRU<CR>
nnoremap <Leader>g :silent! !tig<CR>:redraw!<CR>

function! Memo()
  let f = strftime('~/Dropbox/_posts/%Y-%m-%d-日報.md', localtime())
  execute 'edit' f
endfunction
command! Memo call Memo()

" Statuslineの設定
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ \[ENC=%{&fileencoding}]%P

let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:syntastic_go_checkers = "gofmt"
let g:go_auto_type_info = 1
nnoremap <leader>a :cclose<CR>
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <Leader>i <Plug>(go-info)

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

