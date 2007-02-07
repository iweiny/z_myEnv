" Nices for formating this type of text
set formatoptions=tcroqn
set nocindent  " this is not C code
set noai       " don't need this
set si         " make comments look good.
set sw=3
set hlsearch
set guioptions-=T

" Explore window
let g:explDirsFirst=1
let g:explUseSeparators=1
let g:explSuffixesLast=1
let g:explVertical=1
let g:explSplitRight=1
let g:explStartRight=0

" Date and time stamp insertion in a section...
" Pretty ED4 specific
map <F8> o\section*{<Esc>lx:read !date +\%l\:\%M<CR>kJA -- }<Esc>i
imap <F8> <Esc>o\section*{<Esc>lx:read !date +\%l\:\%M<CR>kJA -- }<Esc>i

" make sure we clean this up
inoremap { {}<Esc>i

map <F9> :make<CR>
map <F10> :!gv %<.pdf &<CR>
"set makeprg=pdflatex\ --interaction\ errorstopmode\ %
"set makeprg=cp\ %\ /tmp/tmp.vim.tex;pushd\ /tmp;pdflatex\ /tmp/tmp.vim.tex;popd;cp\ /tmp/tmp.vim.pdf\ %<.pdf
set makeprg=~/.vim/pdflatex.sh\ %\ %<.pdf

noremenu &File.&Print :!pdf2ps %<.pdf /tmp/%<.ps;lpr /tmp/%<.ps

" This parses for the error message from latex.
set efm=%E!\ LaTeX\ %trror:\ %m,
	\%E!\ %m,
   \%Cl.%l\ %m,
	\%+C\ \ %m.,
	\%+C%.%#-%.%#,
	\%+C%.%#[]%.%#,
	\%+C[]%.%#,
	\%+C%.%#%[{}\\]%.%#,
	\%+C<%.%#>%.%#,
	\%C\ \ %m,
   \%-GSee\ the\ LaTeX%m,
	\%-GType\ \ H\ <return>%m,
	\%-G\ ...%.%#,
	\%-G%.%#\ (C)\ %.%#,
	\%-G(see\ the\ transcript%.%#),
   \%-G\\s%#,
   \%+O(%f)%r,
   \%+P(%f%r,
	\%+P\ %\\=(%f%r,
	\%+P%*[^()](%f%r,
	\%+P[%\\d%[^()]%#(%f%r,
   \%+Q)%r,
	\%+Q%*[^()])%r,
	\%+Q[%\\d%*[^()])%r

set path=~/latex/packages/**,./**
map <C-y> :find <cfile>:t.tex<CR>
map <C-g> :!gimp <cfile>&<CR>


" map Tab to perform tab completion 'smartly'
function! VimdeCleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-N>"
endfunction
inoremap <Tab> <C-R>=VimdeCleverTab()<CR>

" commands mappings.
" Control don't work?  Use <Alt>
"map <C-1> o\section*{
map <C-q> o\section*{
map <C-w> o\subsection*{
map <C-e> o\subsubsection*{
map <C-b> {\bf <Esc>li
map <C-u> \underline{<Esc>li
map <C-c> o\begin{center}<CR>\end{center}<Esc>xxkA<CR>

vmap <C-b> "*di{\bf <Esc>p
vmap <C-u> "*di\underline{<Esc>p
vmap <C-q> "*di\section*{ <Esc>p
vmap <C-w> "*di\subsection*{ <Esc>p
vmap <C-e> "*di\subsubsection*{ <Esc>p

imap <C-q> <Esc>o\section*{
imap <C-w> <Esc>o\subsection*{
imap <C-e> <Esc>o\subsubsection*{
imap <C-b> {\bf <Esc>li
imap <C-u> \underline{<Esc>li
imap <C-c> <Esc>o\begin{center}<CR>\end{center}<Esc>xxkA<CR>

" Lists
map Ld o\begin{description}<CR>\item <CR>\end{description}<Esc>kA
map LI o\begin{itemize}<CR>\setlength{\itemsep}{0in}<CR>\item <CR>\end{itemize}<Esc>kA
map Le o\begin{enumerate}<CR>\item <CR>\end{enumerate}<Esc>kA
map Li o<CR>\item 

" Sizes
map Lt i {\tiny 
map Lss i {\scriptsize 
map Lf i {\footnotesize 
map Ls i {\small 
map Ln i {\normalsize 
map Ll i {\large 
map LL i {\Large 
map LLL i {\LARGE 
map Lh i {\huge 
map LH i {\Huge 
map Lsc i\resizebox{!}{XXXin}{

" Agendas
map La o\agItem{X}{

" Insert a template for tabular
function! LaTeXTabularEnv()
   exec "normal o\\begin{tabular}[t|b]{l|r|c|p{xxin}}\<cr>\\hline\<cr>text & text \\\\\<cr>\\hline\<cr>\\end{tabular}\<cr>"
   " delete the extra } inserted by our remap
   exec "normal ddko"
endfunction

" Insert a template for parbox
function! LaTeXParBox()
   exec "normal o\\parbox[t|b][height][t|c|b|s]{width}{\<cr>}\<cr>"
   " delete the extra } inserted by our remap
   exec "normal ddko"
   " position the cursor to insert text in the box
   exec "normal kko"
endfunction

" Insert a template for graphic
function! LaTeXGraphic()
   exec "normal o\\parbox[t|b][height][t|c|b|s]{width}{\<cr>\\includegraphics{foo.jpg}\\\\\<cr>{\\bf caption}\<cr>}\<cr>"
   " delete the extra } inserted by our remap
   exec "normal ddko"
   " position the cursor to insert text in the box
   exec "normal kko"
endfunction

" Latex Menus for the above.
amenu &LaTeX.Insert.Section Lsec
amenu &LaTeX.Insert.SubSection Lssec
amenu &LaTeX.Insert.SubSubSection Lsssec
amenu &LaTeX.Insert.Graphic :call LaTeXGraphic()<CR>
amenu &LaTeX.Insert.Begin\ Env LB
amenu &LaTeX.Insert.End\ Env LE
amenu &LaTeX.Insert.Letter\ Encl :call LaTeXInsertLetterEnclosing()<CR>
amenu &LaTeX.Insert.Letter\ CC :call LaTeXInsertLetterCC()<CR>
amenu &LaTeX.Insert.Table\ Of\ Contents o\tableofcontents<CR><Esc>
amenu &LaTeX.-SEP1- <Nop>
" Boxes and spaces
amenu &LaTeX.Spacing.Paragraph\ Box :call LaTeXParBox()<CR>
amenu &LaTeX.Spacing.Horizontal\ space i\hspace{XXin<Esc>
amenu &LaTeX.Spacing.Vertical\ space i\vspace{XXin<Esc>
amenu &LaTeX.Spacing.Minipage o\begin{minipage<Esc>A{width in<Esc>o\end{minipage<Esc>ko
amenu &LaTeX.Spacing.New\ Length o\newlength{<Esc>li
amenu &LaTeX.Spacing.Add\ Length o\addtolength{<Esc>li
amenu &LaTeX.-SEP2- <Nop>
" Table
amenu &LaTeX.Table.Insert :call LaTeXTabularEnv()<CR>
amenu &LaTeX.Table.Multicolumn i\multicolumn{cols<Esc>la{p{XXin<Esc>la{Text<Esc>
amenu &LaTeX.Table.Vertical\ Line i\vline<Esc>
amenu &LaTeX.-SEP3- <Nop>
" Lists
amenu &LaTeX.Lists.Description Ld
amenu &LaTeX.Lists.Itemize LI
amenu &LaTeX.Lists.Enum Le
amenu &LaTeX.Lists.Item Li
" Styles
amenu &LaTeX.Style.Center Lc
amenu &LaTeX.Style.Bold Lb
amenu &LaTeX.Style.Underline Lu
amenu &LaTeX.Style.SmallCaps LSC
" Color
amenu &LaTeX.Color.Use\ Color o\usepackage{color<Esc>
amenu &LaTeX.Color.Red o\textcolor{red<Esc>A{
amenu &LaTeX.Color.Blue o\textcolor{blue<Esc>A{
amenu &LaTeX.Color.Green o\textcolor{green<Esc>A{
amenu &LaTeX.Color.Yellow o\textcolor{yellow<Esc>A{
" Size
amenu &LaTeX.Size.tiny Lt
amenu &LaTeX.Size.scriptsize Lss
amenu &LaTeX.Size.footnotesize Lf
amenu &LaTeX.Size.small Ls
amenu &LaTeX.Size.normalsize Ln
amenu &LaTeX.Size.large Ll
amenu &LaTeX.Size.Large LL
amenu &LaTeX.Size.LARGE LLL
amenu &LaTeX.Size.huge Lh
amenu &LaTeX.Size.Huge LH
amenu &LaTeX.Size.Custom Lsc

function! LaTeXInsertUsePackage(type)
   exec "normal o\\usepackage{".a:type."}\<cr>"
endfunction

amenu LaTeX.-SEP4- <Nop>
amenu LaTeX.Personal.Personal\ Insert o\input{personal<Esc>A<CR><Esc>
amenu LaTeX.Personal.Navanax.Input o\input{navanax<Esc>A<CR><Esc>
amenu LaTeX.Personal.Navanax.Document o\NavanaxDocument{{$Version$<Esc>A<CR><Esc>
amenu LaTeX.Personal.Navanax.TitlePage o\NavanaxTitlePage{$Author: iweiny $<Esc>A<CR><Esc>
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{$Log: vimlatex.vim,v $
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{Revision 1.1.1.1  2005/01/05 19:11:19  iweiny
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{initial checkin
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{Wed Jan  5 11:11:10 PST 2005
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{Revision 1.8  2003/02/26 22:05:44  iweiny
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{updated spelling in latex files.
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{Revision 1.7  2002/12/13 01:24:21  iweiny
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{Override the File.Print Menu.
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{Changed the build to happen with temp files to no clutter directories.
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{Revision 1.6  2002/09/24 21:07:57  iweiny
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{Major updates to spell check
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{Revision 1.5  2002/09/23 18:43:47  iweiny
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{changed find included file from C-h to C-y
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{Revision 1.4  2002/08/13 07:03:58  iweiny
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{More work on the menus and other things.
amenu LaTeX.Personal.Navanax.ChangeLog o\NavanaxChangeLog{<Esc>A<CR><Esc>
amenu LaTeX.Personal.ED4.Agenda\ Use\ Package :call LaTeXInsertUsePackage("agenda")<CR>
amenu LaTeX.Personal.ED4.Agenda\ Start o\begin{Agenda}{Title}{date}{H}{M}{am/pm}<Esc>
amenu LaTeX.Personal.ED4.Agenda\ Item La
amenu LaTeX.Personal.ED4.Agenda\ End o\end{Agenda<Esc>
amenu LaTeX.Personal.ED4.Banner\ Input\ File o\input{ed4dual-banner<Esc>
amenu LaTeX.Personal.ED4.Banner\ Insert o\edbanner{
amenu LaTeX.Personal.ED4.Calendar\ Text i\caltext{

function! LaTeXInsertLetterEnclosing()
   exec "normal o\\encl{\<cr>"
   exec "normal kA"
endfunction

function! LaTeXInsertLetterCC()
   exec "normal o\\cc{\<cr>"
   exec "normal kA"
endfunction

function! LaTeXInsertDocHeader(type)
   exec "normal o\\documentclass[letter,english]{".a:type."}\<cr>\\begin{document}\<cr>\<cr>\\end{document}\<cr>"
   " delete the extra } inserted by our remap
   exec "normal ddko"
   " position the cursor to insert text in the box
   exec "normal kkko"
   call LaTeXInsertLetterSettings()
   " position the cursor to insert text in the box
   exec "normal jjo"
   if a:type == "letter"
      exec "normal o\\address{Ira Weiny\\\\\<cr>4205 Ruby Ave.\\\\\<cr>San Jose Ca, 95135}\<cr>\<cr>\\begin{letter}{TO: XXXX}\<cr>\\opening{Dear XXXXX}\<cr>\<cr>\\signature{Mr. and Mrs. Ira Weiny}\<cr>\\closing{Thank you,}\<cr>\\end{letter}\<cr>"
      exec "normal ddkkkkko"
   endif
endfunction

function! LaTeXInsertLetterSettings()
   exec "normal o\\setlength{\\topmargin}{0in}\<cr>\\setlength{\\oddsidemargin}{0in}\<cr>\\setlength{\\headheight}{0in}\<cr>\\setlength{\\headsep}{0in}\<cr>\\setlength{\\textwidth}{6.5in}\<cr>\\setlength{\\textheight}{9.0in}\<cr>\\setlength{\\footskip}{0in}\<cr>"
   " delete the extra } inserted by our remap
   exec "normal ddko"
endfunction

function! LaTeXInsertStdSettings()
   exec "normal o\\setlength{\\topmargin}{-0.25in}\<cr>\\setlength{\\oddsidemargin}{-0.5in}\<cr>\\setlength{\\headheight}{0in}\<cr>\\setlength{\\headsep}{0in}\<cr>\\setlength{\\textwidth}{7.5in}\<cr>\\setlength{\\textheight}{9in}\<cr>\\setlength{\\footskip}{0.5in}\<cr>"
   " delete the extra } inserted by our remap
   exec "normal ddko"
endfunction

function! LaTeXInsertStdHeaders()
   exec "normal o\\usepackage{fancyhdr}\<cr>\\usepackage{lastpage}\<cr>\\renewcommand{\\headrulewidth}{0pt}\<cr>\\renewcommand{\\footrulewidth}{1pt}\<cr>\\setlength{\\headwidth}{7.5in}\<cr>\\pagestyle{fancyplain}\<cr>\\lhead{}\<cr>\\chead{}\<cr>\\rhead{}\<cr>\\lfoot{\\footnotesize Brought to you by \\LaTeX on Linux}\<cr>\\cfoot{}\<cr>\\rfoot{\\thepage}\<cr>"
   " delete the extra } inserted by our remap
   exec "normal ddko"
endfunction

function! LaTeXChangeParagraphSpacing()
   exec "normal o\\setlength{\\parindent}{0in}\<cr>\\setlength{\\parsep}{0.125in}\<cr>\\setlength{\\parskip}{0in}\<cr>\\setlength{\\baselineskip}{0in}\<cr>"
   " delete the extra } inserted by our remap
   exec "normal ddko"
endfunction

amenu LaTeX.-SEP5- <Nop>
amenu LaTeX.Article\ Header :call LaTeXInsertDocHeader("article")<CR>
amenu LaTeX.Letter\ Header :call LaTeXInsertDocHeader("letter")<CR>
amenu LaTeX.StdSettings :call LaTeXInsertStdSettings()<CR>
amenu LaTeX.StdHeaders :call LaTeXInsertStdHeaders()<CR>
amenu LaTeX.-SEP6- <Nop>
amenu LaTeX.Change\ Paragraph\ Spacing :call LaTeXChangeParagraphSpacing()<CR>
amenu LaTeX.-SEP7- <Nop>
amenu LaTeX.Print\ PDF :make<CR>:!pdf2ps %<.pdf /tmp/tmp.ps<CR>:!lpr /tmp/tmp.ps

" the popup menu for convience
set mousemodel=popup_setpos
unmenu PopUp
menu PopUp.-SEP2- <Nop>
menu PopUp.Propose\ Alternatives :let @_=ProposeAlternatives()<CR>
menu PopUp.Bold "*di{\bf <Esc>p
menu PopUp.Underline "*di\underline{<Esc>p
menu PopUp.Center o\begin{center}<CR>\end{center}<Esc>xxkA<CR>
menu PopUp.-SEP3- <Nop>
menu PopUp.Undo u
menu PopUp.Spell\ Check :let @_=SpellCheck()<CR>
menu PopUp.End\ Spell\ Check :let @_=ExitSpell()<CR>
menu PopUp.-SEP4- <Nop>
menu PopUp.Save :w<CR>
menu PopUp.Build :make<CR>:!gv %<.pdf<CR>
menu PopUp.Open\ Input\ File :find <cfile>:t.tex<CR>
menu PopUp.Open\ W/\ Gimp :!gimp <cfile><CR>
menu PopUp.Next\ Buffer :bn<CR>
menu PopUp.Prev\ Buffer :bp<CR>

" There is something really wrong with the regions defined below.  For some
" reason I can't get the Spell to highlight in them...
"
" Figure it out later I guess.
"function! SpellRenableHI()
   "syn clear texMatcher
   "syn clear texParen
   "syn clear texError
"
   "silent! AutoSpell
"
   "syn region texMatcher	matchgroup=Delimiter start="{" skip="\\\\\|\\[{}]"	end="}"	contains=@texMatchGroup,texError,Spell fold
   "syn region texMatcher	matchgroup=Delimiter start="\["		end="]"	contains=@texMatchGroup,texError,Spell fold
   "syn region texParen	start="("				end=")"	contains=@texMatchGroup,Spell
   "syn match  texError	"[}\])]"
"endfunction

" Periodically check the spelling.
autocmd! CursorHold * exe "silent! AutoSpell"
"autocmd! CursorHold * exe "silent! call SpellRenableHI()"
set updatetime=1000

syn region texBold matchgroup=texTypeStyle start="{\\bf" end="}" contains=SpellErrors
syn region texUnderline matchgroup=texTypeStyle start="\\underline{" end="}" contains=SpellErrors
syn region texBoldSection matchgroup=texSection start="\\section{" start="\\section\*{" end="}" contains=SpellErrors
syn region texBoldSubSection matchgroup=texSection start="\\subsection{" start="\\subsection\*{" end="}" contains=SpellErrors
syn region texBoldSubSubSection matchgroup=texSection start="\\subsubsection{" start="\\subsubsection\*{" end="}" contains=SpellErrors

syn match texItem "\\item"

hi UnderlineBoldBlue gui=underline,bold guifg=Blue
hi BoldBlue gui=bold guifg=Blue
hi UnderlineBlue gui=underline guifg=Blue
hi def link texBoldSection UnderlineBoldBlue
hi def link texBoldSubSection BoldBlue
hi def link texBoldSubSubSection UnderlineBlue

hi UnderlinedBlack term=underline cterm=underline ctermfg=5 gui=underline guifg=Black
hi def link texBold ModeMsg
hi def link texUnderline UnderlinedBlack
hi def link texItem ModeMsg
hi Statement guifg=Grey


" For now this allows for spell check where I need it.
syn clear texMatcher
syn clear texParen
syn clear texError

" Try this
"syn region texMatcher	matchgroup=Delimiter start="{" skip="\\\\\|\\[{}]"	end="}"	contains=@texMatchGroup,texError,SpellErrors fold
"syn region texMatcher	matchgroup=Delimiter start="\["		end="]"	contains=@texMatchGroup,texError,SpellErrors fold
"syn region texParen	start="("				end=")" contains=@texMatchGroup,SpellErrors
"syn match  texError	"[}\])]"

