#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.vimdiff.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2016-12-26 08:50:49
#   ModifiedTime: 2018-10-10 19:46:40

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1 <<EOF

${Fyellow}1. 使用vim的比较模式打开两个文件：${AC}
vim -d file1 file2
或
vimdiff file1 file2
${Fyellow}2. 如果已经打开了文件file1，再打开另一个文件file2进行比较：${AC}
:vert diffsplit file2
如果没有用vert命令，diffsplit则会分上下两个窗口。
${Fyellow}3. 如果已经用split方式打开了两个文件file1，file2，又想比较两文件的不同。${AC}
分别在两个窗口里面输入命令：
:diffthis
${Fyellow}4. 如果更改了某个窗口的内容，vim又没有自动更新diff检查，可以使用如下命令更新：${AC}
:diffupdate
${Fyellow}5. 定位到不同点：${AC}
[c     跳到前一个不同点
]c     跳到后一个不同点
${Fyellow}6. 在窗口间跳转：${AC}
ctrl-w w    跳到下一个窗口
ctrl-w h    跳到左侧窗口
ctrl-w l    跳到右侧窗口
ctrl-w j    跳到下方的窗口
ctrl-w k    跳到上方的窗口
${Fyellow}7. 合并文档：${AC}
dp          将差异点的当前文档内容应用到另一文档（diff put）
do          将差异点的另一文档的内容拷贝到当前文档（diff get）
${Fyellow}8. 上下文的展开和查看${AC}
比较和合并文件的时候经常需要结合上下文来确定最终要采取的操作。Vimdiff 缺省是会把不同之处上下各 6 行的文本都显示出来以供参考。其他的相同的文本行被自动折叠。如果希望修改缺省的上下文行数为3行，可以这样设置：
:set diffopt=context:3
可以用简单的折叠命令来临时展开被折叠的相同的文本行： 
zo          (folding open, z这个字母看上去比较像折叠的纸）

然后可以用下列命令来重新折叠： 
zc          (folding close)



${Fyellow}=====================================${AC}
${Fyellow} 如何比较两个二进制/十六进制文件${AC}
${Fyellow}-------------------------------------${AC}
cd /workspace2/jllproject/L170/Mangov2/branches/L170HQA2_YuTong.1
cd apps_proc/poky/build/tmp-glibc.orig/work
vim -bd \\
 tmp-glibc.1/work/armv7a-vfp-neon-oe-linux-gnueabi/perl/5.22.0-r0/image/usr/lib/libperl.so.5.22.0 \\
 tmp-glibc/work/armv7a-vfp-neon-oe-linux-gnueabi/perl/5.22.0-r0/image/usr/lib/libperl.so.5.22.0

#在左侧窗口通过如下命令切换为十六进制格式
:%!xxd -g 1
#通过Ctrl+W+W跳转到右侧窗口并通过如下命令切换为十六进制格式
:%!xxd -g 1
#通过如下命令重新激活对比功能，就会使用不同颜色显示差异的内容
:diffupdate


-------------------------------------------------------------
${Fseablue}http://blog.csdn.net/littlewhite1989/article/details/45312081${AC}

EOF

