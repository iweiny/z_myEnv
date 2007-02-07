" general reading of our specific functions.
" for different file types.
" au BufNewFile,BufReadPost *.rcp source ~/.vim/rcp.vim
au BufNewFile,BufReadPost *.tex source ~/.vim/vimlatex.vim
au BufNewFile,BufReadPost *.txt source ~/.vim/ftplugin/txt.vim
au BufNewFile,BufReadPost README source ~/.vim/ftplugin/txt.vim
au BufNewFile,BufReadPost tmpmsg.* source ~/.vim/ftplugin/txt.vim
au BufNewFile,BufReadPost *.pl source ~/.vim/vimperl.vim
au BufNewFile,BufReadPost *.html source ~/.vim/vimhtml.vim
au BufNewFile,BufReadPost *.gnuplot source ~/.vim/gnuplot.vim

syntax on

" enable highlighting on the last searched for pattern
set hlsearch

" disable the toolbar.  Too much screen space
set guioptions-=T

highlight Comment guifg=blue

color default

function! GUIText()
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
endfunction

