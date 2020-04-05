if &compatible
  set nocompatible
endif

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    " necessary
    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

    " add your plugins here
    call dein#add('Shougo/deoplete.nvim', {'do':':UpdateRemotePlugins'})
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('scrooloose/nerdtree')
    call dein#add('preservim/nerdcommenter')
    call dein#add('altercation/vim-colors-solarized')
    call dein#add('deoplete-plugins/deoplete-jedi')
    call dein#add('davidhalter/jedi-vim')
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('tpope/vim-fugitive')
    call dein#add('Shougo/denite.nvim')
    call dein#add('tpope/vim-surround')
    call dein#add('itchyny/lightline.vim')
    call dein#add('neomake/neomake')
    call dein#add('terryma/vim-multiple-cursors')

    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

" set common
set colorcolumn=80
set showmode                    " Display the current mode
set cursorline                  " Highlight current line

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code

set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set nowrap                      " Do not wrap long lines
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

" map esc to jh
inoremap jh <esc>               

" set <leader> map"
let mapleader=','

" set for chinese
set fileencodings=utf-8,ucs-born,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

" set for tmux
if exists('$TMUX')
    set term=screen-256color
endif

" Stupid shift key fixes
if has("user_commands")
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
endif
cmap Tabe tabe

" set for jedi

" set for deoplete, autopair, neosnippet
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" set for solarized
if dein#tap('vim-colors-solarized')
    syntax enable
    set background=dark
    colorscheme solarized
    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
endif

" set for nerdtree
if dein#tap('nerdtree')
    map <C-e> :NERDTreeToggle<CR>
    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
    " quit when only NerdTree open
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif

" set for nerdcommenter
if dein#tap('nerdcommenter')
    " Add spaces after comment delimiters by default, { 'do':
    " ':UpdateRemotePlugins' }
    let g:NERDSpaceDelims = 1
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1
    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'
    " Set a language to use its alternate delimiters by default
    let g:NERDAltDelims_java = 1
    " Add your own custom formats or override the defaults
    let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1
endif

" set for denite
if dein#tap('denite')
    autocmd FileType denite call s:denite_my_settings()
    function! s:denite_my_settings() abort
      nnoremap <silent><buffer><expr> <CR>
      \ denite#do_map('do_action')
      nnoremap <silent><buffer><expr> d
      \ denite#do_map('do_action', 'delete')
      nnoremap <silent><buffer><expr> p
      \ denite#do_map('do_action', 'preview')
      nnoremap <silent><buffer><expr> q
      \ denite#do_map('quit')
      nnoremap <silent><buffer><expr> i
      \ denite#do_map('open_filter_buffer')
      nnoremap <silent><buffer><expr> <Space>
      \ denite#do_map('toggle_select').'j'
    endfunction
endif

" set for lightline
if dein#tap('lightline')
    let g:lightline = {'colorscheme': 'solarized'}
endif

" set for jedi, jedi-vim
if dein#tap('jedi')
    " disable autocompletion, cause we use deoplete for completion
    let g:jedi#completions_enabled = 0
    " open the go-to function in split, not another buffer
    let g:jedi#use_splits_not_buffers = "right"
    let g:python3_host_prog = '/usr/local/bin/python3'
endif

let g:neomake_python_enabled_makers = ['pylint']
call neomake#configure#automake('nrwi', 500)

" set for terminal mode
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
autocmd BufEnter term://* startinsert
