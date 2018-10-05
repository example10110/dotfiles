"no menu bar, tool bar and scroll bar
set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b

colorscheme solarized
set background=dark

if has('win32')
  set guifont=Ricty_Diminished:h11:cSHIFTJIS:qDRAFT
else 
  set guifont=Ricty\ Diminished\ 13
endif
