" Vim syntax file for Tcl/tk language
" Language:	Tcl
" Maintained:	SM Smithfield <sm.smithfield@gmail.com>
" Last Change:	4/28/2016 (18:56)
" Filenames:    *.tcl
" Version:      0.6
" ------------------------------------------------------------------
" GetLatestVimScripts: 1603 1 :AutoInstall: syntax/tcl.vim
" ------------------------------------------------------------------

" -------------------------

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Highlight Options: restart vim, after changing these options.
" let s:tcl_highlight_lcs_are_warnings = 1
let s:tcl_comments_ignore_nested_braces = 1
let s:tcl_highlight_namespace_bold = 1
" "
" let s:tcl_highlight_bookends = 1
" let s:tcl_highlight_primary = 1
" let s:tcl_highlight_expressions = 1
" let s:tcl_highlight_variables = 1
" let s:tcl_highlight_secondary = 1
" let s:tcl_highlight_options = 1
let s:tcl_highlight_all = 1


" Extended Syntax:
" let s:tcl_snit_active = 1
let s:tcl_sqlite_active = 1
" let s:tcl_critcl_active = 1
" let s:tcl_togl_active = 1
" let s:tcl_itcl_active = 1
" let s:tcl_ttk_active = 1

" one more highlight than the law allows
if exists("s:tcl_highlight_bookends")
    if !hlexists("Bold")
        hi Bold guifg=fg guibg=bg gui=bold
        if version > 700
            " on colorscheme, create Bold
            augroup tclsyntax
                au!
                au ColorScheme * hi Bold guifg=fg guibg=bg gui=bold
            augroup end
        endif
    endif
endif

" -------------------------
" Basics:
" -------------------------
syn match tclKeywordGroup contained "\([^\[{ ]\)\@<!\w\+" contains=@tclKeywords,@tkKeywords
" see Note in :h /\@=
syn region tclWord1       contained start=+[^\[#{}"\]]\&\S+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tclStuff
syn region tclWord0       contained start=+[^#]\&\S+ end=+\s\|$+ contains=@tclWord0Cluster skipwhite nextgroup=@tclWord1Cluster
syn region tclQuotes      contained extend keepend matchgroup=tclQuotes start=+\(\\\)\@<!"+ end=+"+ skip=+\(\\\)\@<!\\"\|\(\\\\\\\)\@<!\\"\|\\\\+ contains=@tclQuotesCluster
syn region tclBrackets    contained extend keepend matchgroup=Bold start=+\(\\\)\@<!\[+ end=+]\|$+ skip=+\\\s*$\|\(\\\)\@<!\\]+ contains=@tclCommandCluster
syn region tclBraces      contained extend keepend matchgroup=Bold start=+\(\\\)\@<!{+  end=+}+ skip=+$\|\(\\\)\@<!\\}+         contains=@tclCommandCluster
syn region tclFoldBraces  contained extend keepend fold matchgroup=Bold start=+\(\\\)\@<!{+ end=+}+ skip=+$\|\(\\\)\@<!\\}+     contains=@tclCommandCluster
syn match  tclSemiColon   contained ";\s*" skipwhite nextgroup=@tclCommandCluster
syn match  tclSingleQuote contained +"\ze[^["{]\{-}\(\\\)\@<![}\]]+ 
syn match  tclSingleBracket contained +\[\ze[^\]{]\{-}}+
if exists("s:tcl_comments_ignore_nested_braces")
    syn region tclComment    contained extend keepend start=+^\s*\#+ms=e-1 start=+\([;{]\s*\)\@<=\#+ end="\\\s\+$\|$" skip=+\\$+ contains=tclTodo,@tclLContinue,@Spell
else
    syn region tclComment       contained extend keepend start=+^\s*\#+ms=e-1 start=+\([;{]\s*\)\@<=\#+ end="\\\s\+$\|$" skip=+\\$\|\(\\\)\@<!\\}+ end="}"me=e-1 contains=tclTodo,@tclLContinue,@Spell,tclCommentBraces
    syn region tclCommentBraces contained extend keepend matchgroup=Comment start=+\(\\\)\@<!{+  end=+}+ skip=+$\|\(\\\)\@<!\\}+ 
endif

syn region tclCommand start=+[^;]+ skip=+\\$+ end=+;\|$+ contains=@tclCommandCluster

syn match  tclStart "\%^\s*#!.*$"
syn region tclStart start="\%^\s*#!/bin/sh"  end="^\s*exec.*$"


" -------------------------
" Clusters:
" -------------------------
syn cluster tclKeywords        contains=tclPrimary,tclKeyword,tclException,tclConditional,tclRepeat,tclLabel,tclMagicName,tclNamespace
syn cluster tkKeywords         contains=tkKeyword,tkReserved,tkWidget,tkDialog
syn cluster tcltkKeywords      contains=@tclKeywords,@tkKeywords
" ------------------
syn cluster tclLContinue       contains=tclLContinueOk,tclLContinueError
syn cluster tclBits            contains=@tclLContinue,tclBraces,tclBrackets,tclQuotes,tclSingleQuote,tclSingleBracket,tclComment,tclExpand,tclNumber,tclSpecial,tkColor,tkEvent,tclSemiColon
syn cluster tclStuff           contains=@tclBits,tclVariable,tkBindSubstGroup,tkWidgetName,tclREClassGroup
syn cluster tclWord0Cluster    contains=@tclStuff
syn cluster tclWord1Cluster    contains=@tclStuff,tclWord1,tclSecondary,tkWidgetCreate,tclConditional
syn cluster tclQuotesCluster   contains=tclSpecial,@tclLContinue,@Spell,tclBrackets,tclVariable
syn cluster tclCommandCluster  contains=@tcltkKeywords,tclWord0,tclComment
" ------------------


" -------------------------
" Tcl: Syntax
" -------------------------
syn keyword tclKeyword      contained append apply auto_execok auto_import auto_load auto_mkindex auto_qualify auto_reset cd close concat coroutine eof exit fblocked flush format gets global http incr join lappend lassign lindex linsert llength load lrange lrepeat lreplace lreverse lset namespace parray pid pkg_mkIndex proc pwd registry rename return scan set split tclLog tcl_endOfWord tcl_findLibrary tcl_startOfNextWord tcl_startOfPreviousWord tcl_wordBreakAfter tcl_wordBreakBefore tell time unknown upvar variable vwait yield yieldto zlib skipwhite nextgroup=tclPred
syn keyword tclMagicName    contained argc argv argv0 auto_index auto_oldpath auto_path env errorCode errorInfo tcl_interactive tcl_libpath tcl_library tlc_patchlevel tcl_pkgPath tcl_platform tcl_precision tcl_rcFileName tcl_rcRsrcName tcl_traceCompile tcl_traceExec tcl_version
" ------------------
syn keyword tkKeyword       contained bell bind clipboard console consoleinterp event focus grid pack place tkwait winfo wm
syn keyword tkKeyword       contained bindtags destroy lower option raise send tkerror tkwait tk_bisque tk_focusNext tk_focusPrev tk_focusFollowsMouse tk_popup tk_setPalette tk_textCut tk_TextCopy tk_textPaste skipwhite nextgroup=tclPred
syn keyword tkDialog        contained chooseColor tk_chooseColor tk_chooseDirectory tk_dialog tkDialog tk_messageBox
syn keyword tkReserved      contained tk_library tk_strictMotif tk_version
syn keyword tkWidget        contained button canvas checkbutton entry frame image label labelframe listbox menu menubutton message panedwindow radiobutton scale scrollbar spinbox toplevel skipwhite nextgroup=tkWidgetPredicate
" TODO widgets that are NOT part of tk
syn keyword tkWidget        contained table mclistbox skipwhite nextgroup=tkWidgetPredicate

syn region tclPred contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tclStuff

" CONDITIONALS
syn keyword tclPrimary      contained if skipwhite nextgroup=tclIfCommentStart,tclExpression,@tclStuff
syn keyword tclConditional  contained elseif skipwhite nextgroup=tclExpression,@tclStuff
syn keyword tclConditional  contained else then

" REPEAT
" syn keyword tclRepeat       contained for skipwhite nextgroup=tclForStart,@tclStuff
syn keyword tclRepeat       contained for skipwhite nextgroup=tclForStart
syn match tclForStart       contained extend "\s*{[^}]\{-}}" contains=@tclCommandCluster skipwhite nextgroup=tclExpression,@tclStuff
syn keyword tclRepeat       contained while skipwhite nextgroup=tclExpression,@tclStuff
syn keyword tclRepeat       contained foreach skipwhite nextgroup=tclPred
syn keyword tclRepeat       contained break continue
syn keyword tclLabel        contained default
syn keyword tclException    contained catch error

" EXPRESSION - that presumes to be an expression, occurs in expr, conditional, loops, etc...
syn keyword tclPrimary      contained expr skipwhite nextgroup=tclExpression
syn match  tclExpression    contained "\\" skipwhite skipnl nextgroup=tclExpression contains=tclLContinueOk
syn match  tclExpression    contained extend "\\\s\+$" contains=tclLContinueError
syn region tclExpression    contained extend start=+[^ {\\]+ skip=+\\$+ end=+}\|]\|;\|$+me=e-1 contains=tclMaths,@tclStuff
" NOTE: must include '\s*' in start, for while etc don't work w/o it, I think
" this is because matching the whitespace allows the expression to supercede
" the other regions
syn region tclExpression    contained keepend extend matchgroup=Bold start=+\s*{+ end=+}+ skip=+$\|\\}+ contains=tclMaths,@tclStuff
syn keyword tclMaths        contained abs acos asin atan atan2 bool ceil cos cosh double entier exp floor fmod hypot int isqrt log log10 max min pow rand round sin sinh sqrt srand tan tanh wide
syn keyword tclMaths        contained ne eq in ni
syn match tclMaths          contained "[()^%~<>!=+*\-|&?:/,]"

" IF - permits use of if{0} {} commenting idiom
syn region tclIfComment     contained extend keepend matchgroup=Comment start=+\(\\\)\@<!{+  skip=+$\|\\}+ end=+}+ contains=tclIfComment,tclTodo,@Spell
syn match tclIfCommentStart contained extend  "\s*\(0\|{0}\)" skipwhite nextgroup=tclIfComment

" PROC - proc name hilite AND folding
syn keyword tclPrimary      contained proc skipwhite nextgroup=tclProcName
" def-script pattern
syn match tclProcDef        contained "\S\+" skipwhite nextgroup=tclFoldBraces
" type-name-args-script pattern
syn match tclProcType       contained "\S\+" skipwhite nextgroup=tclProcName
syn match tclProcName       contained "\S\+" skipwhite nextgroup=tclProcArgs
syn region tclProcArgs      contained extend keepend excludenl matchgroup=Bold start=+\(\\\)\@<!{+  skip=+$\|\\}+ end=+}+ contains=tclProcArgs skipwhite nextgroup=tclFoldBraces


" -------------------------
" Tcl: Syntax - Bits
" -------------------------
syn keyword tclTodo         contained TODO note
syn match tkEvent           contained "<\S\+>"
syn match tkEvent           contained "<<.\+>>"
syn match tkColor           contained "#[0-9A-Fa-f]\{6}\|#[0-9A-Fa-f]\{3}"
syn match tclNumber         contained "\<\d\+\(u\=l\=\|lu\|f\|L\)\>"
syn match tclNumber         contained "\<\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\=\>"
syn match tclNumber         contained "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
syn match tclNumber         contained "\<\d\+e[-+]\=\d\+[fl]\=\>"
syn match tclNumber         contained "0x[0-9a-f]\+\(u\=l\=\|lu\)\>"
syn match tclVariable       contained "\$\(\(:\{2,}\)\?\([[:alnum:]_]*::\)*\)[[:alnum:]_]*"
syn region tclVariable      contained start=+\$\(\(:\{2,}\)\?\([[:alnum:]_]*::\)*\)[[:alnum:]_]\+(+ skip=+\\)+ end=+)+ contains=@tclStuff
syn match tclVariable       contained extend "${[^}]*}"
syn match tclSpecial        contained "\\\d\d\d\=\|\\."
syn match tkWidgetName      contained "\([[:alnum:]]\)\@<!\.[[:alpha:]][[:alnum:]]*\(\.[[:alpha:]][[:alnum:]]*\)*\>"
if exists("s:tcl_highlight_lcs_are_warnings")
    syn match tclLContinueOk    contained "\\$"
else
    syn match tclLContinueOk    contained "\\$" transparent
endif
syn match tclLContinueError contained "\\\s\+$" excludenl
syn match tclExpand         contained extend "{expand}"
syn match tclExpand         contained extend "{\*}"
syn match tclREClassGroup   contained extend +\(\\\)\@<!\[^\?\[:\(\w\+\|[<>]\):]_\?]+  contains=tclREClass
syn keyword tclREClass contained alpha upper lower digit xdigit alnum print blank space punct graph cntrl 



" -------------------------
" Tcl: Syntax - Keyword Predicates
" -------------------------

" SPECIAL CASE: predicate can contain a command 
syn region tclListPred contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tclCommandCluster
syn keyword tclPrimary contained eval list skipwhite nextgroup=tclListPred


" SPECIAL CASE: contains a command and a level
syn region tclUplevelPred contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tclCommandCluster
syn match tclUplevelLevel contained "\S\+" contains=@tclCommandCluster skipwhite nextgroup=tclUplevelPred
syn keyword tclPrimary contained uplevel skipwhite nextgroup=tclUplevelLevel


" SPECIAL CASE: FOLDING
syn keyword tclPrimary                        contained namespace skipwhite nextgroup=tclNamespacePred
syn keyword tclNamespaceCmds                  contained children code current delete eval exists forget inscope origin parent path qualifiers tail unknown upvar
syn region tclNamespacePred                   contained keepend fold start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclNamespaceCmds,tclNamespaceEnsemble,@tclStuff
syn match tclNamespaceExportOptsGroup         contained "-\a\+" contains=tclNamespaceExportOpts
syn keyword tclNamespaceExportOpts            contained clear force command variable
syn region tclNamespaceExportPred             contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclNamespaceExportOptsGroup,@tclStuff
syn keyword tclNamespaceCmds                  contained export import which skipwhite nextgroup=tclNamespaceExportPred
syn match tclNamespaceEnsembleExistsOptsGroup contained "-\a\+" contains=tclNamespaceEnsembleExistsOpts
syn keyword tclNamespaceEnsembleExistsOpts    contained map prefixes subcommand[s] unknown command namespace
syn region tclNamespaceEnsembleExistsPred     contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclNamespaceEnsembleExistsOptsGroup,@tclStuff
syn keyword tclNamespaceEnsembleCmds          contained exists create configure skipwhite nextgroup=tclNamespaceEnsembleExistsPred
syn region tclNamespaceEnsemblePred           contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclNamespaceEnsembleCmds,@tclStuff
syn keyword tclNamespaceEnsemble              contained ensemble skipwhite nextgroup=tclNamespaceEnsemblePred


syn keyword tclPrimary contained puts read skipwhite nextgroup=tclPutsPred
syn region tclPutsPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclPutsOptsGroup,@tclStuff
syn match tclPutsOptsGroup contained "-\a\+" contains=tclPutsOpts
syn keyword tclPutsOpts contained nonewline

syn keyword tclPrimary contained return skipwhite nextgroup=tclReturnPred
syn region tclReturnPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclReturnOptsGroup,@tclStuff
syn match tclReturnOptsGroup contained "-\a\+" contains=tclReturnOpts
syn keyword tclReturnOpts contained code errorcode errorinfo level options

syn keyword tclPrimary contained source skipwhite nextgroup=tclSourcePred
syn region tclSourcePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclSourceOptsGroup,@tclStuff
syn match tclSourceOptsGroup contained "-\a\+" contains=tclSourceOpts
syn keyword tclSourceOpts contained encoding

syn keyword tclPrimary contained after skipwhite nextgroup=tclAfterPred
syn region tclAfterPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclAfterCmds,@tclStuff
syn keyword tclAfterCmds contained cancel idle info skipwhite nextgroup=tclAfterCmdsCancelPred
syn region tclAfterCmdsCancelPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained array skipwhite nextgroup=tclArrayPred
syn region tclArrayPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclArrayCmds,@tclStuff
syn keyword tclArrayCmds contained anymore donesearch exists get nextelement set size startsearch statistics unset skipwhite nextgroup=tclArrayCmdsAnymorePred
syn region tclArrayCmdsAnymorePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tclArrayCmdsNamesOptsGroup contained "-\a\+" contains=tclArrayCmdsNamesOpts
syn keyword tclArrayCmdsNamesOpts contained exact glob regexp
syn keyword tclArrayCmds contained names skipwhite nextgroup=tclArrayCmdsNamesPred
syn region tclArrayCmdsNamesPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclArrayCmdsNamesOptsGroup,@tclStuff skipwhite nextgroup=tclArrayCmds

syn keyword tclPrimary contained binary skipwhite nextgroup=tclBinaryPred
syn region tclBinaryPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclBinaryCmds,@tclStuff
syn keyword tclBinaryCmds contained format scan skipwhite nextgroup=tclBinaryCmdsFormatPred
syn region tclBinaryCmdsFormatPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained encoding skipwhite nextgroup=tclEncodingPred
syn region tclEncodingPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclEncodingCmds,@tclStuff
syn keyword tclEncodingCmds contained convertfrom convertto dirs names system skipwhite nextgroup=tclEncodingCmdsConvertfromPred
syn region tclEncodingCmdsConvertfromPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained info skipwhite nextgroup=tclInfoPred
syn region tclInfoPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclInfoCmds,@tclStuff
syn keyword tclInfoCmds contained args body cmdcount commands complete coroutine default exists frame functions globals hostname level library loaded locals nameofexecutable patchlevel procs script sharedlibextension tclversion vars skipwhite nextgroup=tclInfoCmdsArgsPred
syn region tclInfoCmdsArgsPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained memory skipwhite nextgroup=tclMemoryPred
syn region tclMemoryPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclMemoryCmds,@tclStuff
syn keyword tclMemoryCmds contained active break info init onexit tag trace validate skipwhite nextgroup=tclMemoryCmdsActivePred
syn region tclMemoryCmdsActivePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained update skipwhite nextgroup=tclUpdatePred
syn region tclUpdatePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclUpdateCmds,@tclStuff
syn keyword tclUpdateCmds contained idletasks skipwhite nextgroup=tclUpdateCmdsIdletasksPred
syn region tclUpdateCmdsIdletasksPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained exec skipwhite nextgroup=tclExecPred
syn region tclExecPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclExecOptsGroup,@tclStuff
syn match tclExecOptsGroup contained "-\a\+" contains=tclExecOpts
syn keyword tclExecOpts contained keepnewline ignorestderr

syn keyword tclPrimary contained glob skipwhite nextgroup=tclGlobPred
syn region tclGlobPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclGlobOptsGroup,@tclStuff
syn match tclGlobOptsGroup contained "-\a\+" contains=tclGlobOpts
syn keyword tclGlobOpts contained directory join nocomplain path tails type[s]

syn keyword tclPrimary contained regexp skipwhite nextgroup=tclRegexpPred
syn region tclRegexpPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclRegexpOptsGroup,@tclStuff
syn match tclRegexpOptsGroup contained "-\a\+" contains=tclRegexpOpts
syn keyword tclRegexpOpts contained about expanded indices line linestop lineanchor nocase all inline start

syn keyword tclPrimary contained regsub skipwhite nextgroup=tclRegsubPred
syn region tclRegsubPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclRegsubOptsGroup,@tclStuff
syn match tclRegsubOptsGroup contained "-\a\+" contains=tclRegsubOpts
syn keyword tclRegsubOpts contained all expanded line linestop nocase start

syn keyword tclPrimary contained switch skipwhite nextgroup=tclSwitchPred
syn region tclSwitchPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclSwitchOptsGroup,@tclStuff
syn match tclSwitchOptsGroup contained "-\a\+" contains=tclSwitchOpts
syn keyword tclSwitchOpts contained exact glob regexp nocase matchvar indexvar

syn keyword tclPrimary contained unload skipwhite nextgroup=tclUnloadPred
syn region tclUnloadPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclUnloadOptsGroup,@tclStuff
syn match tclUnloadOptsGroup contained "-\a\+" contains=tclUnloadOpts
syn keyword tclUnloadOpts contained nocomplain keeplibrary

syn keyword tclPrimary contained unset skipwhite nextgroup=tclUnsetPred
syn region tclUnsetPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclUnsetOptsGroup,@tclStuff
syn match tclUnsetOptsGroup contained "-\a\+" contains=tclUnsetOpts
syn keyword tclUnsetOpts contained nocomplain

syn keyword tclPrimary contained subst skipwhite nextgroup=tclSubstPred
syn region tclSubstPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclSubstOptsGroup,@tclStuff
syn match tclSubstOptsGroup contained "-\a\+" contains=tclSubstOpts
syn keyword tclSubstOpts contained nocommands novariables nobackslashes

syn keyword tclPrimary contained lsearch skipwhite nextgroup=tclLsearchPred
syn region tclLsearchPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclLsearchOptsGroup,@tclStuff
syn match tclLsearchOptsGroup contained "-\a\+" contains=tclLsearchOpts
syn keyword tclLsearchOpts contained exact glob regexp sorted all inline not ascii dictionary integer nocase real decreasing increasing subindices
syn match tclLsearchOptsGroup contained "-\a\+" contains=tclLsearchOpts
syn keyword tclLsearchOpts contained start index

syn keyword tclPrimary contained lsort skipwhite nextgroup=tclLsortPred
syn region tclLsortPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclLsortOptsGroup,@tclStuff
syn match tclLsortOptsGroup contained "-\a\+" contains=tclLsortOpts
syn keyword tclLsortOpts contained ascii dictionary integer real increasing decreasing indicies nocase unique
syn match tclLsortOptsGroup contained "-\a\+" contains=tclLsortOpts
syn keyword tclLsortOpts contained command index

syn keyword tclPrimary contained fconfigure skipwhite nextgroup=tclFconfigurePred
syn region tclFconfigurePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclFconfigureOptsGroup,@tclStuff
syn match tclFconfigureOptsGroup contained "-\a\+" contains=tclFconfigureOpts
syn keyword tclFconfigureOpts contained blocking buffering buffersize encoding eofchar error
syn match tclFconfigureOptsGroup contained "-\a\+" contains=tclFconfigureOpts
syn keyword tclFconfigureOpts contained translation

syn keyword tclPrimary contained fcopy skipwhite nextgroup=tclFcopyPred
syn region tclFcopyPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclFcopyOptsGroup,@tclStuff
syn match tclFcopyOptsGroup contained "-\a\+" contains=tclFcopyOpts
syn keyword tclFcopyOpts contained size command

syn keyword tclPrimary contained socket skipwhite nextgroup=tclSocketPred
syn region tclSocketPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclSocketOptsGroup,@tclStuff
syn match tclSocketOptsGroup contained "-\a\+" contains=tclSocketOpts
syn keyword tclSocketOpts contained server myaddr myport async myaddr error sockname peername

syn keyword tclPrimary contained fileevent skipwhite nextgroup=tclFileeventPred
syn region tclFileeventPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclFileeventCmds,@tclStuff
syn keyword tclFileeventCmds contained readable writable skipwhite nextgroup=tclFileeventCmdsReadablePred
syn region tclFileeventCmdsReadablePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained open skipwhite nextgroup=tclOpenPred
syn region tclOpenPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclOpenOptsGroup,@tclStuff
syn match tclOpenOptsGroup contained "-\a\+" contains=tclOpenOpts
syn keyword tclOpenOpts contained mode handshake queue timeout ttycontrol ttystatus xchar pollinterval sysbuffer lasterror

syn keyword tclPrimary contained seek skipwhite nextgroup=tclSeekPred
syn region tclSeekPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclSeekCmds,@tclStuff
syn keyword tclSeekCmds contained start current end skipwhite nextgroup=tclSeekCmdsStartPred
syn region tclSeekCmdsStartPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained clock skipwhite nextgroup=tclClockPred
syn region tclClockPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclClockCmds,@tclStuff
syn keyword tclClockCmds contained microseconds milliseconds seconds skipwhite nextgroup=tclClockCmdsMicrosecondsPred
syn region tclClockCmdsMicrosecondsPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tclClockCmdsAddOptsGroup contained "-\a\+" contains=tclClockCmdsAddOpts
syn keyword tclClockCmdsAddOpts contained base format gmt locale timezone
syn keyword tclClockCmds contained add clicks format scan skipwhite nextgroup=tclClockCmdsAddPred
syn region tclClockCmdsAddPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclClockCmdsAddOptsGroup,@tclStuff skipwhite nextgroup=tclClockCmds

syn keyword tclPrimary contained dict skipwhite nextgroup=tclDictPred
syn region tclDictPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclDictCmds,@tclStuff
syn keyword tclDictCmds contained append create exists for get incr info keys lappend merge remove replace set size unset update values with skipwhite nextgroup=tclDictCmdsAppendPred
syn region tclDictCmdsAppendPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tclDictCmdsFilterOptsGroup contained "-\a\+" contains=tclDictCmdsFilterOpts
syn keyword tclDictCmdsFilterOpts contained key script value
syn keyword tclDictCmds contained filter skipwhite nextgroup=tclDictCmdsFilterPred
syn region tclDictCmdsFilterPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclDictCmdsFilterOptsGroup,@tclStuff skipwhite nextgroup=tclDictCmds

syn keyword tclPrimary contained chan skipwhite nextgroup=tclChanPred
syn region tclChanPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclChanCmds,@tclStuff
syn keyword tclChanCmds contained blocked close create eof event flush gets names pending postevent seek tell truncate skipwhite nextgroup=tclChanCmdsBlockedPred
syn region tclChanCmdsBlockedPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tclChanCmdsConfigureOptsGroup contained "-\a\+" contains=tclChanCmdsConfigureOpts
syn keyword tclChanCmdsConfigureOpts contained blocking buffering buffersize encoding eofchar translation
syn keyword tclChanCmds contained configure skipwhite nextgroup=tclChanCmdsConfigurePred
syn region tclChanCmdsConfigurePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclChanCmdsConfigureOptsGroup,@tclStuff skipwhite nextgroup=tclChanCmds
syn match tclChanCmdsCopyOptsGroup contained "-\a\+" contains=tclChanCmdsCopyOpts
syn keyword tclChanCmdsCopyOpts contained size command
syn keyword tclChanCmds contained copy skipwhite nextgroup=tclChanCmdsCopyPred
syn region tclChanCmdsCopyPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclChanCmdsCopyOptsGroup,@tclStuff skipwhite nextgroup=tclChanCmds
syn match tclChanCmdsPutsOptsGroup contained "-\a\+" contains=tclChanCmdsPutsOpts
syn keyword tclChanCmdsPutsOpts contained nonewline
syn keyword tclChanCmds contained puts read skipwhite nextgroup=tclChanCmdsPutsPred
syn region tclChanCmdsPutsPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclChanCmdsPutsOptsGroup,@tclStuff skipwhite nextgroup=tclChanCmds
syn keyword tclSecondary contained initialize finalize watch read write seek configure cget cgetall blocking skipwhite nextgroup=tclChanSUBInitializePred
syn region tclChanSUBInitializePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tclStuff

syn keyword tclPrimary contained file skipwhite nextgroup=tclFilePred
syn region tclFilePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclFileCmds,@tclStuff
syn keyword tclFileCmds contained channels dirname executable exists extension isdirectory isfile join link lstat mkdir mtime nativename normalize owned pathtype readable readlink rootname separator size split stat system tail volumes writable skipwhite nextgroup=tclFileCmdsChannelsPred
syn region tclFileCmdsChannelsPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tclFileCmdsAtimeOptsGroup contained "-\a\+" contains=tclFileCmdsAtimeOpts
syn keyword tclFileCmdsAtimeOpts contained time
syn keyword tclFileCmds contained atime skipwhite nextgroup=tclFileCmdsAtimePred
syn region tclFileCmdsAtimePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclFileCmdsAtimeOptsGroup,@tclStuff skipwhite nextgroup=tclFileCmds
syn match tclFileCmdsCopyOptsGroup contained "-\a\+" contains=tclFileCmdsCopyOpts
syn keyword tclFileCmdsCopyOpts contained force
syn keyword tclFileCmds contained copy delete rename skipwhite nextgroup=tclFileCmdsCopyPred
syn region tclFileCmdsCopyPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$\|--+ contains=tclFileCmdsCopyOptsGroup,@tclStuff skipwhite nextgroup=tclFileCmds
syn match tclFileCmdsAttributesOptsGroup contained "-\a\+" contains=tclFileCmdsAttributesOpts
syn keyword tclFileCmdsAttributesOpts contained group owner permissions readonly archive hidden longname shortname system creator rsrclength
syn keyword tclFileCmds contained attributes skipwhite nextgroup=tclFileCmdsAttributesPred
syn region tclFileCmdsAttributesPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclFileCmdsAttributesOptsGroup,@tclStuff skipwhite nextgroup=tclFileCmds

syn keyword tclPrimary contained history skipwhite nextgroup=tclHistoryPred
syn region tclHistoryPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclHistoryCmds,@tclStuff
syn keyword tclHistoryCmds contained change clear event info keep nextid redo skipwhite nextgroup=tclHistoryCmdsChangePred
syn region tclHistoryCmdsChangePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn keyword tclHistoryCmdsAddCmds contained exec skipwhite nextgroup=tclHistoryCmdsAddCmdsExecPred
syn region tclHistoryCmdsAddCmdsExecPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn keyword tclHistoryCmds contained add skipwhite nextgroup=tclHistoryCmdsAddPred
syn region tclHistoryCmdsAddPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclHistoryCmdsAddCmds,@tclStuff skipwhite nextgroup=tclHistoryCmds

syn keyword tclPrimary contained package skipwhite nextgroup=tclPackagePred
syn region tclPackagePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclPackageCmds,@tclStuff
syn keyword tclPackageCmds contained forget ifneeded names provide unknown vcompare versions vsatisfies prefer skipwhite nextgroup=tclPackageCmdsForgetPred
syn region tclPackageCmdsForgetPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tclPackageCmdsPresentOptsGroup contained "-\a\+" contains=tclPackageCmdsPresentOpts
syn keyword tclPackageCmdsPresentOpts contained exact
syn keyword tclPackageCmds contained present require skipwhite nextgroup=tclPackageCmdsPresentPred
syn region tclPackageCmdsPresentPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclPackageCmdsPresentOptsGroup,@tclStuff skipwhite nextgroup=tclPackageCmds


syn keyword tclPrimary contained string skipwhite nextgroup=tclStringPred
syn region tclStringPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclStringCmds,@tclStuff
syn keyword tclStringCmds contained bytelength first index last length range repeat replace reverse tolower totitle toupper trim trimleft trimright wordend wordstart skipwhite nextgroup=tclStringCmdsBytelengthPred
syn region tclStringCmdsBytelengthPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tclStringCmdsCompareOptsGroup contained "-\a\+" contains=tclStringCmdsCompareOpts
syn keyword tclStringCmdsCompareOpts contained nocase length
syn keyword tclStringCmds contained compare equal skipwhite nextgroup=tclStringCmdsComparePred
syn region tclStringCmdsComparePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclStringCmdsCompareOptsGroup,@tclStuff skipwhite nextgroup=tclStringCmds
syn match tclStringCmdsMapOptsGroup contained "-\a\+" contains=tclStringCmdsMapOpts
syn keyword tclStringCmdsMapOpts contained nocase
syn keyword tclStringCmds contained map match skipwhite nextgroup=tclStringCmdsMapPred
syn region tclStringCmdsMapPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclStringCmdsMapOptsGroup,@tclStuff skipwhite nextgroup=tclStringCmds
syn match tclStringCmdsIsClassAlnumOptsGroup contained "-\a\+" contains=tclStringCmdsIsClassAlnumOpts
syn keyword tclStringCmdsIsClassAlnumOpts contained strict failindex
syn keyword tclStringCmdsIsClass contained alnum alpha ascii boolean control digit double false graph integer list lower print punct space true upper wideinteger wordchar xdigit skipwhite nextgroup=tclStringCmdsIsClassAlnumPred
syn region tclStringCmdsIsClassAlnumPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclStringCmdsIsClassAlnumOptsGroup,@tclStuff skipwhite nextgroup=tclStringCmdsIsClass
syn keyword tclStringCmds contained is skipwhite nextgroup=tclStringCmdsIsPred
syn region tclStringCmdsIsPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclStringCmdsIsClass,@tclStuff skipwhite nextgroup=tclStringCmds

syn keyword tclPrimary contained trace skipwhite nextgroup=tclTracePred
syn region tclTracePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclTraceCmds,@tclStuff
syn keyword tclTraceCmds contained variable vdelete vinfo skipwhite nextgroup=tclTraceCmdsVariablePred
syn region tclTraceCmdsVariablePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn keyword tclTraceCmdsAddCmdsCommandCmds contained rename trace skipwhite nextgroup=tclTraceCmdsAddCmdsCommandCmdsRenamePred
syn region tclTraceCmdsAddCmdsCommandCmdsRenamePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn keyword tclTraceCmdsAddCmds contained command skipwhite nextgroup=tclTraceCmdsAddCmdsCommandPred
syn region tclTraceCmdsAddCmdsCommandPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclTraceCmdsAddCmdsCommandCmds,@tclStuff skipwhite nextgroup=tclTraceCmdsAddCmds
syn keyword tclTraceCmds contained add remove info skipwhite nextgroup=tclTraceCmdsAddPred
syn region tclTraceCmdsAddPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclTraceCmdsAddCmds,@tclStuff skipwhite nextgroup=tclTraceCmds
syn keyword tclTraceCmdsAddCmdsExecutionCmds contained enter leave enterstep leavestep skipwhite nextgroup=tclTraceCmdsAddCmdsExecutionCmdsEnterPred
syn region tclTraceCmdsAddCmdsExecutionCmdsEnterPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn keyword tclTraceCmdsAddCmds contained execution skipwhite nextgroup=tclTraceCmdsAddCmdsExecutionPred
syn region tclTraceCmdsAddCmdsExecutionPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclTraceCmdsAddCmdsExecutionCmds,@tclStuff skipwhite nextgroup=tclTraceCmdsAddCmds
syn keyword tclTraceCmds contained add remove info skipwhite nextgroup=tclTraceCmdsAddPred
syn region tclTraceCmdsAddPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclTraceCmdsAddCmds,@tclStuff skipwhite nextgroup=tclTraceCmds
syn keyword tclTraceCmdsAddCmdsVariableCmds contained array read write unset skipwhite nextgroup=tclTraceCmdsAddCmdsVariableCmdsArrayPred
syn region tclTraceCmdsAddCmdsVariableCmdsArrayPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn keyword tclTraceCmdsAddCmds contained variable skipwhite nextgroup=tclTraceCmdsAddCmdsVariablePred
syn region tclTraceCmdsAddCmdsVariablePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclTraceCmdsAddCmdsVariableCmds,@tclStuff skipwhite nextgroup=tclTraceCmdsAddCmds
syn keyword tclTraceCmds contained add remove info skipwhite nextgroup=tclTraceCmdsAddPred
syn region tclTraceCmdsAddPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclTraceCmdsAddCmds,@tclStuff skipwhite nextgroup=tclTraceCmds

syn keyword tclPrimary contained interp skipwhite nextgroup=tclInterpPred
syn region tclInterpPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclInterpCmds,@tclStuff
syn match tclInterpCmdsCreateOptsGroup contained "-\a\+" contains=tclInterpCmdsCreateOpts
syn keyword tclInterpCmdsCreateOpts contained safe
syn keyword tclInterpCmds contained create skipwhite nextgroup=tclInterpCmdsCreatePred
syn region tclInterpCmdsCreatePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclInterpCmdsCreateOptsGroup,@tclStuff skipwhite nextgroup=tclInterpCmds
syn match tclInterpCmdsInvokehiddenOptsGroup contained "-\a\+" contains=tclInterpCmdsInvokehiddenOpts
syn keyword tclInterpCmdsInvokehiddenOpts contained namespace global
syn keyword tclInterpCmds contained invokehidden skipwhite nextgroup=tclInterpCmdsInvokehiddenPred
syn region tclInterpCmdsInvokehiddenPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclInterpCmdsInvokehiddenOptsGroup,@tclStuff skipwhite nextgroup=tclInterpCmds
syn match tclInterpCmdsLimitOptsGroup contained "-\a\+" contains=tclInterpCmdsLimitOpts
syn keyword tclInterpCmdsLimitOpts contained command granularity milliseconds seconds value
syn keyword tclInterpCmds contained limit skipwhite nextgroup=tclInterpCmdsLimitPred
syn region tclInterpCmdsLimitPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclInterpCmdsLimitOptsGroup,@tclStuff skipwhite nextgroup=tclInterpCmds
syn keyword tclInterpCmds contained alias aliases bgerror delete eval exists expose hide hidden issafe marktrusted recursionlimit share slaves target transfer skipwhite nextgroup=tclInterpCmdsAliasPred
syn region tclInterpCmdsAliasPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn keyword tclSecondary contained aliases alias bgerror eval expose hide hidden issafe marktrusted recursionlimit skipwhite nextgroup=tclInterpSUBAliasesPred
syn region tclInterpSUBAliasesPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tclStuff
syn keyword tclSecondary contained invokehidden skipwhite nextgroup=tclInterpSUBInvokehiddenPred
syn region tclInterpSUBInvokehiddenPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclInterpSUBInvokehiddenOptsGroup,@tclStuff
syn match tclInterpSUBInvokehiddenOptsGroup contained "-\a\+" contains=tclInterpSUBInvokehiddenOpts
syn keyword tclInterpSUBInvokehiddenOpts contained namespace global
syn keyword tclSecondary contained limit skipwhite nextgroup=tclInterpSUBLimitPred
syn region tclInterpSUBLimitPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclInterpSUBLimitOptsGroup,@tclStuff
syn match tclInterpSUBLimitOptsGroup contained "-\a\+" contains=tclInterpSUBLimitOpts
syn keyword tclInterpSUBLimitOpts contained command granularity milliseconds seconds value

syn keyword tkKeyword contained bell skipwhite nextgroup=tkBellPred
syn region tkBellPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkBellOptsGroup,@tclStuff
syn match tkBellOptsGroup contained "-\a\+" contains=tkBellOpts
syn keyword tkBellOpts contained nice displayof

syn keyword tkKeyword contained clipboard skipwhite nextgroup=tkClipboardPred
syn region tkClipboardPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkClipboardCmds,@tclStuff
syn match tkClipboardCmdsClearOptsGroup contained "-\a\+" contains=tkClipboardCmdsClearOpts
syn keyword tkClipboardCmdsClearOpts contained displayof format type
syn keyword tkClipboardCmds contained clear append get skipwhite nextgroup=tkClipboardCmdsClearPred
syn region tkClipboardCmdsClearPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkClipboardCmdsClearOptsGroup,@tclStuff skipwhite nextgroup=tkClipboardCmds

syn keyword tkKeyword contained console consoleinterp skipwhite nextgroup=tkConsolePred
syn region tkConsolePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkConsoleCmds,@tclStuff
syn keyword tkConsoleCmds contained eval hide show title record skipwhite nextgroup=tkConsoleCmdsEvalPred
syn region tkConsoleCmdsEvalPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tkKeyword contained focus skipwhite nextgroup=tkFocusPred
syn region tkFocusPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkFocusOptsGroup,@tclStuff
syn match tkFocusOptsGroup contained "-\a\+" contains=tkFocusOpts
syn keyword tkFocusOpts contained displayof force lastfor

syn keyword tkKeyword contained tkwait skipwhite nextgroup=tkTkwaitPred
syn region tkTkwaitPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTkwaitCmds,@tclStuff
syn keyword tkTkwaitCmds contained variable visibility window skipwhite nextgroup=tkTkwaitCmdsVariablePred
syn region tkTkwaitCmdsVariablePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tkKeyword contained winfo skipwhite nextgroup=tkWinfoPred
syn region tkWinfoPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWinfoCmds,@tclStuff
syn keyword tkWinfoCmds contained containing interps pathname visualscells children class colormapfull depth exists fpixels geom[etry] height id ismapped manager name parent pixels pointerx pointerxy pointery reqheight reqwidth rgb rootx rooty screen screencells screendepth screenheight screenmmheight screenmmwidth screenvisual screenwidth server toplevel viewable visual visualid vrootheight vrootwidth vrootx vrooty width x y skipwhite nextgroup=tkWinfoCmdsContainingPred
syn region tkWinfoCmdsContainingPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tkWinfoCmdsAtomOptsGroup contained "-\a\+" contains=tkWinfoCmdsAtomOpts
syn keyword tkWinfoCmdsAtomOpts contained displayof includeids
syn keyword tkWinfoCmds contained atom atomname containing interps pathname visualsavailable skipwhite nextgroup=tkWinfoCmdsAtomPred
syn region tkWinfoCmdsAtomPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWinfoCmdsAtomOptsGroup,@tclStuff skipwhite nextgroup=tkWinfoCmds

syn keyword tkKeyword contained wm skipwhite nextgroup=tkWmPred
syn region tkWmPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWmCmds,@tclStuff
syn keyword tkWmCmds contained aspect attributes attributes attributes client colormapwindows command deiconify focusmodel frame geom[etry] grid group iconbitmap iconify iconmask iconname iconphoto iconposition iconwindow maxsize minsize overrideredirect positionfrom protocol resizable sizefrom stackorder state title transient withdraw skipwhite nextgroup=tkWmCmdsAspectPred
syn region tkWmCmdsAspectPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tkKeyword contained grab skipwhite nextgroup=tkGrabPred
syn region tkGrabPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkGrabOptsGroup,tkGrabCmds,@tclStuff
syn keyword tkGrabCmds contained current release set status skipwhite nextgroup=tkGrabOptsGroup skipwhite nextgroup=tkGrabCmdsCurrentPred
syn region tkGrabCmdsCurrentPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tkGrabOptsGroup contained "-\a\+" contains=tkGrabOpts
syn keyword tkGrabOpts contained global

syn keyword tkKeyword contained font skipwhite nextgroup=tkFontPred
syn region tkFontPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkFontCmds,@tclStuff
syn keyword tkFontCmds contained delete names skipwhite nextgroup=tkFontCmdsDeletePred
syn region tkFontCmdsDeletePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tkFontCmdsFamiliesOptsGroup contained "-\a\+" contains=tkFontCmdsFamiliesOpts
syn keyword tkFontCmdsFamiliesOpts contained displayof
syn keyword tkFontCmds contained families measure skipwhite nextgroup=tkFontCmdsFamiliesPred
syn region tkFontCmdsFamiliesPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkFontCmdsFamiliesOptsGroup,@tclStuff skipwhite nextgroup=tkFontCmds
syn match tkFontCmdsActualOptsGroup contained "-\a\+" contains=tkFontCmdsActualOpts
syn keyword tkFontCmdsActualOpts contained displayof ascent descent linespace fixed family size weight slant underline overstrike
syn keyword tkFontCmds contained actual configure create metrics skipwhite nextgroup=tkFontCmdsActualPred
syn region tkFontCmdsActualPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkFontCmdsActualOptsGroup,@tclStuff skipwhite nextgroup=tkFontCmds

syn keyword tkKeyword contained option skipwhite nextgroup=tkOptionPred
syn region tkOptionPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkOptionCmds,@tclStuff
syn keyword tkOptionCmds contained add clear get readfile skipwhite nextgroup=tkOptionCmdsAddPred
syn region tkOptionCmdsAddPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tkKeyword contained grid skipwhite nextgroup=tkGridPred
syn region tkGridPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkGridOptsGroup,tkGridCmds,@tclStuff
syn keyword tkGridCmds contained anchor bbox forget info location propogate remove size slaves skipwhite nextgroup=tkGridCmdsAnchorPred
syn region tkGridCmdsAnchorPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tkGridCmdsColumnconfigureOptsGroup contained "-\a\+" contains=tkGridCmdsColumnconfigureOpts
syn keyword tkGridCmdsColumnconfigureOpts contained column columnspan in ipadx ipady padx pady row rowspan sticky minsize weight uniform pad
syn keyword tkGridCmds contained columnconfigure rowconfigure configure skipwhite nextgroup=tkGridCmdsColumnconfigurePred
syn region tkGridCmdsColumnconfigurePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkGridCmdsColumnconfigureOptsGroup,@tclStuff skipwhite nextgroup=tkGridCmds
syn match tkGridOptsGroup contained "-\a\+" contains=tkGridOpts
syn keyword tkGridOpts contained column columnspan in ipadx ipady padx pady row rowspan sticky minsize weight uniform pad

syn keyword tkKeyword contained pack skipwhite nextgroup=tkPackPred
syn region tkPackPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkPackOptsGroup,tkPackCmds,@tclStuff
syn keyword tkPackCmds contained forget info propogate slaves skipwhite nextgroup=tkPackCmdsForgetPred
syn region tkPackCmdsForgetPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tkPackCmdsConfigureOptsGroup contained "-\a\+" contains=tkPackCmdsConfigureOpts
syn keyword tkPackCmdsConfigureOpts contained after anchor before expand fill in ipadx ipady padx pady side
syn keyword tkPackCmds contained configure skipwhite nextgroup=tkPackCmdsConfigurePred
syn region tkPackCmdsConfigurePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkPackCmdsConfigureOptsGroup,@tclStuff skipwhite nextgroup=tkPackCmds
syn match tkPackOptsGroup contained "-\a\+" contains=tkPackOpts
syn keyword tkPackOpts contained after anchor before expand fill in ipadx ipady padx pady side

syn keyword tkKeyword contained place skipwhite nextgroup=tkPlacePred
syn region tkPlacePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkPlaceOptsGroup,tkPlaceCmds,@tclStuff
syn keyword tkPlaceCmds contained forget info slaves skipwhite nextgroup=tkPlaceCmdsForgetPred
syn region tkPlaceCmdsForgetPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tkPlaceCmdsConfigureOptsGroup contained "-\a\+" contains=tkPlaceCmdsConfigureOpts
syn keyword tkPlaceCmdsConfigureOpts contained anchor bordermode height in relheight relwidth relx rely width x y
syn keyword tkPlaceCmds contained configure skipwhite nextgroup=tkPlaceCmdsConfigurePred
syn region tkPlaceCmdsConfigurePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkPlaceCmdsConfigureOptsGroup,@tclStuff skipwhite nextgroup=tkPlaceCmds
syn match tkPlaceOptsGroup contained "-\a\+" contains=tkPlaceOpts
syn keyword tkPlaceOpts contained anchor bordermode height in relheight relwidth relx rely width x y

syn keyword tkKeyword contained tk_messageBox skipwhite nextgroup=tkTk_messageboxPred
syn region tkTk_messageboxPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTk_messageboxOptsGroup,@tclStuff
syn match tkTk_messageboxOptsGroup contained "-\a\+" contains=tkTk_messageboxOpts
syn keyword tkTk_messageboxOpts contained default detail icon message parent title type

syn keyword tkKeyword contained tk skipwhite nextgroup=tkTkPred
syn region tkTkPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTkCmds,@tclStuff
syn keyword tkTkCmds contained appname windowingsystem skipwhite nextgroup=tkTkCmdsAppnamePred
syn region tkTkCmdsAppnamePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tkTkCmdsScalingOptsGroup contained "-\a\+" contains=tkTkCmdsScalingOpts
syn keyword tkTkCmdsScalingOpts contained displayof
syn keyword tkTkCmds contained scaling inactive useinputmethods skipwhite nextgroup=tkTkCmdsScalingPred
syn region tkTkCmdsScalingPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTkCmdsScalingOptsGroup,@tclStuff skipwhite nextgroup=tkTkCmds
syn match tkTkCmdsCaretCmdsWindowOptsGroup contained "-\a\+" contains=tkTkCmdsCaretCmdsWindowOpts
syn keyword tkTkCmdsCaretCmdsWindowOpts contained x y height
syn keyword tkTkCmdsCaretCmds contained window skipwhite nextgroup=tkTkCmdsCaretCmdsWindowPred
syn region tkTkCmdsCaretCmdsWindowPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTkCmdsCaretCmdsWindowOptsGroup,@tclStuff skipwhite nextgroup=tkTkCmdsCaretCmds
syn keyword tkTkCmds contained caret skipwhite nextgroup=tkTkCmdsCaretPred
syn region tkTkCmdsCaretPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTkCmdsCaretCmds,@tclStuff skipwhite nextgroup=tkTkCmds

syn keyword tkKeyword contained send skipwhite nextgroup=tkSendPred
syn region tkSendPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkSendOptsGroup,@tclStuff
syn match tkSendOptsGroup contained "-\a\+" contains=tkSendOpts
syn keyword tkSendOpts contained async displayof

syn keyword tkKeyword contained tk_getOpenFile tk_getSaveFile skipwhite nextgroup=tkTk_getopenfilePred
syn region tkTk_getopenfilePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTk_getopenfileOptsGroup,@tclStuff
syn match tkTk_getopenfileOptsGroup contained "-\a\+" contains=tkTk_getopenfileOpts
syn keyword tkTk_getopenfileOpts contained defaultextension filetypes initialdir initialfile multiple message parent title


" -------------------------
" tk: Syntax - special case words
" -------------------------
syn keyword tkWidgetMenu              contained cascade separator command checkbutton radiobutton
syn keyword tclSecondary              contained activate addtag bbox canvasx canvasy clone coords curselection dchars delete delta deselect dtag entrycget entryconfigure find flash focus fraction get gettags icursor identify index insert invoke lower move moveto nearest panecget paneconfigure panes post postcascade proxy raise replace sash scale see set toggle type unpost validate xposition yposition
syn keyword tclSecondary              contained conf[igure] cget skipwhite nextgroup=tkWidgetPredicate
syn keyword tclSecondary              contained add skipwhite nextgroup=tkWidgetAddPredicate
syn region tkWidgetPredicate          contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetOptsGroup,@tclStuff
syn region tkWidgetAddPredicate       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetMenu,tkWidgetOptsGroup,@tclStuff

" these come from various widgets, their predicate spaces are a superset of everything required
syn keyword tclSecondary              contained scan skipwhite nextgroup=tkWidgetScanPredicate
syn region tkWidgetScanPredicate      contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkBindSubstGroup,tkScanCmds,tkWidgetOptsGroup,@tclStuff
syn keyword tclSecondary              contained select skipwhite nextgroup=tkWidgetSelectPredicate
syn region tkWidgetSelectPredicate    contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkSelectCmds,tkWidgetOptsGroup,@tclStuff
syn keyword tclSecondary              contained scroll skipwhite nextgroup=tkWidgetScrollPredicate
syn region tkWidgetScrollPredicate    contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkScrollCmds,tkScrollbarElems,tkWidgetOptsGroup,@tclStuff
syn keyword tclSecondary              contained xview yview skipwhite nextgroup=tkWidgetViewPredicate
syn region tkWidgetViewPredicate      contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkViewCmds,tkWidgetOptsGroup,@tclStuff
syn keyword tclSecondary              contained edit skipwhite nextgroup=tkWidgetEditPredicate
syn region tkWidgetEditPredicate      contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkEditCmds,tkWidgetOptsGroup,@tclStuff
syn keyword tclSecondary              contained mark skipwhite nextgroup=tkWidgetMarkPredicate
syn region tkWidgetMarkPredicate      contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkMarkCmds,tkWidgetOptsGroup,@tclStuff
syn keyword tclSecondary              contained peer skipwhite nextgroup=tkWidgetPeerPredicate
syn region tkWidgetPeerPredicate      contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkPeerCmds,tkWidgetOptsGroup,@tclStuff
" terminated switches, needs keeepend
syn keyword tclSecondary              contained search skipwhite nextgroup=tkWidgetSearchPredicate
syn region tkWidgetSearchPredicate    contained excludenl keepend start=+.+ end=+}\|]\|;\|.$\|--+ contains=tkWidgetSearchOptsGroup,@tclStuff
syn match tkWidgetSearchOptsGroup     contained "-\a\+" contains=tkWidgetSearchOpts skipwhite nextgroup=tkWidgetSearchOptsGroup,tkWidgetOptsGroup,@tclStuff
syn keyword tkWidgetSearchOpts        contained forwards back[wards] exact regexp nolinestop nocase count all overlap elide
syn keyword tclSecondary              contained selection skipwhite nextgroup=tkWidgetSelectionPredicate
syn region tkWidgetSelectionPredicate contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkSelectionCmds,tkWidgetOptsGroup,@tclStuff
syn keyword tclSecondary              contained tag skipwhite nextgroup=tkWidgetTagPredicate
syn region tkWidgetTagPredicate       contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTagCmds,tkTagOptsGroup,@tclStuff
syn keyword tclSecondary              contained window skipwhite nextgroup=tkWidgetWindowPredicate
syn region tkWidgetWindowPredicate    contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWindowCmds,tkWidgetOptsGroup,@tclStuff

syn keyword tclSecondary contained compare skipwhite nextgroup=tkWidgetComparePredicate
" syn region tkWidgetComparePredicate   contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tclStuff
" TODO compare predicate is:
" anything
" operator -> an expression
" anything

syn keyword tclSecondary contained count skipwhite nextgroup=tkWidgetCountPredicate
syn region tkWidgetCountPredicate   contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkCountOptsGroup,@tclStuff
syn match tkCountOptsGroup  contained "-\a\+" contains=tkCountOpts skipwhite nextgroup=tkCountOpts,@tclStuff
syn keyword tkCountOpts contained chars displaychars displayindicies displaylines indices lines xpixels ypixels update
hi link tkCountOpts tclOption


syn keyword tkEditCmds		   contained modified redo reset separator undo
syn keyword tkMarkCmds		   contained gravity names next previous set unset 
syn keyword tkPeerCmds		   contained create names
syn keyword tkScanCmds             contained mark dragto
syn keyword tkSelectCmds           contained adjust anchor clear element from includes item present range set to
syn keyword tkSelectionCmds        contained anchor clear includes set
syn keyword tkScrollCmds           contained units pages
syn keyword tkScrollbarElems       contained arrow1 arrow2 slider trough1 trough2
syn keyword tkTagCmds	           contained add bind cget config[ure] delete lower names nextrange prevrange raise ranges remove
syn match   tkTagOptsGroup         contained "-\a\+" contains=tkTagOpts
syn keyword tkTagOpts              contained background bgstipple borderwidth elide fgstipple font foreground justify lmargin1 lmargin2 offset overstrike relief spacing1 spacing2 spacing3 tabs tabstyle under[line] wrap
syn keyword tkViewCmds             contained moveto scroll
syn keyword tkWidgetOpts           contained accel[erator] activebackground activeborderwidth activeforeground anchor background bd bg bitmap borderwidth columnbreak command compound cursor disabledfore[ground] exportselection fg font foreground hidemargin highlightbackground highlightcolor highlightthick[ness] image indicatoron insertbackground insertborderwidth insertofftime insertontime insertwidth jump justify label menu offvalue onvalue ori[ent] padx pady relief repeatdelay repeatinterval selectbackground selectborderwidth selectcolor selectforeground selectimage setgrid state takefocus text textvar[iable] troughcolor underline value variable wraplength xscrollcommand yscrollcommand
syn keyword tkWidgetOpts           contained activerelief activestyle aspect background bigincrement buttonbackground buttoncursor buttondownrelief buttonuprelief class closeenough colormap command confine container default digits direction disabledback[ground] disabledfore[ground] elementborderwidth format from handlepad handlesize height increment indicatoron invalidcommand invcmd justify label labelanchor labelwidget length listvariable menu offrelief offvalue onvalue opaqueresize overrelief postcommand readonlybackground resolution sashcursor sashpad sashrelief sashwidth screen scrollregion selectcolor selectimage selectmode show showhandle showvalue sliderlength sliderrelief state tearoff tearoffcommand tickinterval title to tristateimage tristatevalue type use validate validatecommand value values variable vcmd visual width wrap xscrollincrement yscrollincrement
syn keyword tkWidgetOpts           contained autoseparators blockcursor endline inactiveselectionbackground maxundo spacing1 spacing2 spacing3 startline state tabs tabstyle undo wrap
syn keyword tkWindowCmds	   contained cget configure create names
syn match tkWidgetOptsGroup        contained "-\a\+" contains=tkWidgetOpts

" SPECIAL CASE: 
syn keyword tkKeyword      contained bind skipwhite nextgroup=tkBindPredicate
syn keyword tclSecondary   contained bind skipwhite nextgroup=tkBindPredicate
syn region tkBindPredicate contained keepend extend excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkBindTag
syn region tkBindTag       contained start="." end="\s\|]" skipwhite nextgroup=tkBindSeq contains=@tclStuff
syn region tkBindSeq       contained start="." end="\s\|]" skipwhite nextgroup=tkBindScript contains=tkEvent
syn region tkBindScript    contained keepend extend excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+                                     contains=@tclCommandCluster
syn region tkBindScript    contained keepend extend excludenl matchgroup=Bold start=+\s*\(\\\)\@<!{+  end=+}+ skip=+$\|\\$\|\\}+ contains=@tclCommandCluster
syn match tkBindSubstGroup contained "%%"
syn match tkBindSubstGroup contained "%#"
syn match tkBindSubstGroup contained "%\a\>" contains=tkBindSubst
syn keyword tkBindSubst    contained a b c d f h i k m o p s t w x y A B D E K N P R S T W X Y

" SPECIAL CASE: 
syn keyword tkKeyword           contained event skipwhite nextgroup=tkEventPredicate,@tclStuff
syn region tkEventPredicate     contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkEventCmds
syn region tkEventCmdsPredicate contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tkEventCluster
syn keyword tkEventCmds         contained add delete generate info skipwhite nextgroup=tkEventCmdsPredicate
syn match tkEventFieldsGroup    contained "-\a\+" contains=tkEventFields
syn keyword tkEventFields       contained above borderwidth button count data delta detail focus height keycode keysym mode override place root rootx rooty sendevent serial state subwindow time warp width when x y
syn keyword tkEventWhen         contained now tail head mark
syn cluster tkEventCluster contains=tkEventCmds,tkEventFieldsGroup,tkEventWhen,@tclStuff

" SPECIAL CASE: 
syn keyword tkWidget                    contained canvas skipwhite nextgroup=tkCanvasPredicate
syn region tkCanvasPredicate            contained keepend excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tkCanvasCluster,@tclStuff
syn keyword tkCanvasTagOpts             contained above all below closest enclosed overlapping withtag
syn keyword tkCanvasPsOpts              contained colormap colormode file fontmap height pageanchor pageheight pagewidth pagex pagey rotate width x y
syn keyword tkCanvasItemOpts            contained activebackground activebitmap activedash activefill activeforeground activeimage activeoutline activeoutlinestipple activestipple activewidth anchor arrow arrowshape background bitmap capstyle dash dashoffset disabledbackground disabledbitmap disableddash disabledfill disabledforeground disabledimage disabledoutline disabledoutlinestipple disabledstipple disabledwidth extent fill font foreground height image joinstyle justify offset outline outlinestipple smooth splinesteps start state stipple style tag[s] text width window
syn cluster tkCanvasCluster		contains=tkCanvasItemOpts,tkCanvasTagOpts,tkWidgetOptsGroup
" the create command
syn keyword tkWidgetCreate              contained create skipwhite nextgroup=tkWidgetCreatePredicate
syn region tkWidgetCreatePredicate      contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateCmds,@tclStuff
syn match tkWidgetCreateCommonOptsGroup contained "-\a\+" contains=tkWidgetCreateCommonOpts
syn keyword tkWidgetCreateCommonOpts    contained activedash activefill activeoutline activeoutlinestipple activestipple activewidth dash dashoffset disableddash disabledfill disabledoutline disabledoutlinestipple disabledstipple disabledwidth fill offset outline outlinestipple state stipple tag[s] width
syn keyword tkWidgetCreateCmds          contained arc skipwhite nextgroup=tkWidgetCreateArcPred
syn region tkWidgetCreateArcPred        contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateArcOptsGroup,@tclStuff
syn match tkWidgetCreateArcOptsGroup    contained "-\a\+" contains=tkWidgetCreateArcOpts,tkWidgetCreateCommonOpts
syn keyword tkWidgetCreateArcOpts       contained extent start style
syn keyword tkWidgetCreateCmds          contained bitmap skipwhite nextgroup=tkWidgetCreateBitmapPred
syn region tkWidgetCreateBitmapPred     contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateBitmapOptsGroup,@tclStuff
syn match tkWidgetCreateBitmapOptsGroup contained "-\a\+" contains=tkWidgetCreateBitmapOpts,tkWidgetCreateCommonOpts
syn keyword tkWidgetCreateBitmapOpts    contained activebackground activebitmap activeforeground anchor background bitmap disabledbackground disabledbitmap disabledforeground foreground
syn keyword tkWidgetCreateCmds          contained image skipwhite nextgroup=tkWidgetCreateImagePred
syn region tkWidgetCreateImagePred      contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateImageOptsGroup,@tclStuff
syn match tkWidgetCreateImageOptsGroup  contained "-\a\+" contains=tkWidgetCreateImageOpts,tkWidgetCreateCommonOpts
syn keyword tkWidgetCreateImageOpts     contained anchor image activeimage disabledimage
syn keyword tkWidgetCreateCmds          contained line skipwhite nextgroup=tkWidgetCreateLinePred
syn region tkWidgetCreateLinePred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateLineOptsGroup,@tclStuff
syn match tkWidgetCreateLineOptsGroup   contained "-\a\+" contains=tkWidgetCreateLineOpts,tkWidgetCreateCommonOpts
syn keyword tkWidgetCreateLineOpts      contained arrow arrowshape capstyle joinstyle smooth splinesteps
syn keyword tkWidgetCreateCmds          contained oval skipwhite nextgroup=tkWidgetCreateOvalPred
syn region tkWidgetCreateOvalPred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateCommonOptsGroup,@tclStuff
syn keyword tkWidgetCreateCmds          contained poly[gon] skipwhite nextgroup=tkWidgetCreatePolyPred
syn region tkWidgetCreatePolyPred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreatePolyOptsGroup,@tclStuff
syn match tkWidgetCreatePolyOptsGroup   contained "-\a\+" contains=tkWidgetCreatePolyOpts,tkWidgetCreateCommonOpts
syn keyword tkWidgetCreatePolyOpts      contained joinstyle smooth splinesteps
syn keyword tkWidgetCreateCmds          contained rect[angle] skipwhite nextgroup=tkWidgetCreateRectPred
syn region tkWidgetCreateRectPred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateCommonOptsGroup,@tclStuff
syn keyword tkWidgetCreateCmds          contained text skipwhite nextgroup=tkWidgetCreateTextPred
syn region tkWidgetCreateTextPred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateTextOptsGroup,@tclStuff
syn match tkWidgetCreateTextOptsGroup   contained "-\a\+" contains=tkWidgetCreateTextOpts,tkWidgetCreateCommonOpts
syn keyword tkWidgetCreateTextOpts      contained anchor font justify text width
syn keyword tkWidgetCreateCmds          contained window skipwhite nextgroup=tkWidgetCreateWinPred
syn region tkWidgetCreateWinPred        contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateWinOptsGroup,@tclStuff
syn match tkWidgetCreateWinOptsGroup    contained "-\a\+" contains=tkWidgetCreateWinOpts,tkWidgetCreateCommonOpts
syn keyword tkWidgetCreateWinOpts       contained anchor height width window
syn keyword tclSecondary                contained itemconfig[ure] itemcget skipwhite nextgroup=tkCanvasItemConfigurePred
syn region tkCanvasItemConfigurePred    contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateArcOpts,tkWidgetCreateBitmapOpts,tkWidgetCreateCommonOpts,tkWidgetCreateImageOpts,tkWidgetCreateLineOpts,tkWidgetCreateOvalOpts,tkWidgetCreatePolyOpts,tkWidgetCreateRectOpts,tkWidgetCreateTextOpts,tkWidgetCreateWinOpts,@tclStuff

" postscript
syn keyword tclSecondary contained postscript skipwhite nextgroup=tkCanvasPsPred
syn region tkCanvasPsPred contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkCanvasPsOptsGroup,@tclStuff
syn match tkCanvasPsOptsGroup contained "-\a\+" contains=tkCanvasPsOpts

" SPECIAL CASE: 
" , includes -  bitmap photo
syn keyword tkWidget                   contained image skipwhite nextgroup=tkWidgetImagePred
syn region tkWidgetImagePred           contained keepend excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkImageCmds,tkWidgetCreate,@tclStuff
syn keyword tkImageCmds                contained delete inuse names type types 
syn keyword tkImageCmds                contained anchor height width window

" create bitmap starts in canvas, this appends
syn keyword tkWidgetCreateBitmapOpts   contained background data file foreground maskdata maskfile
syn keyword tkWidgetCreateCmds         contained photo skipwhite nextgroup=tkWidgetCreatePhotoPred
syn region tkWidgetCreatePhotoPred     contained keepend excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreatePhotoOptsGroup,@tclStuff
syn match tkWidgetCreatePhotoOptsGroup contained "-\a\+" contains=tkWidgetCreatePhotoOpts
syn keyword tkWidgetCreatePhotoOpts    contained data format file gamma height palette width

" Syntax: from photo
syn keyword tclSecondary               contained blank
syn keyword tclSecondary               contained copy skipwhite nextgroup=tkWidgetImageCopyPred
syn region tkWidgetImageCopyPred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetImageCopyOptsGroup,@tclStuff
syn match tkWidgetImageCopyOptsGroup   contained "-\a\+" contains=tkWidgetImageCopyOpts
syn keyword tkWidgetImageCopyOpts      contained from to shrink zoom subsample compositingrule
syn keyword tclSecondary               contained data skipwhite nextgroup=tkWidgetImageDataPred
syn region tkWidgetImageDataPred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetImageDataOptsGroup,@tclStuff
syn match tkWidgetImageDataOptsGroup   contained "-\a\+" contains=tkWidgetImageDataOpts
syn keyword tkWidgetImageDataOpts      contained background format from grayscale
syn keyword tclSecondary               contained put skipwhite nextgroup=tkWidgetImagePutPred
syn region tkWidgetImagePutPred        contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetImagePutOptsGroup,@tclStuff
syn match tkWidgetImagePutOptsGroup    contained "-\a\+" contains=tkWidgetImagePutOpts
syn keyword tkWidgetImagePutOpts       contained format to
syn keyword tclSecondary               contained read skipwhite nextgroup=tkWidgetImageReadPred
syn region tkWidgetImageReadPred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetImageReadOptsGroup,@tclStuff
syn match tkWidgetImageReadOptsGroup   contained "-\a\+" contains=tkWidgetImageReadOpts
syn keyword tkWidgetImageReadOpts      contained format from shrink to
syn keyword tclSecondary               contained redither
syn keyword tclSecondary               contained transparency skipwhite nextgroup=tkWidgetImageTransPred
syn region tkWidgetImageTransPred      contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetImageTransOptsGroup,@tclStuff
syn match tkWidgetImageTransOptsGroup  contained "-\a\+" contains=tkWidgetImageTransOpts
syn keyword tkWidgetImageTransOpts     contained get set
syn keyword tclSecondary               contained write skipwhite nextgroup=tkWidgetImageWritePred
syn region tkWidgetImageWritePred      contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetImageWriteOptsGroup,@tclStuff
syn match tkWidgetImageWriteOptsGroup  contained "-\a\+" contains=tkWidgetImageWriteOpts
syn keyword tkWidgetImageWriteOpts     contained background format from grayscale

" SPECIAL CASE: 
syn keyword tkWidget		contained text skipwhite nextgroup=tkTextPredicate
syn keyword tkKeyword		contained tk_textCopy tk_textCut tk_textPaste
syn region tkTextPredicate	contained keepend excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tkTextCluster,@tclStuff
" this is how you 'subclass' an OptsGroup
syn match tkTextWidgetOptsGroup contained "-\a\+" contains=tkTextWidgetOpts,tkWidgetOpts
syn keyword tkTextWidgetOpts    contained autoseparators blockcursor endline inactiveselectionbackground maxundo spacing1 spacing2 spacing3 startline state tabs tabstyle undo wrap
syn cluster tkTextCluster	contains=tkTextWidgetOptsGroup


" SPECIAL CASE: 
syn keyword tkWidget           contained listbox skipwhite nextgroup=tkWidgetPredicate



" -------------------------
" Tcl: Packages
" ------------------------- 

if exists("s:tcl_snit_active")
    runtime! syntax/tcl_snit.vim
endif

if exists("s:tcl_sqlite_active")
    runtime! syntax/tcl_sqlite.vim
endif

if exists("s:tcl_critcl_active")
    runtime! syntax/tcl_critcl.vim
endif

if exists("s:tcl_togl_active")
    runtime! syntax/tcl_togl.vim
endif

if exists("s:tcl_itcl_active")
    runtime! syntax/tcl_itcl.vim
endif

if exists("s:tcl_ttk_active")
    runtime! syntax/tcl_ttk.vim
endif

" -------------------------

if exists("s:tcl_highlight_all")
    let s:tcl_highlight_bookends = 1
    let s:tcl_highlight_primary = 1
    let s:tcl_highlight_secondary = 1
    let s:tcl_highlight_variables = 1
    let s:tcl_highlight_options = 1
    let s:tcl_highlight_expressions = 1
endif

if version >= 508 || !exists("s:did_tcl_syn_inits")
    if version <= 508
        let s:did_tcl_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi! def link <args>
    endif
endif

" -------------------------
" Highlights: - Basic
" -------------------------
HiLink tclStart          Special
HiLink tclLContinueOK    Special
HiLink tclLContinueError Error
HiLink tclQuotes         String
HiLink tclSingleQuote    Special
HiLink tclSingleBracket  Special
HiLink tclNumber         Number
HiLink tclComment        Comment
HiLink tclCommentBraces  Comment
HiLink tclIfComment      Comment
HiLink tclIfCommentStart Comment
HiLink tclSpecial        Special
HiLink tclTodo           Todo
HiLink tclExpand         Underlined
HiLink tclREClassGroup   Special
HiLink tclREClass        Special
" ------------------
if exists("s:tcl_highlight_primary")
    HiLink tclKeyword        Statement
    HiLink tclNamespace      Statement
    HiLink tclPrimary        Statement
    HiLink tclConditional    Conditional
    HiLink tclRepeat         Repeat
    HiLink tclException      Exception
    HiLink tclLabel          Label
    HiLink tkWidget          Underlined
endif
" ------------------
if exists("s:tcl_highlight_lcs_are_warnings")
    hi! def link tclLContinueOk WarningMsg
endif
" ------------------
if exists("s:tcl_highlight_namespace_bold")
    hi! def link tclNamespace      Bold
endif
" ------------------
if exists("s:tcl_highlight_options")
    hi! def link tclOption         PreProc
endif
" ------------------
if exists("s:tcl_highlight_secondary")
    hi! def link tclSecondary      Type
    hi! def link tclSubcommand     Type
endif
" ------------------
if exists("s:tcl_highlight_variables")
    hi! def link tclVariable       Identifier
endif
" ------------------
if exists("s:tcl_highlight_expressions")
    hi! def link tclEnsemble       Special
    hi! def link tclMaths          Special
endif
" ------------------
HiLink tclProcName       Bold
HiLink tclProcDef        Bold
HiLink tclProcType       Bold
" ------------------
HiLink tkColor           Bold
HiLink tkWidgetCmds      tclSubcommand
HiLink tkWidgetOpts      tclOption
HiLink tclMagicName      tclKeyword
HiLink tkKeyword         tclKeyword
HiLink tkReserved        tclKeyword
HiLink tkDialog          tclKeyword
HiLink tkEvent           tclQuotes
HiLink tkWidgetName      tclQuotes


" -------------------------
" Highlights: - Extended
" -------------------------
HiLink tclAfterCmds tclSubcommand
HiLink tclArrayCmds tclSubcommand
HiLink tclArrayCmdsNamesOpts tclOption
HiLink tclBinaryCmds tclSubcommand
HiLink tclChanCmds tclSubcommand
HiLink tclChanCmdsConfigureOpts tclOption
HiLink tclChanCmdsCopyOpts tclOption
HiLink tclChanCmdsPutsOpts tclOption
HiLink tclClockCmds tclSubcommand
HiLink tclClockCmdsAddOpts tclOption
HiLink tclDictCmds tclSubcommand
HiLink tclDictCmdsFilterOpts tclOption
HiLink tclEncodingCmds tclSubcommand
HiLink tclExecOpts tclOption
HiLink tclFconfigureOpts tclOption
HiLink tclFcopyOpts tclOption
HiLink tclFileCmds tclSubcommand
HiLink tclFileCmdsAtimeOpts tclOption
HiLink tclFileCmdsAttributesOpts tclOption
HiLink tclFileCmdsCopyOpts tclOption
HiLink tclFileeventCmds tclSubcommand
HiLink tclGlobOpts tclOption
HiLink tclHistoryCmds tclSubcommand
HiLink tclHistoryCmdsAddCmds tclSubcommand
HiLink tclInfoCmds tclSubcommand
HiLink tclInterpCmds tclSubcommand
HiLink tclInterpCmdsCreateOpts tclOption
HiLink tclInterpCmdsInvokehiddenOpts tclOption
HiLink tclInterpCmdsLimitOpts tclOption
HiLink tclInterpSUBInvokehiddenOpts tclOption
HiLink tclInterpSUBLimitOpts tclOption
HiLink tclLsearchOpts tclOption
HiLink tclLsortOpts tclOption
HiLink tclMemoryCmds tclSubcommand
HiLink tclOpenOpts tclOption
HiLink tclPackageCmds tclSubcommand
HiLink tclPackageCmdsPresentOpts tclOption
HiLink tclPutsOpts tclOption
HiLink tclRegexpOpts tclOption
HiLink tclRegsubOpts tclOption
HiLink tclReturnOpts tclOption
HiLink tclSeekCmds tclSubcommand
HiLink tclSocketOpts tclOption
HiLink tclSourceOpts tclOption
HiLink tclStringCmds tclSubcommand
HiLink tclStringCmdsCompareOpts tclOption
HiLink tclStringCmdsIsClass tclEnsemble
HiLink tclStringCmdsIsClassAlnumOpts tclOption
HiLink tclStringCmdsMapOpts tclOption
HiLink tclSubstOpts tclOption
HiLink tclSwitchOpts tclOption
HiLink tclTraceCmds tclSubcommand
HiLink tclTraceCmdsAddCmds tclSubcommand
HiLink tclTraceCmdsAddCmdsCommandCmds tclSubcommand
HiLink tclTraceCmdsAddCmdsExecutionCmds tclSubcommand
HiLink tclTraceCmdsAddCmdsVariableCmds tclSubcommand
HiLink tclUnloadOpts tclOption
HiLink tclUnsetOpts tclOption
HiLink tclUpdateCmds tclSubcommand
HiLink tkBellOpts tclOption
HiLink tkClipboardCmds tclSubcommand
HiLink tkClipboardCmdsClearOpts tclOption
HiLink tkConsoleCmds tclSubcommand
HiLink tkFocusOpts tclOption
HiLink tkFontCmds tclSubcommand
HiLink tkFontCmdsActualOpts tclOption
HiLink tkFontCmdsFamiliesOpts tclOption
HiLink tkGrabCmds tclSubcommand
HiLink tkGrabOpts tclOption
HiLink tkGridCmds tclSubcommand
HiLink tkGridCmdsColumnconfigureOpts tclOption
HiLink tkGridOpts tclOption
HiLink tkOptionCmds tclSubcommand
HiLink tkPackCmds tclSubcommand
HiLink tkPackCmdsConfigureOpts tclOption
HiLink tkPackOpts tclOption
HiLink tkPlaceCmds tclSubcommand
HiLink tkPlaceCmdsConfigureOpts tclOption
HiLink tkPlaceOpts tclOption
HiLink tkSendOpts tclOption
HiLink tkTkCmds tclSubcommand
HiLink tkTkCmdsCaretCmds tclSubcommand
HiLink tkTkCmdsCaretCmdsWindowOpts tclOption
HiLink tkTkCmdsScalingOpts tclOption
HiLink tkTk_getopenfileOpts tclOption
HiLink tkTk_messageboxOpts tclOption
HiLink tkTkwaitCmds tclSubcommand
HiLink tkWinfoCmds tclSubcommand
HiLink tkWinfoCmdsAtomOpts tclOption
HiLink tkWmCmds tclSubcommand

" -------------------------
" Highlights: - Special Case
" -------------------------
HiLink tclNamespaceCmds               tclSubcommand
HiLink tclNamespaceEnsemble           tclEnsemble
HiLink tclNamespaceEnsembleCmds       tclSubcommand
HiLink tclNamespaceEnsembleExistsOpts tclOption
HiLink tclNamespaceExportOpts         tclOption
HiLink tkBindSubst                    tclQuotes
HiLink tkBindSubstGroup               tclQuotes
HiLink tkEventCmds                    tclSubcommand
HiLink tkEventFields                  tclOption
HiLink tkEventWhen                    tclString
HiLink tkCanvasItemOpts               tclOption
HiLink tkCanvasPsOpts                 tclOption
HiLink tkCanvasTagOpts                tclOption
HiLink tkWidgetCreate                 tclSubcommand
HiLink tkWidgetCreateArcOpts          tclOption
HiLink tkWidgetCreateBitmapOpts       tclOption
HiLink tkWidgetCreateCmds             tclEnsemble
HiLink tkWidgetCreateCommonOpts       tclOption
HiLink tkWidgetCreateImageOpts        tclOption
HiLink tkWidgetCreateLineOpts         tclOption
HiLink tkWidgetCreateOvalOpts         tclOption
HiLink tkWidgetCreatePhotoOpts        tclOption
HiLink tkWidgetCreatePolyOpts         tclOption
HiLink tkWidgetCreateRectOpts         tclOption
HiLink tkWidgetCreateTextOpts         tclOption
HiLink tkWidgetCreateWinOpts          tclOption
HiLink tkImageCmds                    tclSubcommand
HiLink tkWidgetImageCopyOpts          tclOption
HiLink tkWidgetImageDataOpts          tclOption
HiLink tkWidgetImagePutOpts           tclOption
HiLink tkWidgetImageReadOpts          tclOption
HiLink tkWidgetImageTransOpts         tclOption
HiLink tkWidgetImageWriteOpts         tclOption

HiLink tkTextWidgetOpts               tclOption
HiLink tkMarkCmds                     tclEnsemble
HiLink tkTagCmds                      tclEnsemble
HiLink tkTagOpts                      tclOption
HiLink tkWidgetSearchOpts             tclOption

HiLink tkScanCmds                     tclEnsemble
HiLink tkScrollCmds                   tclEnsemble
HiLink tkSelectCmds                   tclEnsemble
HiLink tkScrollbarElems               tclOption
HiLink tkScrollbarElems               tclString
HiLink tkWidgetMenu                   tclEnsemble
HiLink tkViewCmds                     tclEnsemble


delcommand HiLink

" -------------------------
" Hoodage:
" -------------------------

let b:current_syntax = "tcl"
" override the sync commands from the other syntax files
syn sync clear
" syn sync minlines=300
syn sync fromstart

" -------------------------

" vim:ft=vim
