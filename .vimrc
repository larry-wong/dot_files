" Auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" My plugins
call plug#begin('~/.vim/bundle')
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
Plug 'lervag/vimtex'
Plug 'leafgarland/typescript-vim'
call plug#end()
" End for plugins

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

" For ale
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_fixers = {'typescript': ['eslint']}
let g:ale_fix_on_save = 1
" End for ale

" For vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
" End for vimtex

autocmd BufNewFile *.js,*.ts,*.css,*.vue,*.ino exec ":call AddComment()"
autocmd BufNewFile *.vue exec ":call AddVue()"

map <F4> :call AddComment()<cr>'s

function AddComment()
    let content = []
    call add(content, "/*=============================================================================")
    call add(content, "#")
    call add(content, "# Copyright (C) ".strftime("%Y")." All rights reserved.")
    call add(content, "#")
    call add(content, "# Author:   Larry Wang")
    call add(content, "#")
    call add(content, "# Created:  ".strftime("%Y-%m-%d %H:%M"))
    call add(content, "#")
    call add(content, "# Description:")
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

set background=dark
