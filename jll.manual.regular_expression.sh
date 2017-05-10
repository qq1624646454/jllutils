#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.regular_expression.sh 
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2016-12-29 17:25:35
#   ModifiedTime: 2017-01-03 13:54:58

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1 <<EOF

正则表达式:

限定连续重复字符的范围

.
  代表一个除新行符之外的任意字符，必须存在一个字符

*
  代表零个或多个的前一个字符.

  例如 oo*,  代表至少一个o, 即表示第一个o一定存在，第二个o可以有一个或多个，也可以没有，

  比如 a* 可以匹配ab,aaab, aC, 或不以a开始的任意字符串,如 bba, bb.
  基本上，a*对于所有存在的字符或字符串都可以匹配 

  搜索g开头和结尾，中间是至少一个o的字符串，即gog, goog....gooog...等
  grep -n 'goo*g' regular_express.txt

  搜索g开头和结尾的字符串在的行
  grep -n 'g.*g' regular_express.txt     // .*表示 0个或多个任意字符 


.*
  匹配范围最广的模式之一，可以匹配零个或多个任意字符(除新行符之外).
  比如  abc.*123可以匹配 abcAnything123，也能匹配abc123

?
  匹配零个或一个的前一个字符.　它与*的不同之处是，它最多匹配的字符个数只有一个，而*是多个.

+
  匹配一个或多个的前一个字符. 

[]
  匹配中括号内罗列的任一字符
  比如:
      匹配中文:[\u4e00-\u9fa5]
      英文字母:[a-zA-Z]
      数字:[0-9]
      匹配中文，英文字母和数字及_: ^[\u4e00-\u9fa5_a-zA-Z0-9]+$

{min,max}
  匹配出现次数介于min和max的前一个字符.
  比如
  {3} 表示准确匹配3次
  {3,}　表示匹配3次或更多
  指定的数字必须小于 65536, 且第一个必须小于等于第二个


匹配函数原型:  ASN1_xxx(xxx)
  grep -Enr "[ )=]ASN1_[a-zA-Z0-9_]{1,}[(].*[)]" \\
      /mnt/localdata/localhome/jielong.lin/workspace/aosp_6.0.1_r10_selinux/device/tpvision/common/plf/mediaplayer/av/comps/httputilservice/src/HttpUtilWrapper.cpp --color=always




EOF

