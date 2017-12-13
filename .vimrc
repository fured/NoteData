let $VIMRUNTIME="/usr/share/vim/vim80"
set runtimepath=/usr/share/vim/vim80
syntax enable
"=========================一般设置======================================= 
set nocompatible          "vim比vi支持更多的功能，如showcmd，避免冲突和副作用，最好关闭兼容 
set encoding=utf-8	  "使用utf-8编码 
set number                "显示行号 
set showcmd               "显示输入命令 
"set mouse=a               "可以在buffer的任何地方使用鼠标 
set pastetoggle=<F3>      "F3快捷键于paste模式与否之间转化，防止自动缩进 
set cursorline            "显示当前行 
set hlsearch              "显示高亮搜索 
set history=100           "默认指令记录是20 
set ruler                 "显示行号和列号（默认打开) 
set pastetoggle=<F3>      "F3快捷键于paste模式与否之间转化，防止自动缩进 
 
"===========================文本格式排版================================o 
set tabstop=4              "设置tab长度为4 
set shiftwidth=4           "设置自动对齐的缩进级别 
set cindent                "自动缩进,以c语言风格，例如从if进入下一行，会自动缩进shiftwidth大小 
set autoindent              "autoindent配合下面一条命令根据不同语言类型进行不同的缩进操作，更加智能

"===========================vundle Plugin managerment插件管理器================================
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/autoload
call vundle#begin()
Plugin 'vim-scripts/khaki.vim'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'artur-shaik/vim-javacomplete2'
call vundle#end()
filetype plugin indent on

"==========================color cheme配色方案：khaki===================================
"if !has("gui_running")
"	set t_Co=256
"endif
"colorscheme khaki
"set rtp+=~/.vim/bundle/Solarized
"colorscheme solarized
"==========================automatic 补全====================
let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
" YCM                                                              
" 允许自动加载.ycm_extra_conf.py，不再提示                         
let g:ycm_confirm_extra_conf=0                                     
" 补全功能在注释中同样有效                                         
let g:ycm_complete_in_comments=1                                   
" 开启tags补全引擎                                                 
let g:ycm_collect_identifiers_from_tags_files=1                    
" 键入第一个字符时就开始列出匹配项                                 
let g:ycm_min_num_of_chars_for_completion=1                        
" YCM相关快捷键，分别是\gl, \gf, \gg                                                    
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>              
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>               
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
"================================java-complete=======================
"java config 配置java自动补全
"blog.csdn.net/wangran51/article/details/7248945
setlocal omnifunc=javacomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete   
"自动补全
autocmd FileType java set completefunc=javacomplete#CompleteParamsInf
"参数提醒
"inoremap <buffer><C-X><C-U> <C-X><C-U><C-P>
inoremap <buffer><C-S-Space> <C-X><C-U><C-P>

autocmd FileType java,javascript,jsp inoremap <buffer>. .<C-X><C-O><C-P>
"Ctrl+X Ctrl+U 提示功能
"autocmd FileType java set omnifunc=javacomplete#Complete
