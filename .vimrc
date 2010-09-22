" Включаем несовместимость настроек с Vi (ибо Vi нам и не понадобится).
set nocompatible

" Get that filetype stuff happening
filetype on
filetype plugin on
filetype indent on

" Don't update the display while executing macros
set lazyredraw

" At least let yourself know what mode you're in
set showmode

" Let's make it easy to edit this file (mnemonic for the key sequence is
" 'e'dit 'v'imrc)
nmap <silent> ,ev :e $MYVIMRC<cr>

" And to source this file as well (mnemonic for the key sequence is
" 's'ource 'v'imrc)
nmap <silent> ,sv :so $MYVIMRC<cr>

" Toggle paste mode
nmap  ,p :set invpaste:set paste?

" Turn off that stupid highlight search
nmap  ,n :set invhls<cr>:set hls?<cr>

" Set text wrapping toggles
nmap  ,w :set invwrap:set wrap?

" Set up retabbing on a source file
nmap  ,rr :1,$retab

" cd to the directory containing the file in the buffer
nmap  ,cd :lcd %:h

" Make the directory that contains the file in the current buffer.
" This is useful when you edit a file in a directory that doesn't
" (yet) exist
nmap  ,md :!mkdir -p %:p:hset nu

" Close the window below this one
noremap <silent> ,cj :wincmd j<cr>:close<cr>

" Close the window above this one
noremap <silent> ,ck :wincmd k<cr>:close<cr>

" Close the window to the left of this one
noremap <silent> ,ch :wincmd h<cr>:close<cr>

" Close the window to the right of this one
noremap <silent> ,cl :wincmd l<cr>:close<cr>

" Close the current window
noremap <silent> <C-c> :close<cr>

" Move the current window to the right of the main Vim window
noremap <silent> ,ml <C-W>L

" Move the current window to the top of the main Vim window
noremap <silent> ,mk <C-W>K

" Move the current window to the left of the main Vim window
noremap <silent> ,mh <C-W>H

" Move the current window to the bottom of the main Vim window
noremap <silent> ,mj <C-W>J

" Set the search scan to wrap around the file
set wrapscan

" Set the forward slash to be the slash of note.  Backslashes suck
" This is really only applicable to Windows but I like to have a vimrc
" that works no matter what OS I'm currently on
set shellslash

" Make command line two lines high
"set ch=2

" set visual bell -- I hate that damned beeping
set vb

" Set utf8 encoding
set enc=utf-8
" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

set nu
" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

" set foldmethod=indent
set incsearch
set nohlsearch
" Теперь нет необходимости передвигать курсор к краю экрана, чтобы подняться в
" режиме редактирования
set scrolljump=7
"
" Теперь нет необходимости передвигать курсор к краю экрана, чтобы
" опуститься в режиме редактирования
set scrolloff=7

set history=500 " увеличение истории команд

" allow to use backspace instead of "x"
set backspace=indent,eol,start whichwrap+=<,>,[,]

" Скрывать указатель мыши, когда печатаем
set mousehide

" Сделать строку команд высотой в одну строку
"set ch=1

" Скрыть панель в gui версии ибо она не нужна
"set guioptions=ac

" Не выгружать буфер, когда переключаемся на другой
" Это позволяет редактировать несколько файлов в один и тот же момент без
" необходимости сохранения каждый раз когда переключаешься между ними
set hidden

" Скрывать указатель мыши, когда печатаем
set mousehide

" Включить автоотступы
set autoindent

" Влючить подстветку синтаксиса
syntax on

" Поддержка мыши
set mouse=a
set mousemodel=popup

" Преобразование Таба в пробелы
set expandtab

" Размер табулации по умолчанию
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Формат строки состояния
set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P
set laststatus=2

" Показывать положение курсора всё время.
set ruler

" Показывать незавершённые команды в статусбаре
set showcmd

" Включаем "умные" отспупы ( например, автоотступ после {)
set smartindent

" Заставляем shift-insert работать как в Xterm
map <S-Insert> <MiddleMouse>

" Пробел в нормальном режиме перелистывает страницы
nmap <Space> <PageDown>

set clipboard=unnamed " нормальная работа со стандартным буфером обмена
set novisualbell " отключается в gvim мигание экрана, когда нажимаешь <ESC>
"set cursorline " подсвечиваем текущую строчку

" C-y удаляет текущую строку
nmap <C-y> dd
imap <C-y> <esc>ddi

" Поиск и замена слова под курсором
"nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/

" Вставляем строку не переходя в режим вставки
"map <S-CR> O<Esc>
"map <cr> o<Esc>

" окно ниже
map <C-j> <C-W>j
imap <C-j> <C-o><C-j>

" окно выше
map <C-k> <C-W>k
imap <C-k> <C-o><C-k>

" окно правее
map <C-l> <C-W>l
imap <C-l> <C-o><C-l>

" окно левее
map <C-h> <C-W>h
imap <C-h> <C-o><C-h>

" 'умный' Home
nmap <Home> ^
imap <Home> <Esc>I

" Следующий буффер
nmap <C-Tab> :bn<CR>

" Закрываем текущий буфер
nmap <C-F4> :bd<CR>

" Запуск проверки правописания
set wildmenu
set wcm=<Tab>
menu Spl.next ]s
menu Spl.prev [s
menu Spl.word_good zg
menu Spl.word_wrong zw
menu Spl.word_ignore zG
imap <F8> <Esc>:setlocal spell spelllang=ru,en<CR>a
nmap <F8> :setlocal spell spelllang=ru,en<CR>
imap <S-F8> <Esc>:setlocal spell spelllang=<CR>a
nmap <S-F8> :setlocal spell spelllang=<CR>
imap <C-F8> <Esc>:emenu Spl.<TAB>
nmap <C-F8> :emenu Spl.<TAB>

" F2 - быстрое сохранение
nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>i
imap <F2> <esc>:w<cr>i

" F3 - просмотр ошибок
nmap <F3> :copen<cr>
vmap <F3> <esc>:copen<cr>
imap <F3> <esc>:copen<cr>

" F4 - переход к следующей ошибке
nmap <F4> :cn<cr>
vmap <F4> <esc>:cn<cr>
imap <F4> <esc>:cn<cr>

" F5 - просмотр списка буферов
nmap <F5> <Esc>:BufExplorer<cr>
vmap <F5> <esc>:BufExplorer<cr>
imap <F5> <esc><esc>:BufExplorer<cr>

" F6 - 
map <F6> :vimgrep /fixme\\|todo\\|TODO/j *.[c,cpp,h,hpp,py]<CR>:cw<CR>

" F7 - "make" команда
map <F7> :wa<cr>:make<cr>
vmap <F7> <esc>:make<cr>i
imap <F7> <esc>:make<cr>i

" F10 - показать окно Taglist
map <F10> :TlistToggle<cr>
vmap <F10> <esc>:TlistToggle<cr>
imap <F10> <esc>:TlistToggle<cr>

" F11 - показать окно Project
nmap <silent> <F11> <Plug>ToggleProject
"map <F11> :Project<cr>
"vmap <F11> <esc>:Project<cr>
"imap <F11> <esc>:Project<cr>

" F12 - обозреватель файлов
map <F12> :Ex<cr>
vmap <F12> <esc>:Ex<cr>i
imap <F12> <esc>:Ex<cr>i

" Меню выбора кодировки текста (koi8-r, cp1251, cp866, utf8)
set wildmenu
set wcm=<Tab> 
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>
menu Encoding.utf-8 :e ++enc=utf8 <CR>

" Аналогично и для {
imap {<CR> {<CR>}<Esc>O

" С-q - выход из Vim
map «C-Q> «Esc>:qa«cr>

" Автозавершение слов по tab =)
function InsertTabWrapper()
     let col = col('.') - 1
     if !col || getline('.')[col - 1] !~ '\k'
         return "\«tab>"
     else
         return "\«c-p>"
     endif
endfunction
imap <tab> <c-r>=InsertTabWrapper()<cr>

" С-q - выход из Vim 
map <C-Q> <Esc>:qa<cr>

" Слова откуда будем завершать
set complete=""
" Из текущего буфера
set complete+=.
" Из словаря
set complete+=k
" Из других открытых буферов
set complete+=b
" Из других открытых окон
set complete+=w
" из тегов 
set complete+=t

" < & > - делаем отступы для блоков
vmap < <gv
vmap > >gv

" Что б убрать строчки "-----" в фолдингах и "|" в вертикальных разделителях
" окон:
set fillchars=vert:\ ,fold:\ 

" Закрывать фолдинги автоматически (мне показалось очень удобно)
set foldclose=all

" Полезно если надо один раз скопировать и много раз заменить выделение (иначе
" надо копировать в именованый регистр)
vnoremap p "_dP

" При создании нового заголовочного файла C\C++ вставлять следующее:
" #ifndef HEADER_FILE_NAME_H
" #define HEADER_FILE_NAME_H
" тут курсор
" #endif

function! NewHFile()
let filename=substitute(toupper(expand("%:t")), '[^A-Z]', '_', 'g')
execute "normal i"."#ifndef ".filename."\<cr>"."#define ".filename."\<cr>\<cr>\<cr>\<cr>"."#endif"."\<esc>0kk"
set nomodified
endfunction
autocmd BufNewFile *.h,*.hpp,*.H,*.hh call NewHFile()

" Работа с системой контроля версий
nmap <Leader>va <Plug>VCSAdd
nmap <Leader>vn <Plug>VCSAnnotate
nmap <Leader>vc <Plug>VCSCommit
nmap <Leader>vd <Plug>VCSDiff
nmap <Leader>vg <Plug>VCSGotoOriginal
nmap <Leader>vG <Plug>VCSGotoOriginal!
nmap <Leader>vl <Plug>VCSLog
nmap <Leader>vL <Plug>VCSLock
nmap <Leader>vr <Plug>VCSReview
nmap <Leader>vs <Plug>VCSStatus
nmap <Leader>vu <Plug>VCSUpdate
nmap <Leader>vU <Plug>VCSUnlock
nmap <Leader>vv <Plug>VCSVimDiff

map ё `
map й q
map ц w
map у e
map к r
map е t
map н y
map г u
map ш i
map щ o
map з p
map х [
map ъ ]
map ф a
map ы s
map в d
map а f
map п g
map р h
map о j
map л k
map д l
map ж ;
map э '
map я z
map ч x
map с c
map м v
map и b
map т n
map ь m
map б ,
map ю .
"map . /

map Ё ~
map Й Q
map Ц W
map У E
map К R
map Е T
map Н Y
map Г U
map Ш I
map Щ O
map З P
map Х {
map Ъ }
map Ф A
map Ы S
map В D
map А F
map П G
map Р H
map О J
map Л K
map Д L
map Ж :
map Э "
map Я Z
map Ч X
map С C
map М V
map И B
map Т N
map Ь M
map Б <
map Ю >
"map , ?

" Подсвечивать строки длинее 80 символов
au BufWinEnter *.* let w:m1=matchadd('Search', '\%>80v.*', -1)

" Когда мы меняем что-либо, это что-либо не сразу удаляется
set cpoptions+=$

" Гуляем курсором по местам, в которых нет символов.
"set virtualedit=all

" Автоматический перенос строки, как только длинна строки превысит textwidth
set formatoptions=tcqb
