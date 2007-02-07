set expandtab
set textwidth=79
set backspace=2

set sw=3
set ts=3
set autoindent
"set cindent

set nocp
set formatoptions=tcroqn

" mapping of keys we like
map <C-s> :w<CR>
" plain date
"map <F8> :read !date +\%l\:\%M<CR>kJA --

function! InsertDate()
    read !date
    normal o
endfunction

command Dts :call InsertDate()

source ~/.vim/vimispell.vim

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

function! Text()
    " Periodically check the spelling.
    autocmd! CursorHold * exe "silent! AutoSpell"
    set updatetime=1000
    silent! call GUIText()
endfunction
command! Text :call Text()

syntax enable

" Must be last to allow user to override things for their particular
" workstation
" source /home/iweiny/.vim/workstation.vim

