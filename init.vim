"   _____  _                                ___              _                                         
"  /  ___|| |                              / _ \            | |                                        
"  \ `--. | |__    __ _ __      __ _ __   / /_\ \ _ __    __| |  ___  _ __  ___   ___   _ __           
"   `--. \| '_ \  / _` |\ \ /\ / /| '_ \  |  _  || '_ \  / _` | / _ \| '__|/ __| / _ \ | '_ \          
"  /\__/ /| | | || (_| | \ V  V / | | | | | | | || | | || (_| ||  __/| |   \__ \| (_) || | | |         
"  \____/ |_| |_| \__,_|  \_/\_/  |_| |_| \_| |_/|_| |_| \__,_| \___||_|   |___/ \___/ |_| |_|         
"                                                                                                      
"      _   _  _              _____                 __  _                             _    _               
"     | | | |(_)            /  __ \               / _|(_)                           | |  (_)              
"     | | | | _  _ __ ___   | /  \/  ___   _ __  | |_  _   __ _  _   _  _ __   __ _ | |_  _   ___   _ __  
"     | | | || || '_ ` _ \  | |     / _ \ | '_ \ |  _|| | / _` || | | || '__| / _` || __|| | / _ \ | '_ \ 
"     \ \_/ /| || | | | | | | \__/\| (_) || | | || |  | || (_| || |_| || |   | (_| || |_ | || (_) || | | |
" Neo  \___/ |_||_| |_| |_|  \____/ \___/ |_| |_||_|  |_| \__, | \__,_||_|    \__,_| \__||_| \___/ |_| |_|
"                                                       __/ |                                          
"                                                      |___/                                           
"---------------------------------------------------------------------------------------------------------------------------------------------------------------------------                                                                                                      
" Inspiration From:
" https://github.com/novln/nvim/blob/master/init.vim
"
let b:cache_directory = $HOME . '/.cache/nvim'

call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes
"-------------------------------------------------------------------------------
Plug 'ajmwagar/vim-deus'
"-------------------------------------------------------------------------------
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"-------------------------------------------------------------------------------

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Enable tabline extension
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'

"-------------------------------------------------------------------------------
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
"-------------------------------------------------------------------------------
"
Plug 'ctrlpvim/ctrlp.vim'
      let g:ctrlp_cmd = 'CtrlPMixed' " search anything (in files, buffers and MRU files at the same time.)
      let g:ctrlp_working_path_mode = 'a' " search for nearest ancestor like .git, .hg, and the directory of the current file
      let g:ctrlp_match_window_bottom = 1 " show the match window at the top of the screen
      let g:ctrlp_by_filename = 1
      let g:ctrlp_max_height = 10 " maximum height of match window
      let g:ctrlp_switch_buffer = 'et' " jump to a file if it's open already
      let g:ctrlp_use_caching = 1 " enable caching
      let g:ctrlp_cache_dir = b:cache_directory . '/ctrlp' " define cache path
      let g:ctrlp_clear_cache_on_exit = 0 " speed up by not removing clearing cache everytime
      let g:ctrlp_mruf_max = 250 " number of recently opened files
nnoremap <silent> <Leader>p :<C-u>CtrlP<CR><Paste>

Plug 'junegunn/fzf', { 'dir': '~/Software/fzf', 'do': './install --all' }
" A command line fuzzy finder

"-------------------------------------------------------------------------------

Plug 'scrooloose/nerdcommenter'
"Comment manager
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

"-------------------------------------------------------------------------------

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " On-demand loading
":help NERDTreeOptions
map <C-n> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<cr>
let NERDTreeIgnore=['\.pyc$', '\~$']

"-------------------------------------------------------------------------------

Plug 'bfredl/nvim-ipy'
let g:nvim_ipy_perform_mappings = 0
map <silent> <leader>s <Plug>(IPy-Run)
map <silent> <leader><Enter> <Plug>(IPy-RunCell)
map <silent> <c-s> <Plug>(IPy-Complete)
map <silent> <c-s> <Plug>(IPy-WordObjInfo)
map <silent> <leader>? <Plug>(IPy-Interrupt)
map <silent> <c-s> <Plug>(IPy-Terminate)

""---------------------------------------------------------------------------------------------------------------------------------------------------------------------------                                                                                                      

Plug 'epeli/slimux'
"Send text between tmux panes!
nmap <Leader>s  :SlimuxREPLSendLine<CR>j
vmap <Leader>s :SlimuxREPLSendSelection<CR>
map  <C-c><C-c> :SlimuxREPLConfigure<CR>

"---------------------------------------------------------------------------------------------------------------------------------------------------------------------------                                                                                                      

" Initialize plugin system
call plug#end()

"============u============u============u============u============u============u
" VIM BEHAVIOUR
" Highlight character at column 80
:set colorcolumn=80

" Tab completion in command mode
set wildmenu

"These filetypes are ignored when expanding wildcard searches
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

" show line numbers
set number

" using only 1 column (and 1 space) while possible
set numberwidth=1 

" " leader is press comma (,) key
" " like <leader>w saves the current file
let mapleader=","
let g:mapleader=","
" Fast saving with leader + w
nmap <leader>w :w!<cr>
" Fast quitting with leader + q
nmap <leader>q :q<cr>
" Bring up vimrc for edditing
nnoremap <leader>ev :e $MYVIMRC<CR>  
" Force reload vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>     

" For copying text out of VIM
set mouse=a

" Syntax Highlighting
syntax enable

"set background=dark
"colorscheme solarized
colors deus

"Highlight Cursor line
set cursorline
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Enable Intuitive copy and paste
" vnoremap <C-c> "*y
" vnoremap <C-c> "+y
" nnoremap <C-v> "+p
" inoremap <C-v> <C-r>+
set pastetoggle=<F2>

"Use modifier to jump to beginning and end of lines
map <leader>j $
map <leader>f 0

"split more naturally
set splitbelow
set splitright
" Searching
set incsearch       " show 'best match so far' as you type
set hlsearch        " hilight the items found by the search
set ignorecase      " ignores case of letters on searches
set smartcase       " Override the 'ignorecase' option if the search pattern contains upper case characters
"Manually turn off the search highlight
map <leader>/ :nohl<CR>

set nowrap

"Abbreviations
ab h1 hi

" Disable annoying mappings
noremap  <silent> <C-c>  <Nop>
noremap  <silent> <C-w>f <Nop>
noremap  <silent> <Del>  <Nop>
noremap  <silent> <F1>   <Nop>

" [c] Copy selection in clipboard
vmap <silent> <Leader>c "+y

" [x] Cut selection in clipboard
vmap <silent> <Leader>x "+d

" [v] Paste content from clipboard
nmap <silent> <Leader>v "+p
vmap <silent> <Leader>v "+p

" Make buffer movement similar to vimium/vimfx for firefox using let
" g:airline#extensions#tabline#enabled v 1
"
" Cycle tabs 
nnoremap <silent> <S-k> :bn<CR>
nnoremap <silent> <S-j> :bp<CR>

"Specify which python to use
let g:python3_host_prog = '/home/shawn/Software/miniconda3/bin/python'
"---------------------------------------------------------------------------------------------------------------------------------------------------------------------------                                                                                                      
"
"                          .-""    ""--.
"                        ,'             `.
"                       /     ,'          \
"                    `\/     .             |
"                  .===:_,  |              /
"                 / .'""".  ,:=:.         / _.,
"                "   `--. `|/  _\` (    _/-" /
"                     |\_b_9-""  ___) -"-"//'
"                     | --/`--_o"_/'  (6_//
"   P I C C O L O     / ,'    -""    .),-'
"                     (  "-__       `-(
"                      \ |HHH/    /    \
"                       \  -   _./      `-._..._
"                        7----",'/     ..-" .-- "--.._
"                 _.._.-/)  .-',/   .-"  -"           ""--..
"          _..--"|=""--..--""""""./'  .              .-"""-.\
"        ,' .-','     ,'       /.   /              .'       \\
"     .:' ,' ,:      /      ,/'/  /'         _....' _..--""" )
"   ,"/  /  /(      /   _,/' / ,/'         /.    .-"       __|
"  / / /'  (  ""----""""   / ,/           / `:.-"    _.--""  /
"  ||  (    \_       __.-'  /             |`-.`:=._-"    _.-:|
"  \/   \     """""""      /               ""-`  `-"===="-'   \
"  |     "-.        __..-"                    \._.====..       `
"  |        ""--""""                          //..---""\\       .
"  \                                        /'| __...---.\      |
"