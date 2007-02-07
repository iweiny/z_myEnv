" Nices for formating this type of text
set formatoptions=tcroqn
set si         " make comments look good.
set sw=3
set hlsearch
set guioptions-=T

set makeprg=%
map <F9> :make<CR>

" map Tab to perform tab completion 'smartly'
function! VimdeCleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-N>"
endfunction
inoremap <Tab> <C-R>=VimdeCleverTab()<CR>
inoremap (<Tab> ()<Esc>i
inoremap (; ();<Esc>hi
inoremap <<Tab> <><Esc>i
inoremap {<Tab> {<CR>}<Esc>ko
inoremap "<Tab> ""<Esc>i
inoremap \"<Tab> \"\"<Esc>hi
inoremap [<Tab> []<Esc>i
inoremap if<Tab> if ()<CR>{<CR>}<Esc>kklllli
inoremap wh<Tab> while ()<CR>{<CR>}<Esc>kkllllllli
inoremap for<Tab> for ()<CR>{<CR>}<Esc>kkllllli
inoremap ret<Tab> return ();<Esc>hi
inoremap sw<Tab> switch ()<CR>{<CR>}<Esc>kklllllllli
inoremap case<Tab> case x:<CR><Tab>break;<Esc>kxi


" the popup menu for convience
set mousemodel=popup_setpos
unmenu PopUp
menu PopUp.-SEP1- <Nop>
menu PopUp.Split\ Buffer :sp<CR>
menu PopUp.Buffer\ Close :q<CR>
menu PopUp.-SEP2- <Nop>

function! PerlHighlightTag(tag)
   let mytag = a:tag
   " delete the existing highlight
   match none
   call search("$", "b") " to end of previous line
   let mytag = substitute(mytag, '\\', '\\\', "")
   call search('\<\V' . mytag . '\>') " position cursor on match
   " add a hightlight group
   hi previewWord term=bold ctermbg=green guibg=green
   " highlight the tag.
	exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
endfunction

" ================================================================
" Build a list of tags for the local file buffer in the popup menu
" Much of this code is borrowed from
"    taglist.vim by Yegappan Lakshmanan
" Much thanks to him.
" ================================================================

" Read the cache of tags for this buffer and change the popup menu
" correctly.
function! PerlBuildPopUpTags()
   if (!exists("b:perl_loc_tag_cnt"))
       return
   endif
   " remove the old tags from the popup menu
   silent! exe ":unmenu PopUp.Symbols"
   silent! exe ":unmenu Symbols"

   " go through the list of tags for this buffer and build the
   " popup menu
   let i = 0
   while i < b:perl_loc_tag_cnt
      " echo b:perl_pu_tag_{i}."\n"
      silent! exe ":menu PopUp.Symbols.".b:perl_pu_tagcmd_{i}
                 \ ."<CR>:call PerlHighlightTag(\""
                 \ .b:perl_pu_tagname_{i}."\")<CR>"
      silent! exe ":menu Symbols.".b:perl_pu_tagcmd_{i}
                 \ ."<CR>:call PerlHighlightTag(\""
                 \ .b:perl_pu_tagname_{i}."\")<CR>"
      let i = i + 1
   endwhile
endfunction

" perl language
let s:tlist_perl_ctags_args = '--language-force=perl --perl-types=ps'

" Create the tag list variables (local to each buffer)
function! PerlPopupFuncList()
   let ftype = &filetype
   let fname = expand('%:p')

   if (!exists("s:tlist_".ftype."_ctags_args"))
      return
   endif

   " Exuberant ctags arguments to generate a tag list
   let ctags_args = ' -f - --format=2 --excmd=pattern --fields=nK '
   let ctags_args = ctags_args . s:tlist_{ftype}_ctags_args

   let ctags_cmd = "ctags" . ctags_args . ' "' . fname . '"'

   let cmd_output = system(ctags_cmd)

   " Handle errors
   if v:shell_error && cmd_output != ''
      echohl WarningMsg | echon cmd_output | echohl None
      return
   endif

   " No tags for current file
   if cmd_output == ''
      echohl WarningMsg
      echomsg 'No tags found for ' . fname
      echohl None
      return
   endif

    " Process the ctags output one line at a time. Separate the tag
    " output based on the tag type and store it in the tag type
    " variable
    let len = strlen(cmd_output)

    " build the tag array for this buffer
    let tag_count = 0

    while cmd_output != ''
        let line_len = stridx(cmd_output, "\n")
        let one_line = strpart(cmd_output, 0, stridx(cmd_output, "\n"))

        " Extract the tag type
        let start = stridx(one_line, '/;"' . "\t") + strlen('/;"' . "\t")
        let end = strridx(one_line, "\t")
        let ttype = strpart(one_line, start, end - start)

        " Extract the tag name
        let ttxt = strpart(one_line, 0, stridx(one_line, "\t"))

        let start = strridx(one_line, ':')
        let lnum = strpart(one_line, start, line_len - start)
        "echo "start: ". start. " end: ".end . " line_len: ". line_len ."\n"
        "echo "tag: " . ttxt . " type: " . ttype . " line: " . lnum . "\n"
        " Set the menus for each buffer which is opened.
        let b:perl_pu_tagcmd_{tag_count} = ttype.".".ttxt." ".lnum
        let b:perl_pu_tagname_{tag_count} = ttxt
        let tag_count = tag_count + 1

        " Remove the processed line
        let cmd_output = strpart(cmd_output, 
                                \ stridx(cmd_output, "\n") + 1, len)
    endwhile

    " store the overall tag count
    let b:perl_loc_tag_cnt = tag_count

    call PerlBuildPopUpTags()

endfunction

" each time a new buffer is entered recreate the tag list
augroup PerlAutoCmds
   autocmd!
   " autocommands to handle building and changing the popup tags list
   autocmd! BufEnter * call PerlBuildPopUpTags()
   autocmd! BufRead * call PerlPopupFuncList()
   autocmd! BufWritePost * call PerlPopupFuncList()
augroup end

call PerlPopupFuncList()

