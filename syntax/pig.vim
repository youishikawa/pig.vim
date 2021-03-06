if exists("b:current_syntax")
  finish
endif

syn case ignore

" Pig keywords:

syn keyword pigKeyword load store filter foreach order arrange distinct
syn keyword pigKeyword cogroup join cross union onschema split into if all any as
syn keyword pigKeyword by using inner outer parallel group
syn keyword pigKeyword continuously window tuples generate eval
syn keyword pigKeyword define input output ship cache stream through
syn keyword pigKeyword seconds minutes hours asc desc null left right full
syn keyword pigKeyword rm rmf
syn keyword pigKeyword limit

syn keyword pigType chararray bytearray int long float double tuple bag map

syn keyword pigOperator and or not matches is flatten

syn match pigFunction "\<[a-zA-Z][a-zA-Z0-9_]*\s*(" contains=pigFunctionName

" http://pig.apache.org/docs/r0.10.0/func.html
" eval
syn keyword pigFunctionName avg concat count count_star diff isempty max min size sum tokenize
" load/store
syn keyword pigFunctionName BinStorage JsonLoader JsonStorage PigDump PigStorage TextLoader
" math
syn keyword pigFunctionName abs acos asin atan cbrt ceil cos cosh exp floor log log10 random round sin sinh sqrt tan tanh
" string
syn keyword pigFunctionName indexof last_index_of lcfirst lower regex_extract regex_extract_all replace strsplit substring trim ucfirst upper
" tuple/bag/map
syn keyword pigFunctionName totuple tobag tomap top

syn match pigAssignVar "^\s*[a-zA-Z][a-zA-Z0-9_]*\s*=[^=]" contains=pigAssignEq
syn match pigAssignEq  "=" contained

syn match pigSpecial "[#*]"

syn match pigGrunt "^\s*\(cat\|cd\|cp\|copyFromLocal\|copyToLocal\|define\|dump\|illustrate\|describe\|explain\|help\|kill\|ls\|mv\|mkdir\|pwd\|quit\|register\|rm\|set\)\>.*$" contains=pigGruntCmd,pigRegisterKeyword,pigComment
syn match pigGruntCmd "^\s*\(cat\|cd\|cp\|copyFromLocal\|copyToLocal\|define\|dump\|illustrate\|describe\|explain\|help\|kill\|ls\|mv\|mkdir\|pwd\|quit\|rm\|set\)\>" contained
syn match pigRegisterKeyword "^\s*register\>" contained

" Strings and characters:
syn region pigString		start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region pigString		start=+'+  skip=+\\\\\|\\'+  end=+'+
syn region pigString		start=+`+  skip=+\\\\\|\\`+  end=+`+

" Dollar variables:
syn match pigDollarVar "$\d\+"

" Numbers:
syn match  pigNumber "[-+]\=\(\<\d[[:digit:]_]*L\=\>\|0[xX]\x[[:xdigit:]_]*\>\)"
syn match  pigFloat  "[-+]\=\<\d[[:digit:]_]*[eE][\-+]\=\d\+"
syn match  pigFloat  "[-+]\=\<\d[[:digit:]_]*\.[[:digit:]_]*\([eE][\-+]\=\d\+\)\="
syn match  pigFloat  "[-+]\=\<\.[[:digit:]_]\+\([eE][\-+]\=\d\+\)\="

" Comments:
syn region pigComment start="/\*" end="\*/" contains=pigTodo
syn match pigComment "--.*$" contains=pigTodo
syn match pigComment "^\s*#.*$" contains=pigTodo

syn sync ccomment pigComment

" Todo.
syn keyword pigTodo TODO FIXME XXX DEBUG NOTE contained

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_c_syn_inits")
  if version < 508
    let did_c_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink pigComment   Comment
  HiLink pigOpWord    Label
  HiLink pigOperator  Operator
  HiLink pigType      Type
  HiLink pigSpecial   Special
  HiLink pigKeyword   Statement
  HiLink pigNumber    Number
  HiLink pigFloat     Float
  HiLink pigDollarVar Identifier
  HiLink pigAssignVar Identifier
  HiLink pigString    String
  HiLink pigTodo      Todo

  HiLink pigFunctionName Function

  HiLink pigGrunt String
  HiLink pigGruntCmd Statement
  HiLink pigRegisterKeyword Include

  delcommand HiLink
endif

let b:current_syntax = "pig"

