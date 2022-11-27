"set showmatch       " show matching brackets.
set ignorecase
set smartcase
"set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set mouse=a         " Enable mouse usage (all mouse)
set timeout timeoutlen=1500 " waiting time whne keying leading key

" bg, term's color bits
set background=dark
set t_Co=256 " means term Color, reference: https://www.ditig.com/256-colors-cheat-sheet

" hightlight search
set hlsearch
set incsearch
"pattern's highlight(hl) color, color reference to: https://www.ditig.com/256-colors-cheat-sheet
highlight Search ctermbg=155 ctermfg=0
highlight IncSearch ctermbg=black ctermfg=red
"highlight MatchParen cterm=underline ctermbg=NONE ctermfg=NONE

" line number
set nu
set rnu " relativenumber
highlight LineNr ctermbg=0 ctermfg=118 cterm=NONE " the cterm not work. :help attr-list
highlight CursorLineNr ctermbg=0 ctermfg=red

" cursor
set cursorline
set cursorlineopt=number " number, line, screenline, both
highlight CursorLine ctermbg=black ctermfg=white  cterm=inverse " I don't know why not work?

" cancle auto comment next line
set formatoptions-=o " hit o or O
set formatoptions-=r " hit enter
set formatoptions-=c " auto wrap next line if comment too long

" indent
"set autoindent " start the newline and will deal the indent
set smartindent
inoremap # X^H# " remove auto to left when typing # 
au BufRead,BufNewFile *.cpp,*.c,*.h,*.hpp set cindent

" tab
set expandtab  " expand the tab key as the space
set tabstop=4  " key one time tab, indent 4 space
set shiftwidth=4 " if auto indent, will indent 4 space
set backspace=2 " function?

" encoding 
set fencs=utf-8,big5,gb18030,utf-16 "fileencodings

" fold setting
set foldmethod=marker "{{{}}} as the fold marker
"set foldmethod=syntax

" show space, tab, newline, end_of_line
set listchars=tab:\|\ 
"set listchars=tab:\┊\ 
""set listchars=tab:\┆\ 
"set listchars=tab:\¦\ 
"set list
set listchars+=tab:\|\
set listchars+=space:.

" status and ruler
"set statusline=\PATH:\ %r%F\ \ \ \ \LINE:\ %l/%L/%P\ TIME:\ %{strftime('%c')}
set ruler
"set rulerformat=%55(%{strftime('%F\ %H:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
set rulerformat=%36(%{strftime('%F\ %H:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
" set the isfilename to get ride of the = character;
"set isfname=@,48-57,/,.,-,_,+,,,#,$,%,~

"  cursor shape and color in different mode
"  -- the new way --
" 0: blinking block; 1: blinking block; 2: steady block; 3: blinking underline
" 4: steady underline; 5: blinking bar(xterm); 6: steady bar(xterm)
"let &t_SI = "\e[5 q" " just shape 
"let &t_EI = "\e[6 q"
let &t_SI = "\e[5 q\e]12;green\x7" " with color
let &t_EI = "\e[1 q\e]12;red\x7"
"  -- the old way -- 
"if has("autocmd")
"  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
"  au InsertEnter,InsertChange *
"    \ if v:insertmode == 'i' | 
"    \   silent execute '!echo -ne "\e[5 q\e]12;orange\a\2"' | redraw! |
"    \ elseif v:insertmode == 'r' |
"    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
"    \ endif
"  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
"endif

"  ---------------------------------------------------------------
"  **********************abou the command set**********
"  ---------------------------------------------------------------
:command W w
"  ---------------------------------------------------------------
"  ********************** the test setting (provisonal) **********
"  ---------------------------------------------------------------
au BufWritePre *.html :normal gg=G
" you can serach" < How can I emulate key press on Vim startup? > " in the
" google
"funciton: when you open the file, press the zz automatically in the vim, that is very useful
"au BufRead *.goal :execute "normal zz" 
"au BufRead *.txt :execute "normal z\<Cr>"
au BufRead,BufNewFile *.txt,*.goal,*.pratice :execute "normal zz\<Cr>"
"--------------------------------------------------------------------------------
" Automatically open the quickfix window on: make
"--------------------------------------------------------------------------------
" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
"autocmd QuickFixCmdPost [^l]* nested copen "always open the quickfix
autocmd QuickFixCmdPost    l* nested lwindow
"
"--------------------------------------------------------------------------------
" underline, overline, and the strikeout line
"--------------------------------------------------------------------------------
" EXPLANATION:
" reference to the url:
" https://vim.fandom.com/wiki/Create_underlines,_overlines,_and_strikethroughs_using_combining_characters
" usage: :Overline;  or the :Underline  or the :DoubleUnderline or the
" Strikethrough
"--------------------------------------------------------------------------------
" modify selected text using combining diacritics
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')
function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction

"-------------------- customerized source files --------------------
"source ~/.vim/hgj-vim-config/func.vim " function
source ~/.vim/hgj-vim-config/map.vim "map
"source ~/.vim/hgj-vim-config/plugin-setting.vim " plugin
