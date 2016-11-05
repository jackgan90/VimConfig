"python << EOF
"import os
"import re
"path = os.environ['PATH'].split(';')

"def contains_msvcr_lib(folder):
    "try:
        "for item in os.listdir(folder):
            "if re.match(r'msvcr\d+\.dll', item):
                "return True
    "except:
        "pass
    "return False

"path = [folder for folder in path if not contains_msvcr_lib(folder)]
"os.environ['PATH'] = ';'.join(path)
"EOF

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_EVN' in os.environ:
	project_base_dir = os.environ['VIRTUAL_EVN']
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"settings for glsl.vim
let g:glsl_file_extensions = '*.glsl,*.vs,*.ps,*.fx,*.frag,*.vert,*.nfx'
filetype off
if has('win32')
	set rtp+=%USERPROFILE%/.vim/bundle/Vundle.vim
else
	set rtp+=~/.vim/bundle/Vundle.vim
endif
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

"Plugin 'tmhedberg/SimpylFold'

"Plugin 'vim-scripts/indentpython.vim'
"code completion
Bundle 'Valloric/YouCompleteMe'
"syntastic check
Plugin 'scrooloose/syntastic'
"theme
"Plugin 'jnurmine/Zenburn'
"theme
"Plugin 'altercation/vim-colors-solarized'
"directory management
Plugin 'scrooloose/nerdtree'
"nerdtree tabs
Plugin 'jistr/vim-nerdtree-tabs'
"file navigation
Plugin 'kien/ctrlp.vim'

"Plugin 'rking/ag.vim'
Plugin 'mhinz/vim-grepper'


Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
Plugin 'FelikZ/ctrlp-py-matcher'
"more beautiful powerline
"Plugin 'vim-airline/vim-airline'
"theme
"Plugin 'nanotech/jellybeans.vim'
"theme
"Plugin 'w0ng/vim-hybrid'
"as name suggests
"Plugin 'vim-airline/vim-airline-themes'

"for window swapping
"Plugin 'wesQ3/vim-windowswap'
Plugin 'beyondmarc/glsl.vim'
"Plugin 'fugalh/desert.vim'
Plugin 'tomasr/molokai'
"Plugin 'juneedahamed/svnj.vim'
"Plugin 'powerline/powerline'
Plugin 'itchyny/lightline.vim'
Plugin 'juneedahamed/vc.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'easymotion/vim-easymotion'
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-fuzzy.vim'
Plugin 'haya14busa/incsearch-easymotion.vim'
call vundle#end()

let mapleader = ','
autocmd FileType python setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4 autoindent
au BufNewFile *.py call setline(1, '# -*- coding: utf-8 -*-')
au BufRead,BufNewFile *.as set filetype=javascript

"helper functions
function! IsBlankLine(lineNum)
	return getline(a:lineNum) !~# '\v\S'
endfunction

func! EditMYVIMRC()
	let linenum = line('$')
	let empty_buf = 1
	for idx in range(1, linenum)
		if !IsBlankLine(idx)
			let empty_buf = 0
			break
		endif
	endfor
	if !empty_buf
		execute "normal! :vsplit $MYVIMRC\<CR>"
	else
		execute "normal! :e $MYVIMRC\<CR>"
	endif
endf

"use space to fold
nnoremap <space> za
"vimrc editing mapping
nnoremap <leader>ev :call EditMYVIMRC()<CR>
nnoremap <leader>er :source $MYVIMRC<CR>
"Ycm key mappings
nnoremap <leader>gl : YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf : YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg : YcmCompleter GoToDefinitionElseDeclaration<CR>
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"cancel highlight when esc pressed 
nnoremap <ESC> :nohl<CR>
"window swapping mapping
"nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
"nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
"nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>
"For tab operation
nnoremap <leader>c :tabclose<CR>
"tagbar 
nnoremap <leader>t :TagbarToggle<CR>
"split size operation
nnoremap <leader>1 :vertical resize +20<CR>
nnoremap <leader>2 :vertical resize -20<CR>
nnoremap <leader>3 :resize +20<CR>
nnoremap <leader>4 :resize -20<CR>
"NerdTree toggle
nnoremap <leader>n :NERDTreeTabsToggle <CR>
"Python delete whole function
onoremap pf :call FindPythonFunctionUnderCursor()<CR>
onoremap pc :call FindPythonClassUnderCursor()<CR>
nnoremap <leader>F :call GotoNextPythonFunction()<CR>
nnoremap <F5> :!python %<CR>
"For easymotion and incsearch
let g:EasyMotion_smartcase = 1
map <Leader> <Plug>(easymotion-prefix)
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)
" incsearch.vim x fuzzy x vim-easymotion

function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin' : 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
"options
set foldmethod=indent
set foldlevel=99
"prevent from encoding error
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,chinese,latin-1
"show line numbers
set nu
"use system clipboard
set clipboard=unnamed
set laststatus=2 " Always display the statusline in all windows
set guifont=Consolas\ for\ Powerline\ FixedD:h11
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set splitright
set guioptions-=T
set guioptions-=m
set incsearch
set tabstop=4
set softtabstop=4
set noexpandtab
set shiftwidth=4
if has("win32")
	set backup
	set backupdir=C:\WINDOWS\Temp
	set backupskip=C:\WINDOWS\Temp\*
	set directory=C:\WINDOWS\Temp
	set undodir=C:\WINDOWS\Temp
	set writebackup
endif

filetype plugin indent on

"resolve menu encoding issue
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"scheme
set background=dark
colorscheme molokai

"Per plugin configuration start
"YCm
let g:ycm_autoclose_preview_window_after_completion=1
"SimpylFold
let g:SimpylFold_docstring_preview=1
"NerdTree
let NERDTreeIgnore=['\.pyc$', '\~$', '\.cache$', '\.exe$', '\.dll$', '\.sfx$', '\.gim$', '\.gis$', '\.jpg$', '\.png$', '\.fla$', '\.swf$', '\.bmp$', '\.map$', '\.scn$', '\.scnex$', '\.tga$', '\.mtg$', '\.ags$', '\.ktx$', '\.mesh$', '\.pvr$', '\.pvr2$', '\.dds$', '\.mtl$', '\.rar$', '\.ttf$', '\.gif$', '\.mp3$', '\.wav$', '\.fsb$', '\.fev$', '\.m4a$'] "ignore files in NERDTree
let g:nerdtree_tabs_open_on_console_startup=1       "automatically open nerdtree tab on startup
"ctrlp
let g:ctrlp_max_files = 0
let g:minBufExplForceSyntaxEnable = 1
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
"rg
"let g:ackprg = 'ag --nogroup --nocolor --column'
if executable('rg')
	"Use ag in Ctrlp for listing files
	let g:ctrlp_user_command='rg --files %s --color never'
	"ag is fast enough that Ctrlp doesn't need to cache
	let g:ctrlp_use_caching = 1
endif
"windows swapping
"let g:windowswap_map_keys = 0 "prevent default bindings
"Per plugin configuration end

syntax on

"G4 routine start
let g:g4_project_root='f:\trunk'
function! G4ChangeCWDToProjectRoot()
	execute 'normal! :cd '. g:g4_project_root. "\<CR>"
	call nerdtree#ui_glue#chRootCwd()
endfunction

nnoremap <leader>go :call G4ChangeCWDToProjectRoot()<CR>
python << EOF
DEFAULT_TELNET_PORT = 30000
import telnetlib
import subprocess
import vim
telnetClients = {}

def get_client_count():
	import psutil
	count = 0
	projectRoot = vim.eval('g:g4_project_root')
	for process in psutil.process_iter():
		try:
			if process.name() != 'client.exe':
				continue
			if process.exe().lower().find(projectRoot) >= 0:
				count += 1
		except:
			pass
	return count

def connect_to_client(callback=None):
	def do_connect():
		global telnetClients
		clientCount = get_client_count()
		for i in xrange(clientCount):
			port =DEFAULT_TELNET_PORT + i
			if port in telnetClients:
				continue
			try:
				tn = telnetlib.Telnet('localhost', port)
				tn.write('\r\n')
				print 'Client Connected!', port
				telnetClients[port] = tn
				if callable(callback):
					callback(tn)
			except:
				pass
	import thread
	thread.start_new_thread(do_connect, ())

def execute_client_gm(cmd):
	validPorts = []
	invalidPorts = []
	global telnetClients
	for port, tc in telnetClients.iteritems():
		try:
			tc.write('$%s\r\n' % cmd)
			validPorts.append(port)
		except:
			invalidPorts.append(port)

	for port in invalidPorts:
		del telnetClients[port]

	connect_to_client(lambda tn: tn.write('$%s\r\n' % cmd))
		

def reload_current_file():
	import base64
	import vim
	filename = vim.eval("expand('%:p')")
	projectRoot = vim.eval('g:g4_project_root')
	if filename.lower().find(projectRoot.lower()) >= 0:
		target = base64.b64encode(bytearray(filename, 'utf-8'))
		execute_client_gm('reloadTarget %s' % target)

def close_telnet_clients():
	global telnetClients
	for tc in telnetClients.itervalues():
		tc.close()
	telnetClients = {}

def reinit_client_telnet():
	close_telnet_clients()
	connect_to_client()



def stop_client():
	import psutil
	projectRoot = vim.eval('g:g4_project_root')
	for process in psutil.process_iter():
		try:
			if process.name() != 'client.exe':
				continue
			if process.exe().lower().find(projectRoot) >= 0:
				process.kill()
		except:
			pass


def launch_client(count=1):
	try:
		count = int(count)
	except:
		count = 1
	for i in xrange(count):
		project_root = vim.eval('g:g4_project_root')
		subprocess.Popen('%s\client\engine\client\client.exe' % project_root,cwd='client')


EOF
let g:g4_auto_reload_current_file = 1
function! G4ReloadCurrentFile()
	if g:g4_auto_reload_current_file
python << EOF
reload_current_file()
EOF
	endif
endfunction

au BufWrite *.py call G4ReloadCurrentFile()
command! -nargs=? ClientGM python execute_client_gm(<f-args>)
command! ClientGMReload python execute_client_gm('reload')
command! BattleGMReload python execute_client_gm('reload battle')
command! ReInitClientTelnet python reinit_client_telnet()
command! ReloadCurrentFile python reload_current_file()
command! ReloadServer execute('!start /B '. g:g4_project_root . '\server\ServerLauncher\reload.bat')
command! StartServer execute('!start /B cd '. g:g4_project_root . '\server\ServerLauncher && start.bat')
command! StartBattle execute('!start /B cd '. g:g4_project_root . '\server\ServerLauncher && battle.bat')
command! -nargs=? StartClient python launch_client(<f-args>)
command! AllServer execute('!start /B cd '. g:g4_project_root . '\server\ServerLauncher && start.bat && battle.bat')
command! KillServers execute('!start /B cd ' . g:g4_project_root . '\server\ServerLauncher && kill.bat')
command! RestartBattle execute('!start /B cd ' . g:g4_project_root . '\server\ServerLauncher && killbattle.bat && battle.bat')
command! StopClient python stop_client()
command! -nargs=* RunServerScript execute('!start /B cd '. g:g4_project_root . '\server\ServerLauncher && '.<q-args>)
command! UpTrunk execute('silent! !svn up ' . g:g4_project_root)
command! UpDesign execute('silent! !svn up ' . g:g4_project_root. '\..\design')
command! UpOutsource execute('silent! !svn up ' . g:g4_project_root. '\..\outsource')
command! LocalExportTable execute('silent! !cd ' . g:g4_project_root.  '\client\tools\export_table_tool_new && export_use_addedFiles')
command! ModelEditor execute('silent! !start /B ' . g:g4_project_root. '\..\outsource\neox\tool_new\modeleditor.exe')
command! FxEditor execute('silent! !start /B ' . g:g4_project_root.  '\..\outsource\neox\tool_new\FxEdit.exe')
command! SceneEditor execute('silent! !start /B ' . g:g4_project_root.  '\..\outsource\neox\tool_new\sceneeditor.exe')
ca gm ClientGM
ca conclient ReInitClientTelnet
ca reloads ReloadServer
ca reloadb BattleGMReload
ca reload ClientGMReload
ca battle StartBattle
ca client StartClient
ca servers AllServer
ca kills KillServers
ca restartbattle RestartBattle
ca killc StopClient
"search map
nnoremap <expr> <leader>ft ':GrepperRg -tpy -w  ' . g:g4_project_root. '\<C-Left><Left>'
nnoremap <expr> <leader>fc ':GrepperRg -tpy -w  ' . g:g4_project_root. '\client\script\<C-Left><Left>'
nnoremap <expr> <leader>fs ':GrepperRg -tpy -w  ' . g:g4_project_root. '\server\<C-Left><Left>'
nnoremap <expr> <leader>fa ':GrepperRg -w  ' . g:g4_project_root. '\client\res\ui\as3\<C-Left><Left>'

let g:is_generating_ctags = 0
if exists('*job_start')
	func! CtagGenerationCallback(channel, msg)
		echom '[ctags]' . a:msg
	endf

	func! CtagCloseHandler(channel)
		echom '[ctags] ------------------- Finished generating ctags for project ------------------------'
		let g:is_generating_ctags = 0
	endf

	func! GenerateCtagAsync()
		if !g:is_generating_ctags
			let cwd = '.'
			let l:command = "ctags -f .\\tags " . 
						\"--exclude *.html --exclude *.h --exclude *.cpp --exclude *.bat --exclude *.xml --exclude *.txt -R ."
			echom '[ctags] ------------------- Start to generate ctags for project ------------------------'
			let l:channel = job_start(l:command, {"callback" : "CtagGenerationCallback", "close_cb" : "CtagCloseHandler"})
			if ch_status(l:channel) == "open"
				let g:is_generating_ctags = 1
			else
				echom 'Some error occured when try to launch ctags channel'
			endif
		else
			echom "There's already a running ctags process updating project tags! Wait for it to finish patiently"
		endif
	endf
	nnoremap <F4> :call GenerateCtagAsync()<CR>
else
	nnoremap <expr> <F4> ':silent! !ctags -f .\tags '. '--exclude *.html --exclude *.h --exclude *.cpp 
	\--exclude *.bat --exclude *.xml --exclude *.txt -R .' . "\<CR>"
endif
"G4 routine end


function! FindNextBlankLineOrViceVersa(startLine, findBlank)
	let maxLine = line('$')
	let currentLine = a:startLine + 1
	while currentLine <= maxLine
		if a:findBlank && IsBlankLine(currentLine)
			return currentLine
		endif
		if !a:findBlank && !IsBlankLine(currentLine)
			return currentLine
		endif
		let currentLine += 1
	endwhile
	return -1
endfunction

function! FindPythonDecoratorStartLine(initialLine)
	let decoratorStartLine = a:initialLine
	let initialIndent = indent(a:initialLine)
	let curLine = decoratorStartLine - 1
	while curLine >= 1
		let lineText = getline(curLine) 
		if lineText !~# '\v\S'	"blank line,should go up to check decorator
			let curLine -= 1
		elseif indent(curLine) != initialIndent
			break
		elseif lineText !~# '\v.*\@\S+'
			break
		else 
			let decoratorStartLine = curLine
			let curLine -= 1
		endif
	endwhile
	return decoratorStartLine
endfunction

function! RecognizePythonStructure(startLine)
	let startIndent = indent(a:startLine)
	let endLine = a:startLine + 1
	let maxLine = line('$')
	let maxFuncNonBlankLine = a:startLine
	if endLine > maxLine
		return maxLine
	endif
	while endLine <= maxLine
		let isBlank = IsBlankLine(endLine)
		if !isBlank && indent(endLine) <= startIndent
			let endLine = maxFuncNonBlankLine
			break
		else
			if !isBlank
				let maxFuncNonBlankLine = endLine
			endif
			let endLine += 1
		endif
	endwhile
	return endLine
endfunction

function! GotoNextPythonFunction()
		let pattern = '\v.*def\s*\S*\(.*\)\s*:'
		let cmd = "silent! normal! /". pattern. "\<CR>l" 
		execute cmd
endfunction


"this method is highly rely on SimpylFold's fold method
function! FindPySignatureByFoldLevel(keyword)
	let originalFoldLv = foldlevel(line('.'))
	let originalLine = line('.')
	let cachedZ = @z
	while 1
		let pattern = '\v.*'. a:keyword .'\s*\S*\(.*\)\s*:'
		let cmd = "silent! normal! mz?". pattern. "\<CR>" 
		execute cmd
		let curLine = line('.')
		if curLine > originalLine
			execute 'normal! `z'
			break
		endif
		if getline(curLine) !~# pattern
			break
		endif
		if foldlevel(curLine) <= originalFoldLv
			break
		endif
	endwhile
	let @z = cachedZ
endfunction

function! FindPythonLaxeme(endInVisualMode, keyword)
	call FindPySignatureByFoldLevel(a:keyword)
	"resolve for decorator
	let startLine = line('.')
	let decoratorStartLine = FindPythonDecoratorStartLine(startLine)
	if !a:endInVisualMode
		return
	endif
	let curLine = RecognizePythonStructure(startLine)
	let repeatJump = curLine - decoratorStartLine
	execute 'silent! normal! '.decoratorStartLine. 'GV' . repeatJump . 'j'
endfunction


function! FindPythonFunctionUnderCursor()
	execute 'silent! normal! $'
	call FindPythonLaxeme(1, 'def')
endfunction

function! FindPythonClassUnderCursor()
	execute 'silent! normal! $'
	call FindPythonLaxeme(1, 'class')
endfunction

function! InsertPythonProfileStart()
	execute "silent! normal! j"
	execute "silent! normal! Iimport cProfile\<CR>"
	execute "silent! normal! Ipr = cProfile.Profile()\<CR>"
	execute "silent! normal! Ipr.enable()\<CR>"
endfunction

function! InsertPythonProfileEnd()
	execute "silent! normal! j"
	execute "silent! normal! Ipr.disable()\<CR>"
	execute "silent! normal! Ioutfile=r'" . g:g4_project_root. "\\profresult'\<CR>"
	execute "silent! normal! Is = open(outfile, 'wb')\<CR>"
	execute "silent! normal! Isortby = 'cumulative'\<CR>"
	execute "silent! normal! Iimport pstats\<CR>"
	execute "silent! normal! Ips = pstats.Stats(pr, stream=s).sort_stats(sortby)\<CR>"
	execute "silent! normal! Ips.dump_stats(outfile + '.prof')\<CR>"
	execute "silent! normal! Ips.print_stats()\<CR>"
	execute "silent! normal! Is.close()\<CR>"
endfunction

nnoremap <leader>sp :call InsertPythonProfileStart()\<CR>
nnoremap <leader>ep :call InsertPythonProfileEnd()\<CR>
nnoremap <expr> <leader>vp ':silent! !start /B pyprof2calltree -k -i ' . g:g4_project_root .  '/profresult.prof' . "\<CR>"

"This function is for vc.vim,forcing it to convert line from chinese encoding to
"utf-8 encoding
func! Before_vc_setline(start, lines)
	let s:convlines = []
	if type(a:lines) == type([])
		for idx in range(0, len(a:lines) - 1)
			call add(s:convlines, iconv(a:lines[idx], 'chinese', 'utf-8'))
		endfor
	else
		let s:convlines = iconv(a:lines, 'chinese', 'utf-8')
	endif
	return s:convlines
endf

