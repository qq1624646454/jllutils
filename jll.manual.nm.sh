#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.nm.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-06-13 17:28:25
#   ModifiedTime: 2017-06-13 17:34:10

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

nm命令还是比较简单而且强大的。它用来列出一个目标文件中的各种符号。
符号的种类很多，以下是一些常见的符号类型
${AC}
${Fyellow}R:${AC}
${Fseablue}Read only symbol. ${AC}
${Fgreen}  比如在代码中有一个const MAXDATA = 3095; 则MAXDATA就是一个Read only symbol${AC}

${Fyellow}N:${AC}
${Fseablue}这是一个调试符号${AC}

${Fyellow}D:${AC}
${Fseablue}这是一个已经初始化的变量的符号。${AC}
${Fgreen}比如代码中int i = 1和char *str = "Hello"则i和str都是这种类型的符号${AC}

${Fyellow}T:${AC}
${Fseablue}Text段的符号。${AC}
${Fgreen}子程序都是这种符号，比如文件中实现了一个函数function，则function就是这种符号${AC}

${Fyellow}U:${AC}
${Fseablue}未定义的符号。如果文件中引用了不存在的函数，则这些未定义的函数符号就是这种类型${AC}

${Fyellow}S:${AC}
${Fseablue}未初始化的符号${AC}
${Fgreen}比如全局变量int s;则s的符号就是此类型${AC}
============================================================
nm的用法很简单，以下几个关键字比较常用：
 
1、"-A"，列出符号名的时候同时显示来自于哪个文件。
这在同时列出多个文件（比如一个链接库）的符号时比较有用
 
2、"-a"，列出所有符号
这将会把调试符号也列出来。默认状态下调试符号不会被列出。
 
3、"-l"，列出符号在源代码中对应的行号
指定这个参数后，nm将利用调试信息找出文件名以及符号的行号。
对于一个已定义符号，将会找出这个符号定义的行号，对于未定义符号,显示为空
 
4、"-n"，根据符号的地址来排序
默认是按符号名称的字母顺序排序的
 
5、"-u"，只列出未定义符号
同"--undefined-only"， 而"--defined-only"将只列出已定义符号

EOF

