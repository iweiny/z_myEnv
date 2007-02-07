" Nices for formating this type of text
set formatoptions=tcroqn
set noai
set si         " make comments look good.
set sw=3
set hlsearch
set guioptions-=T

" map Tab to perform tab completion 'smartly'
function! VimdeCleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-N>"
endfunction
inoremap <Tab> <C-R>=VimdeCleverTab()<CR>

" the popup menu for convience
"set mousemodel=popup_setpos
"unmenu PopUp
"menu PopUp.-SEP2- <Nop>
"menu PopUp.Propose\ Alternatives :let @_=ProposeAlternatives()<CR>
"menu PopUp.Spell\ Check :let @_=SpellCheck()<CR>
"menu PopUp.End\ Spell\ Check :let @_=ExitSpell()<CR>

" gnuplot specifics
map <C-p> :call GnuPlotCmdFile()<CR>
map <F9> :call GnuPlotCmdFile()<CR>
menu &Gnuplot.&plot\ Cmd\ File :call GnuPlotCmdFile()<CR>

function! GnuPlotCmdFile()
   exe ":w"
   let myfile = expand('%:p')
   let dir = expand('%:p:h')
   let v:errmsg = ""
   exe "!cd ".dir."; gnuplot ".myfile
   "exe "!gnuplot ".myfile
endfunction



