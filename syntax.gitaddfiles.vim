" Vim syntax file
" Language:	git add-files
" Maintainer:	Kipras Melnikovas <kipras@kipras.org>
" Filenames:	ADD_FILES
" Last Change:	2024 Feb 27
" Originally:	https://github.com/vim/vim/blob/db7622ea827034124c22da0c235ff5170e44b8bc/runtime/syntax/gitrebase.vim

if exists("b:current_syntax")
  finish
endif

syn case match

let s:c = escape((matchstr(getline('$'), '^[#;@!$%^&|:]\S\@!') . '#')[0], '^$.*[]~\"/')

syn match   gitaddfilesAdd        "\v^a%(dd)=>"        nextgroup=gitaddfilesFile skipwhite
syn match   gitaddfilesWip        "\v^w%(ip)=>"        nextgroup=gitaddfilesFile skipwhite
syn match   gitaddfilesEdit       "\v^e%(dit)=>"       nextgroup=gitaddfilesFile skipwhite
syn match   gitaddfilesStaged     "\v^s%(taged)=>"     nextgroup=gitaddfilesFile skipwhite
syn match   gitaddfilesHalfstaged "\v^h%(alfstaged)=>" nextgroup=gitaddfilesFile skipwhite
syn match   gitaddfilesNoop       "\v^noop>"           nextgroup=gitaddfilesFile skipwhite
syn match   gitaddfilesFile       ".*"                                           contained
syn match   gitaddfilesCommand    ".*"                                           contained
exe 'syn match gitaddfilesComment " \@<=' . s:c . ' empty$"  contained'
exe 'syn match gitaddfilesComment "^\s*' . s:c . '.*" '

unlet s:c

hi def link gitaddfilesAdd            String
hi def link gitaddfilesWip            Type
hi def link gitaddfilesEdit           PreProc
hi def link gitaddfilesStaged         Conditional
hi def link gitaddfilesHalfstaged     Comment
hi def link gitaddfilesNoop           Comment

let b:current_syntax = "gitaddfiles"
