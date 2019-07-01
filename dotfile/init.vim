set number
set showmatch
set tabstop=4
set shiftwidth=4
set expandtab
set cursorline
set laststatus=2
set list " 不可視文字の可視化
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

set shiftround

set ignorecase
set smartcase
set wrapscan
set hlsearch

nnoremap j gj
nnoremap k gk
nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap <ESC>l :set nowrap<CR>
nnoremap <ESC>h :set wrap<CR>

set matchpairs& matchpairs+=<:>

"########## vim plugin ##########
if has('vim_startig')
  set rtp+=~/.local/share/nvim/plugged
  if !isdirectory(expand('~/.local/share/nvim/plugged'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.local/share/nvim/plugged')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.local/share/nvim/plugged/autoload')
  end
endif

call plug#begin('~/.local/share/nvim/plugged')
" vim-niji
Plug 'vim-scripts/vim-niji'
let g:niji_matching_filetypes = ['listp', 'scheme', 'clojure', 'ruby', 'python']

if has('job') && has('channel') && has('timers')
  " ALE
  Plug 'w0rp/ale'
else
  " syntastic
  Plug 'vim-syntastic/syntastic'
  let g:syntastic_python_checkers = ['flake8']
  let g:syntastic_python_flake8_args = '--ignore="D100"'
  " ALE
  Plug 'w0rp/ale'
endif

" vim-autopep8
Plug 'tell-k/vim-autopep8'

" indentLine
Plug 'Yggdroot/indentLine'
let g:indentLine_color_term=239
let g:indentLine_char='|'
let g:indentLine_faster=1

" git diff
Plug 'airblade/vim-gitgutter'
set updatetime=250

" trail whitespace (to fix all use :FixWhitespace)
Plug 'bronson/vim-trailing-whitespace'

" vim-airline
Plug 'vim-airline/vim-airline'

" git
Plug 'tpope/vim-fugitive'

" distraction-free
Plug 'junegunn/goyo.vim'

" dim all lines except the current line
Plug 'junegunn/limelight.vim'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:limelight_conceal_ctermfg = 'gray'

" tabular plugin is used to format tables
Plug 'godlygeek/tabular'
" JSON front matter highlight plugin
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

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


call plug#end()
