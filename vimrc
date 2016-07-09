set noexpandtab
set textwidth=79
set backspace=2

set sw=8
set ts=8
set autoindent
set laststatus=2
set scrolloff=20
"set cindent

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set nocp
set formatoptions=tcroqn

" Set up for mouse support in an xterm
set ttymouse=xterm2
set mouse=a

" mapping of keys we like
map <C-s> :w<CR>
" plain date
"map <F8> :read !date +\%l\:\%M<CR>kJA --

"function! InsertDate()
"    read !date
"    normal o
"endfunction

"command Dts :call InsertDate()

"source ~/.vim/vimispell.vim

filetype plugin on

" a cleaver tab completion
function! CleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-N>"
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

" a better way to man
runtime ftplugin/man.vim
map K :Man <C-R>=expand("<cword>")<CR><CR>

"function! Text()
"    " Periodically check the spelling.
"    autocmd! CursorHold * exe "silent! AutoSpell"
"    set updatetime=1000
"    silent! call GUIText()
"endfunction
"command! Text :call Text()

" new vim 7.0 spell check
setlocal spell spelllang=en_us

" Attempt to check spelling in "c" files.
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

syntax enable

let g:xml_syntax_folding=1
au BufNewFile,BufReadPost *.xml setlocal foldmethod=syntax

autocmd QuickFixCmdPost *grep* cwindow

" Git commands which are commonly usefull
function! GitAnnotate()
   let line = line(".")
   bd annotate.tmp
   silent! exe "!git annotate % > ~/z_myEnv/tmp/annotate.tmp"
   silent! edit ~/z_myEnv/tmp/annotate.tmp
   silent! exe line
   redraw!
endfunction
com GAnn :call GitAnnotate()

function! GitAdd()
   silent! exe "!git add %"
   redraw!
endfunction
com Gadd :call GitAdd()

function! SmartSplit()
   " not sure how to get width of terminal vs window
   "let width = winwidth(0) " vim window
   "let width = columns " ??? terminal ???
   "if width < 100
      "silent! split ~/z_myEnv/tmp/diff.tmp
   "else
      silent! vsplit ~/z_myEnv/tmp/diff.tmp
   "endif
   redraw!
endfunction

function! GitShow(cword)
   bd diff.tmp
   silent! exe "!git show ".a:cword." > ~/z_myEnv/tmp/diff.tmp"
   call SmartSplit()
endfunction
com GSh :call GitShow("")

function! GitAnnotateShow(cword)
   call GitShow(a:cword)
   wincmd w
endfunction
com Gas :call GitAnnotateShow("<cword>")

function! GitDiff()
   bd diff.tmp
   silent! exe "!git diff > ~/z_myEnv/tmp/diff.tmp"
   call SmartSplit()
endfunction
com GD :call GitDiff()

function! GitDiffCached()
   bd diff.tmp
   silent! exe "!git diff --cached > ~/z_myEnv/tmp/diff.tmp"
   call SmartSplit()
endfunction
com Gdc :call GitDiffCached()

function! GitBranch()
   exe "!git branch -vvv"
endfunction
com GBr :call GitBranch()


" Must be last to allow user to override things for their particular
" workstation
" source /home/iweiny/.vim/workstation.vim

