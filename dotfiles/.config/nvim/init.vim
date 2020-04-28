"-----------------------------------------------------------------------------
" Options {{{
"-----------------------------------------------------------------------------

" File saving and undo history
set confirm
set undofile

" Visual guides
set colorcolumn=+1
set cursorline  " Highlight the screen line of the cursor
set guicursor=
set number
set relativenumber
set noruler  " More detail in Ctrl-G with both this and statusline set

" Spelling
set spelllang=en_gb,en_us

" Formatting
set formatoptions+=1  " Insert line break after one letter word

" Buffers
set hidden  " Hide rather than unload buffers when abandoned

" Searching
set ignorecase
set showmatch
set smartcase

" Interface behaviour
set mouse=a
set scrolloff=15
set noshowmode
set splitbelow
set splitright

" Directory searching
set path+=**  " Add recursive directory searching

" Wrapping and side scrolling
set sidescroll=10

" Status line
set statusline=Col:\ %v  " Column
set statusline+=\ \   " 2 spaces
set statusline+=Mode:\ %{mode()}  " Mode
set statusline+=%=  " Right-justify
set statusline+=%.40f\   " Relative path
set statusline+=%m  " Modified flag: [+], [-]
set statusline+=%r  " Read-only flag: [RO]
set statusline+=%y  " Filetype: [filetype]
" }}}


"-----------------------------------------------------------------------------
" Theming {{{
"-----------------------------------------------------------------------------

" https://github.com/morhetz/gruvbox/wiki/Configuration/
let g:gruvbox_italic=1
let g:gruvbox_number_column='bg1'
let g:gruvbox_italicize_comments=0
let g:gruvbox_invert_selection=0
let g:gruvbox_invert_tabline=1  " Tab line background matches status line

colorscheme gruvbox

set background=dark
set termguicolors  " Enable true-colour support
" }}}


"-----------------------------------------------------------------------------
" Key mappings {{{
"-----------------------------------------------------------------------------

" Insert mode
"" Meta-Backspace to delete word (Emacs)
imap <M-BS> <C-w>

" Visual mode
"" Cut to clipboard
vmap <C-x> "+d
"" Copy to clipboard
vmap <C-c> "+y
" }}}


"-----------------------------------------------------------------------------
" Filetype configuration {{{
"-----------------------------------------------------------------------------

" Default
setfiletype text

" Configuration files
autocmd FileType sshconfig set expandtab shiftwidth=0 tabstop=2

" Data serialisation
autocmd FileType yaml set shiftwidth=0 tabstop=2 spell nowrap

" Programming languages
autocmd FileType awk set shiftwidth=0 tabstop=2 nowrap
autocmd FileType python set shiftwidth=0 tabstop=4 textwidth=79 nowrap
autocmd FileType sh,bash,zsh set shiftwidth=0 tabstop=2 nowrap
autocmd FileType vim set expandtab shiftwidth=0 tabstop=2 nowrap

" LaTeX
autocmd FileType bib,tex set expandtab shiftwidth=0 tabstop=2 spell

" Other written language
autocmd FileType gitcommit set expandtab shiftwidth=0 tabstop=2 spell
autocmd FileType markdown set expandtab shiftwidth=0 tabstop=4 spell
autocmd FileType text set expandtab shiftwidth=0 tabstop=2 spell
" }}}


"-----------------------------------------------------------------------------
" Custom commands {{{
"-----------------------------------------------------------------------------

" Convert GitHub Flavored Markdown to HTML
command Gitmd2html :write |
  \ !pandoc --from markdown_github-hard_line_breaks --to html5
  \ --output %:r.html %
  \ --toc --toc-depth 6
  \ --self-contained --css $HOME/git/markdown-css/github.css

" Convert GitHub Flavored Markdown to PDF
command Gitmd2pdf :write |
  \ !pandoc --from markdown_github-hard_line_breaks --to html5
  \ --output %:r.pdf %
  \ --toc --toc-depth 6
  \ --self-contained --css $HOME/git/markdown-css/github.css

" LaTeX to PDF
command Latex2pdf !latexmk -output-directory=aux -pdf main.tex
" }}}


" vim: set foldmethod=marker:
