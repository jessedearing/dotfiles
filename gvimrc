set antialias

" Autosave when window loses focus
au FocusLost * :w

if has("gui_macvim")
  set shell=/bin/zsh
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Command-T for CommandT
  macmenu &File.New\ Tab key=<D-T>
  " map <D-t> :CommandT<CR>
  " imap <D-t> <Esc>:CommandT<CR>
  map <D-t> :CtrlP<CR>
  imap <D-t> <Esc>:CtrlP<CR>

  " Command-Return for fullscreen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

  " Command-Shift-F for Grep
  map <D-F> :Ack<space>

  " Command-/ to toggle comments
  map <D-/> <plug>NERDCommenterToggle<CR>

  " Map Command-# to switch tabs
  map  <D-0> 0gt
  imap <D-0> <Esc>0gt
  map  <D-1> 1gt
  imap <D-1> <Esc>1gt
  map  <D-2> 2gt
  imap <D-2> <Esc>2gt
  map  <D-3> 3gt
  imap <D-3> <Esc>3gt
  map  <D-4> 4gt
  imap <D-4> <Esc>4gt
  map  <D-5> 5gt
  imap <D-5> <Esc>5gt
  map  <D-6> 6gt
  imap <D-6> <Esc>6gt
  map  <D-7> 7gt
  imap <D-7> <Esc>7gt
  map  <D-8> 8gt
  imap <D-8> <Esc>8gt
  map  <D-9> 9gt
  imap <D-9> <Esc>9gt
endif

set list listchars=tab:\ \ ,trail:·

" Start without the toolbar
set guioptions-=T

set transparency=10

" set guifont=DejaVu\ Sans\ Mono:h12
set guifont=Anonymous\ Pro\ for\ Powerline:h15

colorscheme tubster

set clipboard=unnamed

" Include user's local vim config
if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif
