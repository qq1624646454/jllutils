#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.more_with_color.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-05-11 10:19:56
#   ModifiedTime: 2017-05-11 10:47:49

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<GEOF

more \>\&1\<\<EOF

[ESC] should be expressed to ^[ by [Ctrl]+[v]+[ESC] rather than \033

Example For: [0m[31m[43m world [0m
  ERROR:  \033[0m\033[31m\033[43m world \033[0m
  GOOD:   ^[[0m^[[31m^[[43m world ^[[0m


Color Format:  [AC][FC][BC]text[AC]
  AC: Ansi Control Code Close
  FC:   Foreground Color
  BG:   Background Color

Suggestion as follows:
  ESC=^[
  AC=$ESC[0m
  Fblack=$ESC[30m
  Fred=$ESC[31m
  Fgreen=$ESC[32m
  Fyellow=$ESC[33m
  Fblue=$ESC[34m
  Fpink=$ESC[35m
  Fseablue=$ESC[36m
  Fwhite=$ESC[37m
  Bblack=$ESC[40m
  Bred=$ESC[41m
  Bgreen=$ESC[42m
  Byellow=$ESC[43m
  Bblue=$ESC[44m
  Bpink=$ESC[45m
  Bseablue=$ESC[46m
  Bwhite=$ESC[47m

The above definitions are defined in BashShellLibrary




  #-----------------------------------------------------
  # ANSI Control Code (note: \033 <=> [Ctrl]+[v]+[ESC])
  #-----------------------------------------------------
  #   \033[0m 关闭所有属性
  #   \033[01m 设置高亮度
  #   \033[04m 下划线
  #   \033[05m 闪烁
  #   \033[07m 反显
  #   \033[08m 消隐
  #   \033[30m -- \033[37m 设置前景色
  #   \033[40m -- \033[47m 设置背景色
  #   \033[nA 光标上移n行
  #   \033[nB 光标下移n行
  #   \033[nC 光标右移n行
  #   \033[nD 光标左移n行
  #   \033[y;xH 设置光标位置
  #   \033[2J 清屏
  #   \033[K  清除从光标到行尾的内容
  #   \033[s  保存光标位置
  #   \033[u  恢复光标位置
  #   \033[?25l 隐蔽光标
  #   \033[?25h 显示光标
  #-----------------------------------




EOF

GEOF


