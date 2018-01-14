set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 常用的命令
" :PluginList       - 列出所有已配置的插件
" :PluginInstall     - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
" :PluginClean      - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on

syntax on
let Tlist_Show_One_File=1    " 只展示一个文件的taglist
let Tlist_Exit_OnlyWindow=1  " 当taglist是最后一个窗口时自动退出
let Tlist_Use_Right_Window=1 " 在右边显示taglist窗口
let Tlist_Sort_Type="name"   " tag按名字排序



set nocompatible            " 关闭 vi 兼容模式
set number                  " 显示行号
set cursorline              "行高亮
set t_Co=256				"设置vim为256色。设置终端为256色：export TERM=xterm-256color
colorscheme molokai         " 设定配色方案，在~/.vim文件夹下面新建colors文件夹，然后把color.vim复制到这个文件夹下面

set ruler                   " 打开状态栏标尺
set laststatus=2            " 显示状态栏 (默认值为 1, 当前行号和列号和操作模式显示在最后一行)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\
                            " 设置在状态行显示的信息

set tabstop=4               " 设定 tab 所等同的空格长度为 4
set shiftwidth=4            " 加上这个之后，智能自动缩进变成了4

"搜索时用到的命令
set ignorecase smartcase    " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set nowrapscan              " 禁止在搜索到文件两端时重新搜索
set incsearch               " 输入搜索内容时就显示搜索结果
set hlsearch                " 搜索时高亮显示被找到的文本

"=======================================常用函数================================================

"返回操作系统类型(Windows, Linux等)
function! MySys()
    if has("win16") || has("win32") || has("win64") || has("win95")
        return "windows"
    elseif has("unix")
        return "linux"
    endif
endfunction

"===================================目录树控件===================================================
" F3 NERDTree 切换
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC>:NERDTreeToggle<CR>
"-----------------------------------------------------------------
" plugin - NERD_tree.vim 以树状方式浏览系统中的文件和目录
" :ERDtree 打开NERD_tree         :NERDtreeClose    关闭NERD_tree
" o 打开关闭文件或者目录         t 在标签页中打开
" T 在后台标签页中打开           ! 执行此文件
" p 到上层目录                   P 到根目录
" K 到第一个节点                 J 到最后一个节点
" u 打开上层目录                 m 显示文件系统菜单（添加、删除、移动操作）
" r 递归刷新当前目录             R 递归刷新当前根目录
"--------------------------------------------------------------

"==========================================minibuffer插件======================================
let g:miniBufExplMaxSize = 2	"让buffer窗口最大高度为2
"----------------------------------------------------------------------------------------------
":new newFile，可以新建文件
":e <filename> 打开文件
":ls    当前打开的buf
":bn    下一个buf
":bp    前一个buf
":b<n>    n是数字，第n个buf
":bd <n>   删除buf
":b<tab>    自动补齐
"ctrl+w（按两次可以轮流切换窗口）
"ctrl+w+h/l可以左右切换窗口
"多窗口使用技巧：http://blog.csdn.net/devil_2009/article/details/7006113
"-----------------------------------------------------------------------------------------------

"===========================================tagbar插件==========================================

"if MySys() == "windows"                "设定windows系统中ctags程序的位置
"	let Tlist_Ctags_Cmd = 'ctags'
"elseif MySys() == "linux"              "设定windows系统中ctags程序的位置
"	let Tlist_Ctags_Cmd = '/usr/bin/ctags'
"endif

filetyp on	"文件侦查启动,用以检测文件的后缀
"安装tagbar插件	Bundle 'majutsushi/tagbar'
let g:tagbar_ctags_bin='/usr/bin/ctags'	"设置tagbar使用的ctags的插件,必须要设置对
let g:tagbar_width=30	"设置tagbar的窗口宽度
"let g:tagbar_left=1	"设置tagbar的窗口显示的位置,为左边
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.go call tagbar#autoopen()"打开文件自动 打开tagbar
map <F4> :TagbarToggle<CR>"映射tagbar的快捷键
inoremap <F4> <ESC>:TlistToogle<CR>
"---------------------------------------------------------------------------
"s可以切换排序方式
"?可以打开帮助窗口，注意没有问号
":help tagbar，可以显示所有的帮助信息
"-----------------------------------------------------------------------


" ============================================== 编译 && 运行 ======================================== "
"插入模式
:inoremap <F5> <ESC>:call CompileCode()<CR>
"普通模式
:nnoremap <F5> <ESC>:call CompileCode()<CR>
"常规模式，运算符模式，可视化模式
:nnoremap <F6> :call RunResult()<CR>

"%表示文件名，%<表示文件名去掉后缀
" 编译C源文件
"-pedantic选项能够帮助程序员发现一些不符合 ANSI/ISO C标准的代码，但不是全部
"-Werror选项，那么GCC会在所有产生警告的地方停止编译
func! CompileGcc()
    exec "w"
    let compilecmd="!gcc -Wall -pedantic -std=c99 "
    let compileflag="-o %<"
    exec compilecmd." % ".compileflag
endfunc
" 编译C++源文件
func! CompileCpp()
    exec "w"
    let compilecmd="!g++ -Wall -pedantic -std=c++98 "
    let compileflag="-o %<"
    exec compilecmd." % ".compileflag
endfunc
" 编译Java源文件
func! CompileJava()
    exec "w"
    exec "!javac %"
endfunc
" 编译GO源文件
func! CompileGo()
	exec "w"
	exec "!go build %"
endfunc

" 根据文件类型自动选择相应的编译函数
"&filetype是内部变量，需要在前面加&来使用
func! CompileCode()
        exec "w"
        if &filetype == "c"
            exec "call CompileGcc()"
        elseif &filetype == "cpp"
            exec "call CompileCpp()"
        elseif &filetype == "java"
            exec "call CompileJava()"
		elseif &filetype == "go"
			exec "call CompileGo()"
        elseif &filetype == "lua"
            exec "!lua %<.lua"
        elseif &filetype == "perl"
            exec "!perl %<.pl"
        elseif &filetype == "python"
            exec "!python %<.py"
        elseif &filetype == "ruby"
            exec "!ruby %<.rb"
        endif
endfunc
" 运行可执行文件
func! RunResult()
        exec "w"
        if &filetype == "c"
            exec "! ./%<"
        elseif &filetype == "cpp"
            exec "! ./%<"
		elseif &filetype == "sh"
            exec "!sh ./%"
        elseif &filetype == "java"
            exec "!java %<"
		elseif &filetype == "go"
			exec "! ./%<"
        elseif &filetype == "lua"
            exec "!lua %<.lua"
        elseif &filetype == "perl"
            exec "!perl %<.pl"
        elseif &filetype == "python"
            exec "!python %<.py"
        elseif &filetype == "ruby"
            exec "!ruby %<.rb"
        endif
endfunc

" 设置字体 以及中文支持
if has("win32") || has("win64")
    set guifont=Courier_New:h10:cANSI:b
elseif has("unix")
    set guifont=Courier\ 10\ Pitch\ 10
endif
 
" 配置多语言环境
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


" 用户目录变量$VIMFILES
if MySys() == "windows"
    let $VIMFILES = $VIM.'/vimfiles'
elseif MySys() == "linux"
    let $VIMFILES = $HOME.'/.vim'
endif

