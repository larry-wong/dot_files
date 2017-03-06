set nu
syntax on
set hls
set ts=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nobackup
" set colorcolumn=80
set cursorline

filetype indent on
" set filetype=html
" set autoindent
set smartindent

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_chgwin = 1
let g:netrw_winsize = 150

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

autocmd BufNewFile *.js,*.css,*.vue exec ":call AddComment()"
autocmd BufNewFile *.vue exec ":call AddVue()"

map <F4> :call AddComment()<cr>'s

function AddComment()
    let content = []
    call add(content, "/*=============================================================================")
    call add(content, "#")
    call add(content, "# Copyright (C) ".strftime("%Y")." All rights reserved.")
    call add(content, "#")
    call add(content, "# Author:\tLarry Wang")
    call add(content, "#")
    call add(content, "# Created:\t".strftime("%Y-%m-%d %H:%M"))
    call add(content, "#")
    call add(content, "# Description:\t")
    call add(content, "#")
    call add(content, "=============================================================================*/")
    call append(0, content)
endf

function AddVue()
    let content = []
    call add(content, "<template lang='pug'>")
    call add(content, "</template>")
    call add(content, "")
    call add(content, "<script>")
    call add(content, "export default {")
    call add(content, "}")
    call add(content, "</script>")
    call add(content, "")
    call add(content, "<style lang='stylus' scoped>")
    call add(content, "</style>")
    call append(line('$'),content)
endf

" For fcitx
let g:input_toggle = 0
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=150
autocmd InsertLeave * call Fcitx2en()
autocmd InsertEnter * call Fcitx2zh()
" End for fcitx
