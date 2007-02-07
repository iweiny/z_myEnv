" Vim syntax file
" Language:	Pilrc
" Maintainer:	Ira Weiny
" Last change:	2000 Jan 23

" Remove any old syntax stuff hanging around
syn clear

" A bunch of useful pilrc keywords
syn keyword	rcpResource	FORM MENU ALERT VERSION STRING APPLICATIONICONNAME APPLICATION ICON BITMAP BITMAPGREY TRAP TRANSLATION BEGIN END

syn keyword	rcpObject	TITLE BUTTON PUSHBUTTON CHECKBOX POPUPTRIGGER SELECTORTRIGGER REPEATBUTTON LABEL FIELD POPUPLIST LIST FORMBITMAP GADGET TABLE SCROLLBAR GRAFFITISTATEINDICATOR MESSAGE BUTTONS PULLDOWN MENUITEM

syn keyword	rcpKeyword	AUTOID AUTO CENTER RIGHT BOTTOM PREVLEFT PREVRIGHT PREVTOP PREVBOTTOM PREVWIDTH PREVHEIGHT ID AT SEPARATOR INFORMATION CONFIRMATION WARNING ERROR

syn keyword	rcpAttribute	USABLE NONUSABLE DISABLED LEFTANCHOR RIGHTANCHOR FRAME NOFRAME BOLDFRAME FONT GROUP CHECKED LEFTALIGN RIGHTALIGN EDITABLE NONEDITABLE UNDERLINED SINGLELINE MULTIPLELINES DYNAMICSIZE MAXCHARS AUTOSHIFT NUMERIC VISIBLEITEMS ROWS COLUMNS COLUMNWIDTHS VALUE MIN MAX PAGESIZE NOCOMPRESS COMPRESS = MODAL MENUID

" String and Character constants
" Highlight special characters (those which have a backslash) differently
syn region	rcpString		start=+"+ skip=+\\\\\|\\"+ end=+"+

"catch errors caused by wrong parenthesis
syn cluster	rcpParenGroup	contains=rcpParenError,rcpIncluded
syn region	rcpParen	transparent start='(' end=')' contains=ALLBUT,@rcpParenGroup
syn match	rcpParenError	")"

"integer number, or floating point number without a dot and with "f".
syn case ignore
syn match	rcpNumber		"\<\d\+\(u\=l\=\|lu\|f\)\>"
"floating point number, with dot, optional exponent

syn region	rcpIncluded	contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match	rcpIncluded	contained "<[^>]*>"

" comments
syn region    rcpComment        start="/\*" end="\*/" contains=cTodo,cSpaceError
syn match     rcpComment        "//.*" contains=cTodo,cSpaceError

syntax match    rcpCommentError   "\*/"

" The default methods for highlighting.  Can be overridden later
hi link rcpResource	Statement
hi link rcpObject	   StorageClass
hi link rcpKeyword	String
hi link rcpAttribute	PreProc
hi link rcpNumber	Identifier
hi link rcpParenError	Error
hi link rcpCommentError	Error
hi link rcpIncluded	rcpString
hi link rcpString	Identifier
hi link rcpComment Comment

hi Identifier guifg=blue
hi PreProc    guifg=red

