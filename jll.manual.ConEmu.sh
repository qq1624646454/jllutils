#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.ConEmu.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-02-10 10:09:30
#   ModifiedTime: 2017-02-10 10:10:24

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \\033[0m\\033[31m\\033[43mworld\\033[0m"

less >&1 <<EOF

在Windows7平台下， 如果安装后缺少more命令，请拷贝more.exe到/c/Program File/Git/usr/bin目录下


ConEmu 简介
ConEmu 即 Console Emulate, 一款终端模拟器, 完全免费, 可以通过他加载多种终端如 cmd, shell, bash, putty 而且便于管理!
简而言之, 凡是喜欢用命令行方式的, windows就请使用这款软件, 分分钟变身geek或者hacker的感觉…
右键文件夹打开ConEmu就自动进入此文件夹, ConEmu Inside 甚至能嵌入到文件夹中.
顺便说一句, cmder就是他的马甲, 核心还是ConEmu.
我的ConEmu
我希望的ConEmu, 就是想输命令行, 打开ConEmu就行!
本文的配置可以在ConEmu中执行:
cmd shell windows自带终端
git windows下安装好git即可, 包含了git-bash
mingw windows下用gnu工具链编译c, c++
putty ssh链接远程linux, 串口链接嵌入式linux
cygwin windows下模拟linux运行环境 (目前尚未使用, 在用传统的虚拟机)
其它指令如: hexo 博客使用, choco 安装软件使用, apm atom下载插件使用.
快速在指定文件夹下打开ConEmu, 可在 Listary 关联快捷键 ctrl-~
快速在Notepad++下打开ConEmu, 关联快捷键 ctrl-~
自制ConEmu绿色版
下载 ConEmu便携版
解压后放在理想的文件夹中. 下面以 D:\\Green\\ConEmu 路径为例.
下载 clink便携版, 用于增强终端操作, 如复制拷贝快捷键等
解压后, 所有文件放入 D:\\Green\\ConEmu\\ConEmu\\clink, 这里面原来就有个 Readme.txt, 说的非常清楚了
下载 git便携版, 版本管理软件
解压后命名为 Git 放到 D:\\Green\\ConEmu\\plugins,
下载并使用默认设置安装 mingw, 用于在win下使用gnu工具编译
只是装了 MinGW Installation Manager (实际上是个绿色软件). 打开后继续安装组件
Basic Setup->mingw32-base和mingw32-gcc-g++->左上Installation->Apply changes->等待安装完成.
我只需要编译c和c++文件, msys也已经由git软件实现了, 因此无需安装其它组件了.
然后把整个 MinGW 文件夹放到 D:\\Green\\ConEmu\\plugins
复制一份 mingw32-make.exe 并重命名为 make.exe, 这样就能直接用 make 指令了
下载 putty.zip, ssh远程连接软件及串口软件
解压后命名为 putty 放到 D:\\Green\\ConEmu\\plugins
然后需要将上述软件加入环境变量, 这个可以在ConEmu设置中完成!!!

打开ConEmu, Setting->Startup->Environment->set PATH=%ConEmuBaseDir%\\Scripts;%PATH% 下面加上如下语句

1
2
3
4
5
6
7
# git PATH
set PATH=%ConEmuDir%\\plugins\\Git;%PATH%
set PATH=%ConEmuDir%\\plugins\\Git\\cmd;%PATH%
# mingw PATH
set PATH=%ConEmuDir%\\plugins\\MinGW\\bin;%PATH%
# putty PATH%
set PATH=%ConEmuDir%\\plugins\\putty;%PATH%
这样, ConEmu在启动时, 会自动加入上述软件到PATH中

如果使用 更通用的做法, 把上述环境变量删除或注释掉.
自制ConEmu绿色版就初步完成, 下面只需要配置了.
更通用的做法
用上述方法有三个缺点
git便携版不支持ssh或GPG免密远程同步, 每次都要求输入用户名和密码, 非常麻烦.
如果不用ConEmu, 那么其它终端, 如atom下的终端就无法使用上述软件.
发现putty会新打开一个窗口, 而不是嵌入到ConEmu中.
下载 git安装版, 使用默认配置安装即可.
为了便于使用, 建议把git的根目录也加入环境变量, 这样就能直接调用 git-cmd.exe
设置 D:\\Green\\ConEmu\\plugins\\MinGW\\bin 文件夹到系统环境变量中
设置 D:\\Green\\ConEmu\\plugins\\putty 文件夹到系统环境变量中
还可以考虑下载安装 cygwin 并加入ConEmu中, 这是一款Windows下的Linux模拟器. 注意安装和卸载都比较麻烦.
ConEmu的设置
所有设置都会存放在 conEmu.xml 里, 所以设置的备份很简单
首次打开会有设置向导 fast configuration, 用于生成 conEmu.xml
可以在设置好环境变量, 安装好git后, 删除conEmu.xml重新运行, 这样ConEmu会自动检测加入Git bash 和 putty, 省心不少. clink放在指定路径后, 其功能也会自动启用.
配置过程如下, 需要图文版可参考 工具02：cmd的替代品ConEmu+Clink, 配置上略有区别, 进入 Settings 后
Main->Appearance->Generic->Single instance mode (...)
Main->Confirm->CLose confirmations->When running process was detected
Startup->Specified named task->Bash:: Git bash 更改打开时默认使用的终端类型
Startup->Environment 启动时, 会加载这里的环境变量. 配置好系统环境变量的话, 可以全部删除
注册鼠标右键 ConEmu Here 和 ConEmu Inside, 并设置为使用 Git bash 启动
Integration->ConEmu Here->Command:改为{Git Bash} -cur_console:n->Register
Integration->ConEmu Inside->Command:改为{Git Bash} -cur_console:n->Register
Integration->Default term->Force ConEmu as default terminal for console applications
添加 tasks. 选择 Startup->Tasks, 根据现有例子依样画葫芦即可.
Bash::Git bash: git-cmd.lnk --no-cd --command=usr/bin/bash.exe -l -i 也可以点击File path...使用绝对路径替代快捷方式.
Bash::Git bash(Admin): *git-cmd.exe --no-cd --command=usr/bin/bash.exe -l -i 最前面加个*就是管理员权限了.
Putty::default: putty.exe 同样, 可能需要使用绝对路径, 点击File path...选择即可
Putty::Ubuntu: putty.exe -new_console -load "ubuntu" 需要putty设置好名为ubuntu的session
Cygwin: set HOME=d:\\cygwin\\home\\XXX & "d:\\cygwin\\bin\\mintty.exe" -i /Cygwin.ico - 这条指令没有测试过.

EOF

