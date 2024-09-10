syntax enable
"set background=dark
"colorscheme solarized
let g:solarized_termcolors=256
set guifont=Fira\ Code\ 13
filetype plugin indent on
" remove auto commenting
set formatoptions-=r formatoptions-=c formatoptions-=o
set autoindent
set autoread
set backspace=indent,eol,start
" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" Searching includes can be slow
set complete-=i
" When lines are cropped at the screen bottom, show as much as possible
set display=lastline
set guioptions-=T guioptions-=e guioptions-=L guioptions-=r
set hidden
set incsearch
" Always show status line
set laststatus=2
" ignore search case unless capitalized
set ignorecase smartcase
" show trailing whiteshace and tabs
set modelines=5
set scrolloff=1
set sidescrolloff=5
set shell=zsh
set showcmd
set showmatch
set smarttab
set splitright
set splitbelow
" Make Esc work faster
set ttimeoutlen=50
set undofile
set undodir=~/.vim/undodir
" emacs style menu completion
set wildmenu
set wildmode=list:longest,full
set visualbell

" line numbers
set number

set wildignorecase

"set clipboard=unnamedplus

" Highlight all .sh files as if they were bash
let g:is_bash = 1

" any jump use ripgrep
"let g:any_jump_search_prefered_engine = 'rg'

" Enable TAB indent and SHIFT-TAB unindent
vnoremap <silent> <TAB> >gv
vnoremap <silent> <S-TAB> <gv

" Map noh to esc hits to clear search highlighting
" nnoremap <esc> :noh<return><esc>

" Change dir to currently edited file for all vim windows
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Change dir to currently edited file for current vim windows
nnoremap ,lcd :cd %:p:h<CR>:pwd<CR>

augroup vimrc
  autocmd!
  autocmd GuiEnter * set columns=120 lines=70 number

  autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
        \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

  autocmd BufRead * if ! did_filetype() && getline(1)." ".getline(2).
        \ " ".getline(3) =~? '<\%(!DOCTYPE \)\=html\>' | setf html | endif

  autocmd FileType javascript,coffee   setlocal et sw=2 sts=2 isk+=$
  autocmd FileType html,xhtml,css,scss setlocal et sw=2 sts=2
  autocmd FileType eruby,yaml,ruby     setlocal et sw=2 sts=2
  autocmd FileType php                 setlocal et sw=4 sts=4
  autocmd FileType tf                  setlocal et sw=2 sts=2
  autocmd FileType gitcommit           setlocal spell
  autocmd FileType gitconfig           setlocal noet sw=8
  autocmd FileType sh,csh,zsh          setlocal et sw=2 sts=2
  autocmd FileType vim                 setlocal et sw=2 sts=2 keywordprg=:help
  autocmd FileType tf,json             setlocal et sw=4 sts=4

augroup END


if has("clipboard")
    " CTRL-Shift-X is Cut
    vnoremap <C-S-x> "+x

    " CTRL-Shift-C is Copy
    vnoremap <C-S-c> "+y

    " CTRL-Shift-V is Paste
    map <C-S-V>		"+gP

    cmap <C-S-V>		<C-R>+
endif

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.
" Use CTRL-G u to have CTRL-Z only undo the paste.

if 1
    exe 'inoremap <script> <C-S-V> <C-G>u' . paste#paste_cmd['i']
    exe 'vnoremap <script> <C-S-V> ' . paste#paste_cmd['v']
endif

imap <S-Insert>		<C-S-V>
vmap <S-Insert>		<C-S-V>

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
