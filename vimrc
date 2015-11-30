syntax enable
syntax on
colorscheme desert
set number
filetype on

set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4

"set nohls
set incsearch
set hlsearch
set syn=cpp
set fileformats=unix,dos

set nocompatible

filetype on

set history=1000

set background=dark

set showmatch

set guioptions-=T

set vb t_vb=

set ruler

set cindent

set tags=./tags,/usr/include/tags,../../tags,../tags

let NERDSpaceDelims=1 " 让注释符与语句之间留一个空格
let NERDCompactSexyComs=1 " 多行注释时样子更好看
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"-----------------------------------------------------------------
"" plugin - NeoComplCache.vim 自动补全插件
"-----------------------------------------------------------------
"let g:neocomplcache_enable_at_startup=1
"let g:neocomplcache_disable_auto_complete = 1
"let g:SuperTabDefaultCompletionType = '<C-X><C-U>'



"进行Tlist的设置
""TlistUpdate可以更新tags
map <F3> :silent! Tlist<CR> "按下F3就可以呼出了
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=0 "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
let Tlist_Process_File_Always=0 "是否一直处理tags.1:处理;0:不处理。不是一直实时更新tags，因为没有必要
let Tlist_Inc_Winwidth=0
let Tlist_Sort_Type = "name"    " 按照名称排序
"let Tlist_Auto_Open=1		"打开VIM自动打开TagList窗口

"winMangerWindow配置
"let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWindowLayout='FileExplorer'
"nmap wm :WMToggle<cr>
let g:winManagerWidth = 30
nmap <silent> <F4> :WMToggle<cr>


"PHP 补全支持
if !exists('g:AutoComplPop_Behavior')
	let g:AutoComplPop_Behavior = {}
	let g:AutoComplPop_Behavior['php'] = []
	call add(g:AutoComplPop_Behavior['php'], {
		\   'command'   : "\<C-x>\<C-o>",
		\   'pattern'   : printf('\(->\|::\|\$\)\k\{%d,}$', 0),
		\   'repeat'    : 0,
		\})
endif

" (){}[]<>自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap < <><ESC>i
:inoremap > <c-r>=ClosePair('>')<CR>

function ClosePair(char)
if getline('.')[col('.') - 1] == a:char
	return "\<Right>"
	else
		return a:char
	endif
	endf
"-----------------------------------------------------------------
"" plugin – checksyntax.vim JavaScript常见语法错误检查
" 默认快捷方式为 F5
" "-----------------------------------------------------------------
let g:checksyntax_auto = 0 " 不自动检查


"set foldenable " 开始折叠
"set foldmethod=syntax " 设置语法折叠
"set foldcolumn=0 " 设置折叠区域的宽度
"setlocal foldlevel=1 " 设置折叠层数为
"set foldclose=all " 设置为自动关闭折叠
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" " 用空格键来开关折叠 >))

" 配置多语言环境 start
if has("multi_byte")
" UTF-8 编码
set encoding=utf-8
set termencoding=utf-8
set formatoptions+=mM
set fencs=utf-8,gbk

if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
	set ambiwidth=double
	endif

if has("win32")
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
	language messages zh_CN.utf-8
	endif
	else
		echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
	endif
" 配置多语言环境 end

" Python 文件的一般设置，比如不要 tab 等
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
autocmd FileType python map <F12> :!python %<CR>

" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y

" 打开javascript对dom、html和css的支持
let javascript_enable_domhtmlcss=1
" 设置字典 ~/.vim/dict/文件的路径
autocmd filetype javascript set dictionary=$VIMFILES/dict/javascript.dict
autocmd filetype css set dictionary=$VIMFILES/dict/css.dict
autocmd filetype php set dictionary=$VIMFILES/dict/php.dict

if has("cscope") && filereadable("cscope")
   set csprg=cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" cscope 配置
" 先按 ctrl+/ 然后
" s: 查找指定标识符的使用位置
" g: 查找指定标识符的定义位置
" c: 查找该函数被调用的位置
" t: 查找指定的文本字符串
" e: 查找指定的正规表达式
" f: 查找指定的文件
" i: 查找该文件在哪些地方被包含
" d: 查找该函数调用了哪些函数
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Remove trailing whitespace when writing a buffer, but not for diff files.
function RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()
