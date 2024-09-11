set langmenu=en_US.UTF-8
let $LANG = 'en_US'

filetype off
filetype plugin indent on

call plug#begin()

"syntastic check
Plug 'scrooloose/syntastic'
"theme
"Plugin 'jnurmine/Zenburn'
"theme
Plug 'altercation/vim-colors-solarized'
"Plugin 'JazzCore/ctrlp-cmatcher'
"directory management
Plug 'scrooloose/nerdtree'
"nerdtree tabs
Plug 'jistr/vim-nerdtree-tabs'
"file navigation
"Plugin 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

"Plugin 'rking/ag.vim'
"Plugin 'mhinz/vim-grepper'


Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
"Plugin 'FelikZ/ctrlp-py-matcher'
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
Plug 'tikhomirov/vim-glsl'
"Plugin 'fugalh/desert.vim'
"Plugin 'tomasr/molokai'
"Plugin 'juneedahamed/svnj.vim'
"Plugin 'powerline/powerline'
Plug 'itchyny/lightline.vim'
"Plugin 'juneedahamed/vc.vim'
"Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
"code completion
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plugin 'skywind3000/asyncrun.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'dyng/ctrlsf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-python/python-syntax'
Plug 'Shougo/echodoc.vim'
Plug 'dracula/vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

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
nnoremap <F5> :!py3 %<CR>
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
"let g:ctrlp_max_files = 0
"let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
"let g:ctrlp_use_caching = 1
"let g:ctrlp_working_path_mode = 0

"if executable('rg')
	"Use ag in Ctrlp for listing files
	"set grepprg=rg\ --color=never
	"let g:ctrlp_user_command = "rg -F %s --files --color=never"
"elseif executable('ag')
	"set grepprg=ag\ --nogroup\ --nocolor
	"let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
"endif
"Ctrlp end

"fzf start
nnoremap <C-p> :Files<CR>
"fzf end

"Syntastic start
let g:syntastic_python_checkers = ["pyflakes"]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
"Syntastic end

"coc begin
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"coc end

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
let g:game_project_root='E:\bh1\code\trunk'
"This file provide functionality of executing bat files background in Windows.
let g:background_bat_helper = 'E:\VimConfig\background_bat_helper.vbs'
function! GameChangeCWDToProjectRoot()
	execute 'normal! :cd '. g:game_project_root. "\<CR>"
	call nerdtree#ui_glue#chRootCwd()
endfunction

nnoremap <leader>go :call GameChangeCWDToProjectRoot()<CR>

"endf

"call s:SetUpDevRoutines()

let g:game_auto_reload_current_file = 1
function! GameReloadCurrentFile()
	if g:game_auto_reload_current_file
		execute ':py3 reload_current_file()'
	endif
endfunction

"au! BufWrite *.py call GameReloadCurrentFile()
command! -nargs=? ClientGM py3 execute_client_gm(<f-args>)
command! ClientGMReload py3 execute_client_gm('reload')
command! BattleGMReload py3 execute_client_gm('reload battle')
command! ReInitClientTelnet py3 reinit_client_telnet()
command! ReloadCurrentFile py3 reload_current_file()
command! ReloadServer py3 reload_server()
command! StartServer execute('!start /B cd '. g:game_project_root . '\server\ServerLauncher && start.bat')
command! StartBattle execute('!start /B cd '. g:game_project_root . '\server\ServerLauncher && battle.bat')
command! -nargs=? StartClient py3 launch_client(<f-args>)
command! AllServer py3 launch_server()
command! KillServers py3 kill_server()
command! RestartBattle execute('!start /B cd ' . g:game_project_root . '\server\ServerLauncher && killbattle.bat && battle.bat')
command! StopClient py3 stop_client()
command! -nargs=* RunServerScript execute('!start /B cd '. g:game_project_root . '\server\ServerLauncher && '.<q-args>)
command! UpTrunk py3 update_game_trunk()
command! CommitTrunk py3 commit_game_trunk()
command! Log py3 show_current_file_svn_log()
command! Blame py3 blame_current_file_at_cursor()
command! Diff py3 show_current_file_diff()
command! UpDesign py3 update_game_design()
command! UpOutsource py3 update_game_outsource()
command! LocalExportTable execute('silent! !cd ' . g:game_project_root.  '\client\tools\export_table_tool && get_diff_and_export')
command! ModelEditor execute('silent! !start /B ' . g:game_project_root. '\..\..\art\tool_full_x64\modeleditor.exe')
command! FxEditor execute('silent! !start /B ' . g:game_project_root.  '\..\..\art\tool_full_x64\FxEdit.exe')
command! SceneEditor execute('silent! !start /B ' . g:game_project_root.  '\..\..\art\tool_full_x64\sceneeditor.exe')
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
