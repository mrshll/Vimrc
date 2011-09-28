" VIMRC (pieces picked from multiple sources, primarily
" "   http://www.vim.org/scripts/script.php?script_id=760
" "   http://amix.dk/vim/vimrc.html
" "   http://stackoverflow.com/questions/164847/what-is-in-your-vimrc
"
" " Catered to the needs and woes of a Tufts University Comp40 student
" " Contact Marshall @ mmoutenot@gmail.com with questions or comments.
"

"{{{Auto Commands

" Automatically cd into the directory that the file is in
set autochdir

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

"}}}

"{{{Misc Settings

" Necessary for a lot of cool vim things
set nocompatible

" This shows what you are typing as a command at the bottom of the page
set showcmd
set cmdheight=2

" Folding Stuffs
" I find this one a little annoying sometimes set foldmethod=marker
set wrap

" Syntax Higlighting
filetype on
filetype plugin on
filetype indent on

" read a file when it is changed from the outside
set autoread

" Use grep
set grepprg=grep\ -nH\ $*

" AutoIndent
set autoindent

" Complete CSS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Change spaces to a tab character
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

" Spell checking (default=false)
if version >= 700
    set spl=en spell
    set nospell
endif

" Tab completion
set wildmenu
set wildmode=list:longest,full

" Enable ball and chain er... mouse support in console
set mouse=a

set backspace=2

" Always show line numbers and current position
set ruler
set number

" Case handling
set ignorecase
set smartcase

" Incremental search
set incsearch
set hlsearch
set nolazyredraw

" For linux clipboard register
let g:clipbrdDefaultReg = '+'

" Second paren
highlight MatchParen ctermbg=4

"}}}


"{{{Look and Feel and sound
syntax enable "Enable syntax hl

" Set font according to system
" if you're using a mac
  "set gfn=Menlo:h14
  "set shell=/bin/bash

" if you're using windows
  "set gfn=Bitstream\ Vera\ Sans\ Mono:h10

" if you're using linux
  set gfn=Monospace\ 10
  set shell=/bin/bash

syntax enable "Enable syntax h1

syntax enable "Enable highlighting
set guioptions-=T
set t_Co=256
set background=dark
colorscheme peaksea
set nonu
set encoding=utf8

try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types

"Status line gnarliness
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" }}}

"{{{Functions

"{{{ Open URL in Browser

function! Browser()
    let line = getline (".")
    let line = matchstr (line,"http[^  ]*")
    exec "!chrome ".line
endfunction

"}}}

"{{{ Todo List Mode

function! TodoListMode()
    e ~/.todo.otl
    Calendar
    wincmd l
    set foldlevel=1
    tabnew ~/.notes.txt
    tabfirst
    or 'norm! zMzr'
endfunction

"}}}

"{{{ Persistant Undo
    "if windows
      "set undodir=C:\Windows\Temp
    "otherwise
    if version >720
        set undodir=~/.vim_runtime/undodir
        set undofile
    endif
"}}}

"}}}

"{{{ Mappings

" Open Url with the browser \w
map <Leader>w :call Browser ()<CR>

" Trigger the above todo mode
noremap <silent> <Leader>todo :execute TodoListMode()<CR>

" Next Tab
noremap <silent> <C-Right> :tabnext<CR>
" Previous Tab
noremap <silent> <C-Left> :tabprevious<CR>
" New Tab
noremap <silent> <C-t> :tabnew<CR>

" Centers the next result on the page
map N Nzz
map n nzz

" Swap ; and : (one less keypress)
nnoremap ; :
nnoremap : ;

