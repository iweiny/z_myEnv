set noexpandtab
set textwidth=79
set backspace=2

set sw=8
set ts=8
set autoindent
set laststatus=2
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


" Must be last to allow user to override things for their particular
" workstation
" source /home/iweiny/.vim/workstation.vim

