" Peppermint colorscheme
" Author: Trent Scheffert <trent.scheffert@gmail.com>
" Maintainer: Trent Scheffert <trent.scheffert@gmail.com>
" Notes: To check the meaning of the highlight groups, :help 'highlight'
" Source: https://noahfrederick.com/log/lion-terminal-theme-peppermint/

" --------------------------------
set background=dark
" --------------------------------

highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="Peppermint"

"----------------------------------------------------------------
" Colors                                                        |
"----------------------------------------------------------------
" Name           | Hex                                          |
"----------------------------------------------------------------
" Background     | #000000
" Text           | #E6E6E6
" Bold           | #FF0028
" Grey           | #4C4C4C
" Red            | #FF6685
" Green          | #A6EBA6
" Yellow         | #FFDC72
" Blue           | #5DC6F5
" Magenta        | #FF8FFF
" Teal           | #86D1D7
" White          | #DBDBDB
" Bright Grey    | #737373
" Bright Red     | #FFA8BA
" Bright Green   | #C5EBC5
" Bright Yellow  | #F9F9A5
" Bright Blue    | #8DDBFF
" Bright Magenta | #FFABFF
" Bright Teal    | #B0F0F0
" Bright White   | #FFFFFF


"----------------------------------------------------------------
" General settings                                              |
"----------------------------------------------------------------
"----------------------------------------------------------------
" Syntax group   | Foreground    | Background    | Style        |
"----------------------------------------------------------------

" --------------------------------
" Editor settings
" --------------------------------
hi Normal          guifg=#E6E6E6      guibg=none    gui=none
hi Cursor          guifg=none      guibg=none    gui=none
hi CursorLine      guifg=none      guibg=none    gui=none
hi LineNr          guifg=#737373      guibg=none    gui=none
hi CursorLineNR    guifg=none      guibg=none    gui=none

" -----------------
" - Number column -
" -----------------
hi CursorColumn    guifg=none      guibg=none    gui=none
hi FoldColumn      guifg=none      guibg=none    gui=none
hi SignColumn      guifg=none      guibg=none    gui=none
hi Folded          guifg=none      guibg=none    gui=none

" -------------------------
" - Window/Tab delimiters -
" -------------------------
hi VertSplit       guifg=none      guibg=none    gui=none
hi ColorColumn     guifg=none      guibg=none    gui=none
hi TabLine         guifg=none      guibg=none    gui=none
hi TabLineFill     guifg=none      guibg=none    gui=none
hi TabLineSel      guifg=none      guibg=none    gui=none

" -------------------------------
" - File Navigation / Searching -
" -------------------------------
hi Directory       guifg=none      guibg=none    gui=none
hi Search          guifg=none      guibg=none    gui=none
hi IncSearch       guifg=none      guibg=none    gui=none

" -----------------
" - Prompt/Status -
" -----------------
hi StatusLine      guifg=none      guibg=none    gui=none
hi StatusLineNC    guifg=none      guibg=none    gui=none
hi WildMenu        guifg=none      guibg=none    gui=none
hi Question        guifg=none      guibg=none    gui=none
hi Title           guifg=none      guibg=none    gui=none
hi ModeMsg         guifg=none      guibg=none    gui=none
hi MoreMsg         guifg=none      guibg=none    gui=none

" --------------
" - Visual aid -
" --------------
hi MatchParen      guifg=none      guibg=none    gui=none
hi Visual          guifg=none      guibg=none    gui=none
hi VisualNOS       guifg=none      guibg=none    gui=none
hi NonText         guifg=none      guibg=none    gui=none

hi Todo            guifg=none      guibg=none    gui=none
hi Underlined      guifg=none      guibg=none    gui=none
hi Error           guifg=none      guibg=none    gui=none
hi ErrorMsg        guifg=none      guibg=none    gui=none
hi WarningMsg      guifg=none      guibg=none    gui=none
hi Ignore          guifg=none      guibg=none    gui=none
hi SpecialKey      guifg=none      guibg=none    gui=none

" --------------------------------
" Variable types
" --------------------------------
hi Constant        guifg=none      guibg=none    gui=none
hi String          guifg=none      guibg=none    gui=none
hi StringDelimiter guifg=none      guibg=none    gui=none
hi Character       guifg=none      guibg=none    gui=none
hi Number          guifg=none      guibg=none    gui=none
hi Boolean         guifg=none      guibg=none    gui=none
hi Float           guifg=none      guibg=none    gui=none

hi Identifier      guifg=none      guibg=none    gui=none
hi Function        guifg=none      guibg=none    gui=none

" --------------------------------
" Language constructs
" --------------------------------
hi Statement       guifg=none      guibg=none    gui=none
hi Conditional     guifg=none      guibg=none    gui=none
hi Repeat          guifg=none      guibg=none    gui=none
hi Label           guifg=none      guibg=none    gui=none
hi Operator        guifg=none      guibg=none    gui=none
hi Keyword         guifg=none      guibg=none    gui=none
hi Exception       guifg=none      guibg=none    gui=none
hi Comment         guifg=none      guibg=none    gui=none

hi Special         guifg=none      guibg=none    gui=none
hi SpecialChar     guifg=none      guibg=none    gui=none
hi Tag             guifg=none      guibg=none    gui=none
hi Delimiter       guifg=none      guibg=none    gui=none
hi SpecialComment  guifg=none      guibg=none    gui=none
hi Debug           guifg=none      guibg=none    gui=none

" ----------
" - C like -
" ----------
hi PreProc         guifg=none      guibg=none    gui=none
hi Include         guifg=none      guibg=none    gui=none
hi Define          guifg=none      guibg=none    gui=none
hi Macro           guifg=none      guibg=none    gui=none
hi PreCondit       guifg=none      guibg=none    gui=none

hi Type            guifg=none      guibg=none    gui=none
hi StorageClass    guifg=none      guibg=none    gui=none
hi Structure       guifg=none      guibg=none    gui=none
hi Typedef         guifg=none      guibg=none    gui=none

" --------------------------------
" Diff
" --------------------------------
hi DiffAdd         guifg=#A6EBA6      guibg=none    gui=none
hi DiffChange      guifg=#FFDC72      guibg=none    gui=none
hi DiffDelete      guifg=#FF6685      guibg=none    gui=none
hi DiffText        guifg=#E6E6E6      guibg=#4C4C4C    gui=italic,bold

" --------------------------------
" Completion menu
" --------------------------------
hi Pmenu           guifg=none      guibg=none    gui=none
hi PmenuSel        guifg=none      guibg=none    gui=none
hi PmenuSbar       guifg=none      guibg=none    gui=none
hi PmenuThumb      guifg=none      guibg=none    gui=none

" --------------------------------
" Spelling
" --------------------------------
hi SpellBad        guifg=none      guibg=none    gui=none
hi SpellCap        guifg=none      guibg=none    gui=none
hi SpellLocal      guifg=none      guibg=none    gui=none
hi SpellRare       guifg=none      guibg=none    gui=none

"--------------------------------------------------------------------
" Specific settings                                                 |
"--------------------------------------------------------------------
