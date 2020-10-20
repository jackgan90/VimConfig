set langmenu=en_US.UTF-8
let $LANG = 'en_US'
function! s:UsingPython3()
  if has('python3')
    return 1
  endif
    return 0
endfunction
let s:using_python3 = s:UsingPython3()
let s:python_until_eof = s:using_python3 ? "python3 << EOF" : "python << EOF"

filetype off
if has('win32')
	set rtp+=%USERPROFILE%/.vim/bundle/Vundle.vim
else
	set rtp+=~/.vim/bundle/Vundle.vim
endif
filetype plugin indent on

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"syntastic check
Plugin 'scrooloose/syntastic'
"theme
"Plugin 'jnurmine/Zenburn'
"theme
Plugin 'altercation/vim-colors-solarized'
Plugin 'JazzCore/ctrlp-cmatcher'
"directory management
Plugin 'scrooloose/nerdtree'
"nerdtree tabs
Plugin 'jistr/vim-nerdtree-tabs'
"file navigation
Plugin 'ctrlpvim/ctrlp.vim'

"Plugin 'rking/ag.vim'
"Plugin 'mhinz/vim-grepper'


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
Plugin 'tikhomirov/vim-glsl'
"Plugin 'fugalh/desert.vim'
"Plugin 'tomasr/molokai'
"Plugin 'juneedahamed/svnj.vim'
"Plugin 'powerline/powerline'
Plugin 'itchyny/lightline.vim'
"Plugin 'juneedahamed/vc.vim'
"Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-repeat'
Plugin 'easymotion/vim-easymotion'
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-fuzzy.vim'
Plugin 'haya14busa/incsearch-easymotion.vim'
"code completion
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
"Plugin 'skywind3000/asyncrun.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'dyng/ctrlsf.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'vim-python/python-syntax'
Plugin 'Shougo/echodoc.vim'
Plugin 'dracula/vim'
call vundle#end()

"general options
set foldmethod=indent
set foldlevel=99
"prevent from encoding error
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,chinese,latin-1
"show line numbers
set nu
"use system clipboard
set clipboard=unnamed
set laststatus=2 " Always display the statusline in all windows
set guifont=Consolas\ NF:h11
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set splitright
set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set hlsearch
set incsearch
set ignorecase
set smartcase
set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set bs=indent,eol,start
syntax on
set background=dark

"platform configuration start
if has("win32")
	set nobackup
	set backupdir=C:\\Temp
	set backupskip=C:\\Temp\\*
	set directory=C:\\Temp
	set undodir=C:\\Temp
	set writebackup
	set rop=type:directx
endif
if !has('unix')
	colorscheme dracula
endif
"platform configuration end


let mapleader = ','
au! FileType python setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4 autoindent
au! BufNewFile *.py call setline(1, '# -*- coding: utf-8 -*-')
au! BufRead,BufNewFile *.as set filetype=javascript
au! BufNewFile,BufRead *.vs,*.fs,*.glsl,*.nfx,*.spzs set ft=glsl
"set tags=./tags;,tags

"helper functions

func! IsMac()
	if !has("unix")
		return 0
	endif
	let s:uname = system("uname")
	if s:uname == "Darwin\n"
		return 1
	else
		return 0
	endif
	return 0
endf

function! IsBlankLine(lineNum)
	return getline(a:lineNum) !~# '\v\S'
endfunction

func! EditMyVimRc()
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
nnoremap <leader>ev :call EditMyVimRc()<CR>
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
"next tag, previous tag
nnoremap <leader>] :tn<CR>
nnoremap <leader>[ :tp<CR>
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
nnoremap <leader>1 :vertical resize +15<CR>
nnoremap <leader>2 :vertical resize -15<CR>
nnoremap <leader>3 :resize +10<CR>
nnoremap <leader>4 :resize -10<CR>
"NerdTree toggle
nnoremap <leader>n :NERDTreeTabsToggle<CR>
"Python delete whole function
onoremap pf :call FindPythonFunctionUnderCursor()<CR>
onoremap pc :call FindPythonClassUnderCursor()<CR>
nnoremap <F5> :!python %<CR>
nnoremap tn :tabnew<CR>
"For easymotion and incsearch
"let g:EasyMotion_smartcase = 1
"map <Leader> <Plug>(easymotion-prefix)
"map /  <Plug>(incsearch-forward)
"map ?  <Plug>(incsearch-backward)
"map g/ <Plug>(incsearch-stay)
"map z/ <Plug>(incsearch-easymotion-/)
"map z? <Plug>(incsearch-easymotion-?)
"map zg/ <Plug>(incsearch-easymotion-stay)
"for indent guides
nnoremap <leader>gd :IndentGuidesToggle<CR>
" incsearch.vim x fuzzy x vim-easymotion
noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
"CtrlSF start
nnoremap <leader>ff :CtrlSF 
nnoremap <expr> <leader>fw ':CtrlSF ' . expand('<cword>') . "\<CR>"
nnoremap <leader>ft :CtrlSFToggle<CR>
"CtrlSF end

"Per plugin configuration start

"python-syntax config start
let g:python_version_2 = 1
let g:python_highlight_class_vars = 0
let g:python_highlight_indent_errors = 0
let g:python_highlight_space_errors = 0
let g:python_highlight_operators = 0
let g:python_highlight_all = 1
let g:python_slow_sync = 0
"python-syntax config end

"easymotion start
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin' : 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction
"easymotion end

"YCM start
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
"YCM end

"UltiSnips start
let g:UltiSnipsExpandTrigger = '<c-j>'
if has('win32') || has('win64')
	let g:UltiSnipsSnippetDirectories=[expand('$USERPROFILE').'\.vim\UltiSnips']
else
	let g:UltiSnipsSnippetDirectories=['~/.vim/UltiSnips']
endif
"UltiSnips end

"NerdTree start
let NERDTreeIgnore=['\.pyc$', '\~$', '\.cache$', '\.exe$', '\.dll$', '\.sfx$', '\.gim$', '\.gis$', '\.jpg$', '\.png$', '\.fla$', '\.swf$', '\.bmp$', '\.map$', '\.scn$', '\.scnex$', '\.tga$', '\.mtg$', '\.ags$', '\.ktx$', '\.mesh$', '\.pvr$', '\.pvr2$', '\.dds$', '\.mtl$', '\.rar$', '\.ttf$', '\.gif$', '\.mp3$', '\.wav$', '\.fsb$', '\.fev$', '\.m4a$'] "ignore files in NERDTree
let g:nerdtree_tabs_open_on_console_startup=0       "automatically open nerdtree tab on startup
let g:nerdtree_tabs_open_on_gui_startup = 0
"NerdTree end

"Ctrlp start
let g:ctrlp_max_files = 0
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_use_caching = 1
let g:ctrlp_working_path_mode = 0

if executable('rg')
	"Use ag in Ctrlp for listing files
	set grepprg=rg\ --color=never
	let g:ctrlp_user_command = "rg -F %s --files --color=never"
elseif executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
	let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
endif
"Ctrlp end

"Syntastic start
let g:syntastic_python_checkers = ["pyflakes"]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
"Syntastic end

"gutenttags start
if IsMac()
	let g:gutentags_ctags_executable = '/usr/local/bin/ctags'
endif
"gutenttags end

"Per plugin configuration end


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

"game routine start
let g:game_project_root='J:\bh1\code\trunk'
"This file provide functionality of executing bat files background in Windows.
let g:background_bat_helper = 'F:\VimConfig\background_bat_helper.vbs'
function! GameChangeCWDToProjectRoot()
	execute 'normal! :cd '. g:game_project_root. "\<CR>"
	call nerdtree#ui_glue#chRootCwd()
endfunction

nnoremap <leader>go :call GameChangeCWDToProjectRoot()<CR>
func! s:SetUpDevRoutines()
	exec s:python_until_eof

DEFAULT_TELNET_PORT = 30000
import telnetlib
import subprocess
import os
import vim
telnetClients = {}

def get_client_count():
	import psutil
	count = 0
	projectRoot = vim.eval('g:game_project_root')
	for process in psutil.process_iter():
		try:
			if process.name() != 'client.exe':
				continue
			if process.exe().lower().find(projectRoot.lower()) >= 0:
				count += 1
		except:
			pass
	return count

def connect_to_client(callback=None):
	global telnetClients
	def do_connect():
		clientCount = get_client_count()
		for i in xrange(clientCount):
			port =DEFAULT_TELNET_PORT + i
			if port in telnetClients:
				continue
			try:
				tn = telnetlib.Telnet('localhost', port)
				tn.write('\r\n')
				print('Client Connected! %d' % port)
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
	projectRoot = vim.eval('g:game_project_root')
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
	projectRoot = vim.eval('g:game_project_root')
	for process in psutil.process_iter():
		try:
			if process.name() != 'client.exe':
				continue
			if process.exe().lower().find(projectRoot.lower()) >= 0:
				process.kill()
		except:
			pass


def launch_client(count=1):
	try:
		count = int(count)
	except:
		count = 1
	for i in xrange(count):
		project_root = vim.eval('g:game_project_root')
		subprocess.Popen('%s\client\engine\client.exe' % project_root,cwd='%s\client' % project_root)

def run_bat_in_cmder(script_name):
	CMDER_ROOT = os.environ.get('CMDER_ROOT', '')
	if not CMDER_ROOT:
		print('Failed to find Cmder.Please install it first.')
		return
	cmd_string = 'start %s\\vendor\\conemu-maximus5\\ConEmu.exe /icon "%s\\cmder.exe" /title Cmder /loadcfgfile "%s\\config\\ConEmu.xml" /cmd cmd /k "%s\\vendor\\init.bat && %s.bat"' % (CMDER_ROOT, CMDER_ROOT, CMDER_ROOT, CMDER_ROOT, script_name)
	os.system(cmd_string)

def run_server_bin_script(script_name, silent=False):
	project_root = vim.eval('g:game_project_root')
	cur_cwd = os.getcwd()
	os.chdir('%s/server/bin' % project_root)
	if os.environ.get('CMDER_ROOT', '') and not silent:
		run_bat_in_cmder(script_name)
	else:
		if silent:
			background_bat_helper = vim.eval('g:background_bat_helper')
			if background_bat_helper:
				os.system('start /b wscript.exe %s %s.bat %%*' % (background_bat_helper, script_name))
			else:
				subprocess.Popen('%s.bat' % script_name)
		else:
			subprocess.Popen('%s.bat' % script_name)
	os.chdir(cur_cwd)

def launch_server():
	run_server_bin_script('start')

def reload_server():
	run_server_bin_script('reload', True)

def kill_server():
	import psutil
	import subprocess
	projectRoot = vim.eval('g:game_project_root')
	for process in psutil.process_iter():
		try:
			if process.name().lower().find('python.exe') < 0:
				continue
			for cmd in process.cmdline():
				if cmd.find('%s\server\\bin' % projectRoot) >= 0:
					process.kill()
					break
		except:
			pass
	si = subprocess.STARTUPINFO()
	si.dwFlags |= subprocess.STARTF_USESHOWWINDOW
	#si.wShowWindow = subprocess.SW_HIDE # default
	subprocess.call('taskkill /F /FI "WINDOWTITLE eq BH1Server*" /T', startupinfo=si)

def execute_tortoisesvn_command(cmd, args):
	import subprocess
	try:
		subprocess.Popen('TortoiseProc /command:%s %s' % (cmd, args))
	except:
		return False
	return True

def update_game_trunk():
	#first try use tortoisesvn to update client then use original svn command
	projectRoot = vim.eval('g:game_project_root')
	ret = execute_tortoisesvn_command('update', '/path %s' % projectRoot)
	if not ret:
		vim.command('silent! !svn up %s' % projectRoot)

def update_game_outsource():
	#first try use tortoisesvn to update client then use original svn command
	projectRoot = vim.eval('g:game_project_root')
	ret = execute_tortoisesvn_command('update', '/path %s' % projectRoot + '\..\outsource')
	if not ret:
		vim.command('silent! !svn up %s' % projectRoot)

def update_game_design():
	#first try use tortoisesvn to update client then use original svn command
	projectRoot = vim.eval('g:game_project_root')
	ret = execute_tortoisesvn_command('update', '/path %s' % projectRoot + '\..\design')
	if not ret:
		vim.command('silent! !svn up %s' % projectRoot)

def commit_game_trunk():
	projectRoot = vim.eval('g:game_project_root')
	ret = execute_tortoisesvn_command('commit', '/path %s' % projectRoot)
	if not ret:
		print('Failed to show tortoise svn commit dialogue!')

def show_current_file_svn_log():
	filename = vim.eval("expand('%:p')")
	ret = execute_tortoisesvn_command('log', '/path %s' % filename)
	if not ret:
		vim.command('!svn log %s -l 20' % filename)

def blame_current_file_at_cursor():
	filename = vim.eval("expand('%:p')")
	currentLine = int(vim.eval('line(".")'))
	ret = execute_tortoisesvn_command('blame', '/path %s /line:%d' % (filename, currentLine))
	if not ret:
		print('Failed to show tortoisesvn blame dialogue!')

def show_current_file_diff():
	filename = vim.eval("expand('%:p')")
	ret = execute_tortoisesvn_command('diff', '/path %s' % filename)
	if not ret:
		print('Failed to show diff with tortoise svn')
	
EOF
endf

call s:SetUpDevRoutines()

let g:game_auto_reload_current_file = 1
function! GameReloadCurrentFile()
	if g:game_auto_reload_current_file
		execute ':python reload_current_file()'
	endif
endfunction

au! BufWrite *.py call GameReloadCurrentFile()
command! -nargs=? ClientGM python execute_client_gm(<f-args>)
command! ClientGMReload python execute_client_gm('reload')
command! BattleGMReload python execute_client_gm('reload battle')
command! ReInitClientTelnet python reinit_client_telnet()
command! ReloadCurrentFile python reload_current_file()
command! ReloadServer python reload_server()
command! StartServer execute('!start /B cd '. g:game_project_root . '\server\ServerLauncher && start.bat')
command! StartBattle execute('!start /B cd '. g:game_project_root . '\server\ServerLauncher && battle.bat')
command! -nargs=? StartClient python launch_client(<f-args>)
command! AllServer python launch_server()
command! KillServers python kill_server()
command! RestartBattle execute('!start /B cd ' . g:game_project_root . '\server\ServerLauncher && killbattle.bat && battle.bat')
command! StopClient python stop_client()
command! -nargs=* RunServerScript execute('!start /B cd '. g:game_project_root . '\server\ServerLauncher && '.<q-args>)
command! UpTrunk python update_game_trunk()
command! CommitTrunk python commit_game_trunk()
command! Log python show_current_file_svn_log()
command! Blame python blame_current_file_at_cursor()
command! Diff python show_current_file_diff()
command! UpDesign python update_game_design()
command! UpOutsource python update_game_outsource()
command! LocalExportTable execute('silent! !cd ' . g:game_project_root.  '\client\tools\export_table_tool && get_diff_and_export')
command! ModelEditor execute('silent! !start /B ' . g:game_project_root. '\..\..\art\tool_full_x64\modeleditor.exe')
command! FxEditor execute('silent! !start /B ' . g:game_project_root.  '\..\..\art\tool_full_x64\FxEdit.exe')
command! SceneEditor execute('silent! !start /B ' . g:game_project_root.  '\..\..\art\tool_full_x64\sceneeditor.exe')
command! Ipython execute('silent! !start ipython')
ca gm ClientGM
ca conclient ReInitClientTelnet
ca rs ReloadServer
ca reloadb BattleGMReload
ca rc ClientGMReload
"ca battle StartBattle
ca cl StartClient
ca sv AllServer
ca ks KillServers
ca restartbattle RestartBattle
ca kc StopClient
"search map
nnoremap <expr> <leader>fc ':CtrlSF -filetype py -W  ' . g:game_project_root. '\client\script<C-Left><Left>'
nnoremap <expr> <leader>fs ':CtrlSF -filetype py -W  ' . g:game_project_root. '\server<C-Left><Left>'
nnoremap <expr> <leader>vp ':silent! !start /B pyprof2calltree -k -i ' . g:game_project_root .  '/profresult.prof' . "\<CR>"

"G4 routine end
