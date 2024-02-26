" Vim filetype plugin
" Language:	git add-files
" Maintainer:	Kipras Melnikovas <kipras@kipras.org>
" Last Change:	2024 Feb 27
" Originally:	https://github.com/vim/vim/blob/db7622ea827034124c22da0c235ff5170e44b8bc/runtime/ftplugin/gitrebase.vim

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
  finish
endif

let b:did_ftplugin = 1

let &l:comments = ':' . (matchstr(getline('$'), '^[#;@!$%^&|:]\S\@!') . '#')[0]
let &l:commentstring = &l:comments[1] . ' %s'
setlocal formatoptions-=t
setlocal nomodeline
let b:undo_ftplugin = "setl com< cms< fo< ml<"

function! s:choose(word) abort
  s/^\(\w\+\>\)\=\(\s*\)\ze\x\{4,40\}\>/\=(strlen(submatch(1)) == 1 ? a:word[0] : a:word) . substitute(submatch(2),'^$',' ','')/e
endfunction

function! s:cycle(count) abort
  let words = ['add', 'edit']
  let index = index(map(copy(words), 'v:val[0]'), getline('.')[0])
  let index = ((index < 0 ? 0 : index) + 10000 * len(words) + a:count) % len(words)
  call s:choose(words[index])
endfunction

command! -buffer -bar -range Add        :<line1>,<line2>call s:choose('add')
command! -buffer -bar -range Edit       :<line1>,<line2>call s:choose('edit')
command! -buffer -count=1 -bar -bang Cycle call s:cycle(<bang>0 ? -<count> : <count>)

if exists("g:no_plugin_maps") || exists("g:no_gitaddfiles_maps")
  finish
endif

nnoremap <buffer> <silent> <C-A> :<C-U><C-R>=v:count1<CR>Cycle<CR>
nnoremap <buffer> <silent> <C-X> :<C-U><C-R>=v:count1<CR>Cycle!<CR>

let b:undo_ftplugin = b:undo_ftplugin . "|exe 'nunmap <buffer> <C-A>'|exe 'nunmap <buffer> <C-X>'"

