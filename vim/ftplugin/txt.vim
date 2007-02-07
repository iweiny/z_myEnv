" Nices for formating this type of text
set formatoptions=tcroqn
set nocindent  " this is not C code
set noai       " don't need this
set si         " make comments look good.
set sw=3
set hlsearch
set guioptions-=T

" Date and time stamp insertion in a section...
" Pretty ED4 specific
map <F8> :read !date +\%l\:\%M<CR>kJA --

" map Tab to perform tab completion 'smartly'
function! VimdeCleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-N>"
endfunction
inoremap <Tab> <C-R>=VimdeCleverTab()<CR>

noremenu &File.&Print :!enscript --margins=:::50 -2r -G %

" the popup menu for convience
set mousemodel=popup_setpos
unmenu PopUp
menu PopUp.-SEP2- <Nop>
menu PopUp.Propose\ Alternatives :let @_=ProposeAlternatives()<CR>
menu PopUp.Spell\ Check :let @_=SpellCheck()<CR>
menu PopUp.End\ Spell\ Check :let @_=ExitSpell()<CR>
menu PopUp.-SEP3- <Nop>
menu PopUp.Split\ Buffer :sp<CR>
menu PopUp.Close\ Buffer :q<CR>
menu PopUp.Save :w<CR>

" Periodically check the spelling.
autocmd! CursorHold * exe "silent! AutoSpell"
set updatetime=1000

