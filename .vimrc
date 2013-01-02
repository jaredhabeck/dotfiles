call pathogen#infect()

syntax on
colorscheme vividchalk
filetype plugin indent on

command! -bar -range=% Trim :<line1>,<line2>s/\s\+$//e

function! HTry(function, ...)
  if exists('*'.a:function)
    return call(a:function, a:000)
  else
    return ''
  endif
endfunction

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
if &grepprg ==# 'grep -n $* /dev/null'
  set grepprg=grep\ -rnH\ --exclude='.*.swp'\ --exclude='*~'\ --exclude='*.log'\ --exclude=tags\ $*\ /dev/null
endif
set guifont=Monaco:h14
set guioptions-=T guioptions-=e guioptions-=L guioptions-=r
set hidden
set incsearch
" Always show status line
set laststatus=2
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
" ignore search case unless capitalized
set ignorecase smartcase
" show trailing whiteshace and tabs
set list
set modelines=5
set scrolloff=1
set sidescrolloff=5
set shell=bash
set showcmd
set showmatch
set smarttab
set splitright
set splitbelow
if &statusline == ''
  set statusline=[%n]\ %<%.99f\ %h%w%m%r%{HTry('CapsLockStatusline')}%y%{HTry('rails#statusline')}%{HTry('fugitive#statusline')}%#ErrorMsg#%{HTry('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P
endif
" Make Esc work faster
set ttimeoutlen=50
set undofile
set undodir=~/.vim/undodir
" emacs style menu completion
set wildmenu
set wildmode=list:longest,full
set visualbell

if $TERM == '^\%(screen\|xterm-color\)$' && t_Co == 8
  set t_Co=16
endif

" Highlight all .sh files as if they were bash
let g:is_bash = 1
let g:ruby_minlines = 500
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

" CtrlP options
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" If at end of line, decrease indent, else <Del>
inoremap <silent> <C-D> <C-R>=col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"<CR>
cnoremap          <C-D> <Del>
" If at end of line, fix indent, else <Right>
inoremap <silent> <C-F> <C-R>=col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"<CR>
inoremap          <C-E> <End>
cnoremap          <C-F> <Right>

" Enable TAB indent and SHIFT-TAB unindent
vnoremap <silent> <TAB> >gv
vnoremap <silent> <S-TAB> <gv

iabbrev ipsum     Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
iabbrev bpry      require 'pry'; binding.pry

augroup vimrc
  autocmd!
  autocmd GuiEnter * set columns=120 lines=70 number

  autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
        \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

  autocmd BufRead * if ! did_filetype() && getline(1)." ".getline(2).
        \ " ".getline(3) =~? '<\%(!DOCTYPE \)\=html\>' | setf html | endif

  autocmd FileType javascript,coffee      setlocal et sw=2 sts=2 isk+=$
  autocmd FileType html,xhtml,css,scss    setlocal et sw=2 sts=2
  autocmd FileType eruby,yaml,ruby,php    setlocal et sw=2 sts=2
  autocmd FileType cucumber               setlocal et sw=2 sts=2
  autocmd FileType gitcommit              setlocal spell
  autocmd FileType gitconfig              setlocal noet sw=8
  autocmd FileType sh,csh,zsh             setlocal et sw=2 sts=2
  autocmd FileType vim                    setlocal et sw=2 sts=2 keywordprg=:help
  autocmd FileType ruby                   setlocal comments=:#\  tw=79

  autocmd Syntax   css  syn sync minlines=50

  autocmd FileType ruby nmap <buffer> <leader>bt <Plug>BlockToggle
  autocmd BufRead *_spec.rb nmap <buffer> <leader>l :<C-U>call <SID>ExtractIntoRspecLet()<CR>

  autocmd User Rails nnoremap <buffer> <D-r> :<C-U>Rake<CR>
  autocmd User Rails nnoremap <buffer> <D-R> :<C-U>.Rake<CR>
  autocmd User Rails Rnavcommand decorator app/decorators -suffix=_decorator.rb -default=model()
  autocmd User Rails Rnavcommand uploader app/uploaders -suffix=_uploader.rb -default=model()
  autocmd User Rails Rnavcommand steps features/step_definitions -suffix=_steps.rb -default=web
  autocmd User Rails Rnavcommand blueprint spec/blueprints -suffix=_blueprint.rb -default=model()
  autocmd User Rails Rnavcommand factory spec/factories -suffix=_factory.rb -default=model()
  autocmd User Rails Rnavcommand feature features -suffix=.feature -default=cucumber
  autocmd User Rails Rnavcommand serializer app/serializers -suffix=_serializer.rb -default=model()
  autocmd User Rails Rnavcommand support spec/support features/support -default=env
  autocmd User Rails Rnavcommand worker app/workers -suffix=_worker.rb -default=model()
  autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=model()
  autocmd User Fugitive command! -bang -bar -buffer -nargs=* Gpr :Git<bang> pull --rebase <args>
augroup END
