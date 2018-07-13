"插件設定"
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'

Plugin 'scrooloose/nerdtree'				" 樹狀目錄 (F2)
Plugin 'scrooloose/nerdcommenter'			" 快速註釋 (F4)
Plugin 'Chiel92/vim-autoformat'				" 自動格式化 (F8)

Plugin 'Yggdroot/indentLine'				" 縮進顯示
Plugin 'jiangmiao/auto-pairs'				" 符號自動成對
Plugin 'tell-k/vim-autopep8'				" Python PEP8 格式化支援
Plugin 'scrooloose/syntastic'				" 語法檢查
Plugin 'sheerun/vim-polyglot'				" 各種語言的語法高亮
Plugin 'aperezdc/vim-template'				" vim 自動模板
Plugin 'Valloric/YouCompleteMe'				" 自動代碼補齊
Plugin 'Lokaltog/vim-powerline'				" vim powerline

call vundle#end()
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nu					" 顯示行號
set nocompatible		" 去掉vi的一致性
" 隱藏滾動條
set guioptions-=r
set guioptions-=L
set guioptions-=b
set tabstop=4			" 設置table長度
set shiftwidth=4		" 同上
set showtabline=0		" 隱藏頂部標籤欄
set guifont=Menlo\ for\ Powerline			" 設置字體
syntax on				" 開啟語法高亮
set nowrap				" 設置字數過長時不換行
set fileformat=unix		" 設置以unix的格式保存文件
set cindent				" 設置為C語言樣式的縮進格式
set showmatch			" 顯示對應的括號
set scrolloff=1			" 設置捲動行數
set laststatus=2		" 命令行為兩行
set fenc=utf-8			" 文件編碼
set backspace=2			" 啟用 Backspace
set mouse=a				" 啟用鼠標
set selection=inclusive " 選取模式時，游標所在位置也會被選到
set selectmode=mouse,key	" 滑鼠鍵盤都可使用選取模式
set matchtime=5			" 配對括號高亮的時間
set ignorecase			" 搜尋時忽略大小寫
set incsearch			" 未完全輸入完搜尋文字時就開始搜尋
set hlsearch			" 高亮搜索結果
set noexpandtab			" 按下 Tab 時，不會變成4個空白
set whichwrap+=<,>		" 在一般、選取模式下可以使用左右方向鍵跳行
set autoread			" 文件在 vim 之外被修改過會自動重新讀取
set cursorline			" 突顯當前行"
set cursorcolumn		" 突顯當前列"
set encoding=utf-8		" 設定編碼模式避免亂碼


" solarized theme setting
syntax enable
set background=dark
set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized

""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"F5 Build & Run"
map <F5> :call CompileRunGcc() <CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'python'
		exec "! python %"
	elseif &filetype == 'c'
		exec "!g++ % -o %<.out"
		exec "! ./%<.out"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<.out"
		exec "! ./%<.out"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "! java %<"
	elseif &filetype == 'html'
		exec "!chrome % &"
	elseif &filetype == 'mkd'
		exec "!~/.vim/markdown.pl % > %.html &"
		exec "!chrome %.html &"
	endif
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" YouCompleteMe 設定"

" Python 直譯器路徑"
let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
"let g:ycm_python_binary_path = 'python'

" 是否開啟語意補全
let g:ycm_seed_identifiers_with_syntax=1
" 開始補全的字數
let g:ycm_min_num_of_chars_for_completion=2
" 補全後自動關閉預覽窗口
let g:ycm_autoclose_preview_window_after_completion=1
" 禁止快取匹配項，每次都要重新生成匹配項
let g:ycm_cache_omnifunc=1
" 离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" 按TAB自動完成匹配
let g:ycm_key_list_stop_completion = ['<tab>']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTree設定
" F2 開啟關閉
map <F2> :NERDTreeToggle<CR>
" 樹的深度
let NERDTreeChDirMode=1
" 顯示書籤
let NERDTreeShowBookmarks=1
" 忽略文件類型
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
" 窗口大小
let NERDTreeWinSize=25

"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" indentLine
" 開啟(1)或關閉(0)
let g:indentLine_enabled = 1
" 縮進指示線
let g:indentLine_char='┆'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" import 格式化
autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>
" nerdcommenter
let mapleader=','
map <F4> <leader>ci <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-autoformat
au BufWrite * :Autoformat " 保存時自動格式化
noremap <F8> :Autoformat<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" syntastic 設定
let g:syntastic_error_symbol='✗'	" 程式碼錯符號
let g:syntastic_warning_symbol='⚠'	" 程式碼警告符號
let g:syntastic_check_on_open=0		" 關閉 文件開啟時檢查
let g:syntastic_check_on_wq=1		" 開啟 文件儲存後檢查


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 模板設定
" 定義模板所在資料夾
let g:templates_directory = '~/.Code_templates'
" 定義作者Email
let g:email = 'finn79426@gmail.com'
