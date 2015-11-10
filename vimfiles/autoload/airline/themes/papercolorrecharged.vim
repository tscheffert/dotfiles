" Created by Trent Scheffert, November 2015

" Color format:
" [ 'guifg', 'guibg', 'ctermfg', 'ctermbg', 'opts' = '' ]


let g:airline#themes#PaperColorRecharged#palette = {}

let g:airline#themes#PaperColorRecharged#palette.accents = {
      \ 'red': [ '#66d9ef' , '' , 81 , '' , '' ],
      \ }

" Normal Mode:
let s:N1 = [ '#e4e4e4' , '#585858' , 254 , 240 ] " Mode
let s:N2 = [ '#585858' , '#87d787' , 240 , 10  ] " Info
let s:N3 = [ '#404040' , '#5faf5f' , 236 , 2   ] " StatusLine


let g:airline#themes#PaperColorRecharged#palette.normal = airline#themes#generate_color_map(s:N3, s:N2, s:N1)
let g:airline#themes#PaperColorRecharged#palette.normal_modified = {
      \ 'airline_c': [ '#404040' , '#5faf5f' , 236 , 2 , '' ] ,
      \ }


" Insert Mode:
let s:I1 = [ '#e4e4e4' , '#585858' , 254 , 240 ] " Mode
let s:I2 = [ '#e4e4e4' , '#0087af' , 254 , 12  ] " Info
let s:I3 = [ '#eeeeee' , '#005f87' , 255 , 4   ] " StatusLine


let g:airline#themes#PaperColorRecharged#palette.insert = airline#themes#generate_color_map(s:I3, s:I2, s:I1)
let g:airline#themes#PaperColorRecharged#palette.insert_modified = {
      \ 'airline_c': [ '#eeeeee' , '#005f87' , 255 , 4 , '' ] ,
      \ }


" Replace Mode:
let g:airline#themes#PaperColorRecharged#palette.replace = copy(g:airline#themes#PaperColorRecharged#palette.insert)
let g:airline#themes#PaperColorRecharged#palette.replace.airline_a = [ '#d7005f' , '#e4e4e4' , 1 , 254 , '' ]
let g:airline#themes#PaperColorRecharged#palette.replace_modified = {
      \ 'airline_c': [ '#eeeeee' , '#005f87' , 255 , 1 , '' ] ,
      \ }


" Visual Mode:
let s:V1 = [ '#e4e4e4' , '#585858' , 254 , 240 ]
let s:V2 = [ '#585858' , '#ffaf87' , 240 , 11  ]
let s:V3 = [ '#404040' , '#df875f' , 236 , 3   ]

let g:airline#themes#PaperColorRecharged#palette.visual = airline#themes#generate_color_map(s:V3, s:V2, s:V1)
let g:airline#themes#PaperColorRecharged#palette.visual_modified = {
      \ 'airline_c': [ '#404040' , '#df875f' , 236 , 3 ] ,
      \ }

" Inactive:
let s:IA = [ '#585858' , '#e4e4e4' , 240 , 254 , '' ]
let g:airline#themes#PaperColorRecharged#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#PaperColorRecharged#palette.inactive_modified = {
      \ 'airline_c': [ '#585858' , '#e4e4e4' , 240 , 254 , '' ] ,
      \ }


" CtrlP:
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
" TODO: Fix this
let g:airline#themes#PaperColorRecharged#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ '#e4e4e4' , '#005f87' , 254 , 4   , ''     ] ,
      \ [ '#e4e4e4' , '#0087af' , 254 , 12  , ''     ] ,
      \ [ '#585858' , '#e4e4e4' , 240 , 254 , 'bold' ] )

