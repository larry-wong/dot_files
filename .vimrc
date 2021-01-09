" Auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" My plugins
call plug#begin('~/.vim/bundle')
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
" Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
Plug 'sirtaj/vim-openscad'
" Plug 'lervag/vimtex'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
" Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
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
hi SignColumn ctermbg=None

filetype indent on
" set filetype=html
" set autoindent
set smartindent

" For split separator
set fillchars+=vert:│
hi VertSplit cterm=NONE ctermbg=NONE
" End for split separator

" For NERDTree
let NERDTreeMinimalUI = 1
let g:NERDTreeDirArrowExpandable = '.'
let g:NERDTreeDirArrowCollapsible = '-'

" Quit vim if NERDTree is the last only window
au bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

function NERDTreeAddFile()
  let l:curDirPath = g:NERDTreeDirNode.GetSelected().path.str() . nerdtree#slash()
  let l:title = 'Add a file'
  let l:divider = '=========================================================='
  let l:filename = input(l:title . "\n" . l:divider . "\n" . l:curDirPath)
  if l:filename ==# ''
    call nerdtree#echo('File Creation Aborted.')
    return
  endif
  try
    " move to previous window
    exec ':wincmd p'
    exec 'edit ' . l:curDirPath . l:filename
    " write the new file to disk for NERDTree's reloading
    exec ':w'
    " back to NERDTree
    exec ':wincmd p'
    " reload NERDTree
    exec 'normal r'
    " finally back to previous window
    exec ':wincmd p'
  catch
    call nerdtree#echoWarning('File Not Created.')
  endtry
endfunction

au VimEnter * exec ":call NERDTreeAddMenuItem({
  \ 'text': 'add a (f)ile',
  \ 'shortcut': 'f',
  \ 'callback' : 'NERDTreeAddFile' })"

" End for NERDTree

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" For fzf.vim
:nnoremap <C-p> :GFile -co --exclude-standard<CR>
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" End for fzf.vim

" For ale
let g:ale_completion_enabled = 1
set completeopt=menu,menuone,popup,noselect,noinsert
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_fixers = {'typescript': ['eslint'], 'typescriptreact': ['eslint'], 'markdown': ['prettier']}
let g:ale_completion_autoimport = 1
let g:ale_fix_on_save = 1
hi ALEErrorSign ctermfg=Red ctermbg=NONE
hi ALEWarningSign ctermfg=Yellow ctermbg=NONE
hi ALEWarning ctermfg=Black ctermbg=Yellow
hi ALEError ctermfg=White ctermbg=Red
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" End for ale

" For vimtex
" let g:tex_flavor='latex'
" let g:vimtex_view_method='zathura'
" End for vimtex

" For nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" End for nerdcommenter

" For airline
let g:airline_theme='angr'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_section_y = airline#section#create(['ffenc'])
let g:airline_section_z = airline#section#create(['%P'])
" End for airline

" My shortcuts
nnoremap <leader><leader>b :Buffers<CR>
map <leader><leader>c <plug>NERDCommenterToggle
nnoremap <leader><leader>d :ALEGoToDefinition<CR>
nnoremap <leader><leader>f :Rg<CR>
nnoremap <leader><leader>r :ALEFindReferences<CR>
nnoremap <leader><leader>t :NERDTreeFind<CR>
nnoremap <leader><leader>v :vsp<CR>
nnoremap <leader><leader>vv :Gvsplit HEAD:%<CR>
nnoremap <leader><leader>w :Git blame<CR>
nnoremap <leader><leader>x :ALEFix<CR>
" End for my shortcuts

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
