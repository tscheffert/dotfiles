" Created by Trent Scheffert, November 2015

" Color format:
" [ 'guifg', 'guibg', 'ctermfg', 'ctermbg', 'opts' = '' ]


let g:airline#themes#PaperColorRecharged#palette = {}

let g:airline#themes#PaperColorRecharged#palette.accents = {
      \ 'red': [ '#66d9ef' , '' , 81 , '' , '' ],
      \ }


" Normal Mode:
let s:N1 = [ '#e4e4e4' , '#585858' , 254 , 240 ] " Center
let s:N2 = [ '#585858' , '#87d787' , 240 , 10  ] " Middle
let s:N3 = [ '#404040' , '#5faf5f' , 236 , 2   ] " Outside

let g:airline#themes#PaperColorRecharged#palette.normal = airline#themes#generate_color_map(s:N3, s:N2, s:N1)
let g:airline#themes#PaperColorRecharged#palette.normal_modified = {
      \ 'airline_c': [ '#5faf5f' , '#585858' , 2 , 240 , '' ] ,
      \ } " Changes { Middle: filename }, but not { Middle: filetype }


" Insert Mode:
let s:I1 = [ '#e4e4e4' , '#585858' , 254 , 240 ]
let s:I2 = [ '#e4e4e4' , '#2387af' , 254 , 12  ]
let s:I3 = [ '#eeeeee' , '#005f87' , 255 , 4   ]

let g:airline#themes#PaperColorRecharged#palette.insert = airline#themes#generate_color_map(s:I3, s:I2, s:I1)
" Blue is already super dark, use the light-blue text instead of the usual dark
let g:airline#themes#PaperColorRecharged#palette.insert_modified = {
      \ 'airline_c': [ '#2387af' , '#585858' , 4 , 240 , '' ] ,
      \ }


" Replace Mode:
let s:R1 = [ '#e4e4e4' , '#585858' , 254 , 240 ]
let s:R2 = [ '#e4e4e4' , '#ff2887' , 254 , 12  ]
let s:R3 = [ '#eeeeee' , '#d7005f' , 255 , 1   ]

let g:airline#themes#PaperColorRecharged#palette.replace = airline#themes#generate_color_map(s:R3, s:R2, s:R1)
let g:airline#themes#PaperColorRecharged#palette.replace_modified = {
      \ 'airline_c': [ '#d7005f' , '#585858' , 1 , 240 , '' ] ,
      \ }


" Visual Mode:
let s:V1 = [ '#e4e4e4' , '#585858' , 254 , 240 ]
let s:V2 = [ '#585858' , '#ffaf87' , 240 , 11  ]
let s:V3 = [ '#404040' , '#df875f' , 236 , 3   ]

let g:airline#themes#PaperColorRecharged#palette.visual = airline#themes#generate_color_map(s:V3, s:V2, s:V1)
let g:airline#themes#PaperColorRecharged#palette.visual_modified = {
      \ 'airline_c': [ '#df875f' , '#585858' , 3 , 240 , '' ] ,
      \ }


" Inactive Mode:
let s:IA1 = [ '#eeeeee' , '#404040' , 255 , 236 , '' ]
let s:IA2 = [ '#e4e4e4' , '#585858' , 254 , 240 , '' ]
let s:IA3 = [ '#585858' , '#e4e4e4' , 240 , 254 , '' ]
let g:airline#themes#PaperColorRecharged#palette.inactive = airline#themes#generate_color_map(s:IA3, s:IA2, s:IA1)
let g:airline#themes#PaperColorRecharged#palette.inactive_modified = {
      \ 'airline_c': [ '#262626' , '#404040' , 234 , 236 , '' ] ,
      \ }


" CtrlP:
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
" TODO: Fix this
let g:airline#themes#PaperColorRecharged#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ '#e4e4e4' , '#005f87' , 254 , 4   , ''     ] ,
      \ [ '#e4e4e4' , '#2387af' , 254 , 12  , ''     ] ,
      \ [ '#585858' , '#e4e4e4' , 240 , 254 , 'bold' ] )

