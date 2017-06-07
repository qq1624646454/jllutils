#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"


more >&1 <<EOF

install manual
---------------------------------------
jl@S:~\$ ${Fyellow} mkdir -pv github${AC}
jl@S:~/github\$ ${Fyellow}git clone https://github.com/qq1624646454/vicc_installer.git${AC}
...
jl@S:~/github\$ ${Fyellow}cd vicc_installer${AC}
jl@S:~/github/vicc_installer\$ ${Fyellow}./vicc_installer.sh${AC}
...




when I open a cpp file with vim7.4, the vim plugins are loaded flow as follows:

if 'filetype plugin on' is in vimrc or .vimrc,
vim will get the file type plugin (ftplugin) from '\$VIMRUNTIME/ftplugin/'.
So \$VIMRUNTIME/ftplugin/cpp.vim will be loaded to vim.

As the cpp.vim, cpp is treated as c.
runtime! ftplugin/c.vim ftplugin/c_*.vim ftplugin/c/*.vim


-----------------------------------
  Look up what is omnifunc in vim
-----------------------------------
:set omnifunc?


-----------------------------------
  Look up what is filetype 
-----------------------------------
:set filetype? 




-----------------------------------
  Modify PopupMenu Style
-----------------------------------
:highlight Pmenu ctermbg=brown ctermfg=red gui=bold
highlight PmenuSel ctermbg=green ctermfg=white gui=bold


-----------------------------------
To see how different color schemes 
look, try (see view all colors)
-----------------------------------
:runtime syntax/colortest.vim







-----------------------------------
  vimrc
-----------------------------------
if v:version >= 600
  filetype plugin on
  filetype indent on
else
  filetype on
endif

if v:version >= 700
  " override built-in C omnicomplete with C++ OmniCppComplete plugin
  set omnifunc=syntaxcomplete#Complete
  let OmniCpp_GlobalScopeSearch   = 1
  let OmniCpp_DisplayMode         = 1
  let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
  let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
  let OmniCpp_ShowAccess          = 1 "show access in pop-up
  let OmniCpp_SelectFirstItem     = 1 "select first item in pop-up
  set completeopt=menuone,menu,longest
endif

if v:version >= 700
  let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
  highlight   clear
  highlight   Pmenu         ctermfg=0 ctermbg=2
  highlight   PmenuSel      ctermfg=0 ctermbg=7
  highlight   PmenuSbar     ctermfg=7 ctermbg=0
  highlight   PmenuThumb    ctermfg=0 ctermbg=7
endif




================================================================================
    vim 查看非文本文件

xxd:
xxd creates a hex dump of a given file or standard input. 
It can also convert a hex dump back to its original binary form

od: 
Write an unambiguous representation, octal bytes by default, of FILE to standard output. 
With more than one FILE argument, concatenate them in the listed order to form the input.
 
================================================================================
jll@linux:.$  vim -b  Xxx.bin
............8888888888888888888888888888.......................
...................................
:%!xxd       ————将当前文件转换为16进制格式
:%!od        ————将当前文本转换为16进制格式。
:%!xxd -c 16 ————将当前文本转换为16进制格式,并每行显示16个字节。
:%!xxd -r    ————将当前文件转换回文本格式。


>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 十六进制编辑工具 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
xxd -i BinFile  —————将BinFile以C语言数组的形式进行表示
xxd -l len      —————只显示<len>这么多字节
xxd -p          —————以连续的16进制表示显示.
xxd -u          —————以大写16进制字母表示.
xxd -s +ADDR    —————从第ADDR个字节的位置开始显示内容.
xxd -s -ADDR    —————从跟离末尾ADDR个字节为开始显示内容.
xxd -g n        —————以n字节为一块，默认为2字节









xxd的作用就是将一个文件以十六进制的形式显示出来，具体选项如下。
    -a : 它的作用是自动跳过空白内容，默认是关闭的
    -c : 它的后面加上数字表示每行显示多少字节的十六进制数，默认是16字节。
    -g : 设定以几个字节为一块，默认为2字节。
    -l : 显示多少字节的内容。
    -s : 后面接【+-】和address.加号表示从地址处开始的内容，减号表示距末尾address开始的内容。
 
    具体用法：
    xxd       -a       -c        12         -g  1     -l  512       -s +0x200      [inputfile]
    
   【自动跳过空白】【每行显示12字节】【一个字节一块】【显示512字节内容】【从0x200开始】【输入文件】

jielong.lin@TpvServer:~$ vim -b MPEG.mp4
      ...
:%!xxd -c 10 -g 1
      1 00000000: 00 00 00 18 66 74 79 70 69 73  ....ftypis
      2 0000000a: 6f 6d 00 00 00 01 69 73 6f 6d  om....isom
      3 00000014: 61 76 63 31 00 00 00 08 79 71  avc1....yq
      4 0000001e: 6f 6f 00 00 fd 3c 6d 6f 6f 76  oo...<moov
      5 00000028: 00 00 00 6c 6d 76 68 64 00 00  ...lmvhd..
 
================================================================================








================================================================================
    vim 折叠代码
-------------------- 

In Visual Mode, Please first select a range, and type [z][f] to create a folder
When type [z][d] to delete this folder on the same position.
After create a folder, you can use [space] to open or close a folder.





:<startLine>,<endLine>fo

For example:
    :5,100fo
    表示将第５行开始到100行之间创建折叠
　　按空格键可以展开/收起.





EOF



