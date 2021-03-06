source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  if has("mac")
    set backup
    set backupdir=~/vimbackup "need to create 'vimbackup' dir on mac
  else
    set nobackup    "I do not intend to set up 'backup' on any OS except for macos for now
  endif
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
    if has("mac")
      set undodir=~/vimbackup/undo  "also need to create 'undo' dir 
    else
      set noundofile
    endif
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

set number

set hidden

set noswapfile

set tabstop=4
set shiftwidth=4

"this makes & command better
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"this makes % command better 
runtime macros/matchit.vim

"when * is inputted during visual mode, search it (# search backward)
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

source <sfile>:h/dotfiles/.vim/vim-surround/plugin/surround.vim

"use arrowkeys to handle active window
noremap <Up> <C-w>k
noremap <Down> <C-w>j
noremap <Left> <C-w>h
noremap <Right> <C-w>l
noremap <C-Up> <C-w>+
noremap <C-Down> <C-w>-
noremap <C-Left> <C-w><
noremap <C-Right> <C-w>>

"change :make to compile the current c or cpp file buffer only
augroup setcompiler
  au Bufread,Bufnewfile *.c set makeprg=gcc\ -Wall\ -o\ %<\ %
  au Bufread,Bufnewfile *.cpp set makeprg=g++\ -o\ %<\ %
  au Bufread,Bufnewfile *.tex set makeprg=ptex2pdf\ -l\ %
augroup END

"use msys commands in vimshell on Windows
if has('win32')
  let $PATH = $PATH . ';C:\MinGW\msys\1.0\bin'
endif

""""""""""""NeoBundle""""""""""""

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/dotfiles/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'oplatek/conque-shell'
NeoBundle 'octol/vim-cpp-enhanced-highlight'
NeoBundle 'shougo/vimshell.vim'
NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\     'windows' : 'tools\\update-dll-mingw',
			\     'cygwin' : 'make -f make_cygwin.mak',
			\     'mac' : 'make',
			\     'linux' : 'make',
			\     'unix' : 'gmake',
			\    },
			\ }

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"""""""""""""""""""""""""""""""""

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map<C-N> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('syntax') && has('eval')
  packadd! matchit
endif
