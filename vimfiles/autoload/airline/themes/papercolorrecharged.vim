" Created by Trent Scheffert, November 2015

" Color format:
" [ 'guifg', 'guibg', 'ctermfg', 'ctermbg', 'opts' = '' ]


let g:airline#themes#PaperColorRecharged#palette = {}

let g:airline#themes#PaperColorRecharged#palette.accents = {
      \ 'red': [ '#66d9ef' , '' , 81 , '' , '' ],
      \ }

" Normal Mode:
let s:N1 = [ '#585858' , '#e4e4e4' , 240 , 254 ] " Mode
" text maybe dark
let s:N2 = [ '#e4e4e4' , '#87d787' , 254 , 10  ] " Info
" Text maybe dark
let s:N3 = [ '#eeeeee' , '#5faf5f' , 255 , 2  ] " StatusLine
" Original:
" let s:N1 = [ '#585858' , '#e4e4e4' , 240 , 254 ] " Mode
" let s:N2 = [ '#e4e4e4' , '#0087af' , 254 , 31  ] " Info
" let s:N3 = [ '#eeeeee' , '#005f87' , 255 , 24  ] " StatusLine


let g:airline#themes#PaperColorRecharged#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
" TODO: this line isn't any different, I'm not sure we actually need it
let g:airline#themes#PaperColorRecharged#palette.normal_modified = {
      \ 'airline_c': [ '#eeeeee' , '#5faf5f' , 255 , 24 , '' ] ,
      \ }


" Insert Mode:
let s:I1 = [ '#585858' , '#e4e4e4' , 240 , 254 ] " Mode
let s:I2 = [ '#e4e4e4' , '#0087af' , 254 , 12  ] " Info
let s:I3 = [ '#eeeeee' , '#005f87' , 255 , 4  ] " StatusLine


let g:airline#themes#PaperColorRecharged#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#PaperColorRecharged#palette.insert_modified = {
      \ 'airline_c': [ '#eeeeee' , '#005f87' , 255 , 24 , '' ] ,
      \ }


" Replace Mode:
let g:airline#themes#PaperColorRecharged#palette.replace = copy(g:airline#themes#PaperColorRecharged#palette.insert)
let g:airline#themes#PaperColorRecharged#palette.replace.airline_a = [ '#d7005f'   , '#e4e4e4' , 001 , 254, ''     ]
let g:airline#themes#PaperColorRecharged#palette.replace_modified = {
      \ 'airline_c': [ '#eeeeee' , '#005f87' , 255 , 24 , '' ] ,
      \ }


" Visual Mode:
" s:V1 text from taking the original hex and darkening the hue til green was at 135
" Text cololors from inverting the e4e4e4
let s:V1 = [ '#585858', '#e4e4e4', 24,  254 ]
" TODO: Why is guifg blank?
let s:V2 = [ '',        '#ffaf87', '',  11  ]
let s:V3 = [ '#e4e4e4', '#df875f', 254, 3  ]
" Original:
" let s:V1 = [ '#005f87', '#e4e4e4', 24,  254 ]
" let s:V2 = [ '',        '#0087af', '',  31  ]
" let s:V3 = [ '#e4e4e4', '#005f87', 254, 24  ]

let g:airline#themes#PaperColorRecharged#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#PaperColorRecharged#palette.visual_modified = {
      \ 'airline_c': [ '#e4e4e4', '#df875f', 254, 3  ] ,
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
let g:airline#themes#PaperColorRecharged#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ '#e4e4e4' , '#005f87' , 254 , 4  , ''     ] ,
      \ [ '#e4e4e4' , '#0087af' , 254 , 12  , ''     ] ,
      \ [ '#585858' , '#e4e4e4' , 240 , 254 , 'bold' ] )

