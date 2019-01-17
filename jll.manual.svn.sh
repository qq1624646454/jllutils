#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.svn.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2016-12-15 13:19:59
#   ModifiedTime: 2019-01-17 09:17:03

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1 <<EOF

aptitude install subversion


#列出项目所有路径下所有修改过的文件
#通常[开始条件]是2, [代码所有svn路径]缺省时为当前路径
#svn diff -r 2:HEAD --summarize
${Fseablue}svn diff -r [开始条件]:HEAD --summarize [代码所在svn路径]${AC} 


${Fseablue}svn st | grep '^M' | awk '{print \$2}' | xargs svn diff${AC}

${Fseablue}svn st | grep '^?' | awk '{print \$2}' | xargs rm -rvf 2>/dev/null${AC}
${Fseablue}svn st | grep '^M' | awk '{print \$2}' | xargs svn revert -R 2>/dev/null${AC}
${Fseablue}svn st | grep '^~' | awk '{print \$2}' | xargs svn revert -R 2>/dev/null${AC}
# git clean -df

${Fseablue}svn log -l 20${AC}
${Fseablue}svn log -r 485 -v  #查看第485条记录提交的文件信息${AC}
# git log -n 20



${Fseablue}svn diff -r r174:r173${AC}
# git diff CABC01:CABC00

${Fseablue}svn info .${AC}
# repo info .

${Fseablue}svn list https://192.168.0.10:8443/svn/Mangov2${AC}
# git branch -r



${Fseablue}svn import L170LQ_trunk https://192.168.0.10:8443/svn/Mango/branches/L170LQ_trunk${AC}
# Import the new project named L170LQ_trunk into  https://192.168.0.10:8443/svn/Mango/branches/L170LQ_trunk


${Fseablue}svn add YOUR_FILE${AC}
${Fseablue}svn commit -m "提交内容：1.xxx 影响范围： 影响项目："${AC}
##### svn commit = svn ci
# git add YOUR_FILE
# git commit -m "提交内容：1.xxx 影响范围： 影响项目："
# git push -u origin master

${Fseablue}svn checkout https://192.168.0.10:8443/svn/Mangov2/branches/DM2_DOCUMENT${AC} 
##### svn checkout = svn co
# git clone https://192.168.0.10:8443/svn/Mangov2/branches/DM2_DOCUMENT 




1、检出
svn  co  http://路径(目录或文件的全路径)　[本地目录全路径] --username 用户名 --password 密码
svn  co  svn://路径(目录或文件的全路径)　[本地目录全路径]  --username 用户名 --password 密码
svn  checkout  http://路径(目录或文件的全路径)　[本地目录全路径] --username　用户名
svn  checkout  svn://路径(目录或文件的全路径)　[本地目录全路径]  --username　用户名
注：如果不带--password 参数传输密码的话，会提示输入密码，建议不要用明文的--password 选项。
　　其中 username 与 password前是两个短线，不是一个。
　　不指定本地目录全路径，则检出到当前目录下。
例子：
svn co svn://localhost/测试工具 /home/testtools --username wzhnsc
svn co http://localhost/test/testapp --username wzhnsc
svn checkout svn://localhost/测试工具 /home/testtools --username wzhnsc
svn checkouthttp://localhost/test/testapp --username wzhnsc

2、导出(导出一个干净的不带.svn文件夹的目录树)
svn  export  [-r 版本号]  http://路径(目录或文件的全路径) [本地目录全路径]　--username　用户名
svn  export  [-r 版本号]  svn://路径(目录或文件的全路径) [本地目录全路径]　--username　用户名
svn  export  本地检出的(即带有.svn文件夹的)目录全路径  要导出的本地目录全路径
注：第一种从版本库导出干净工作目录树的形式是指定URL，
　　　如果指定了修订版本号，会导出相应的版本，
　　　如果没有指定修订版本，则会导出最新的，导出到指定位置。
　　　如果省略 本地目录全路径，URL的最后一部分会作为本地目录的名字。
　　第二种形式是指定 本地检出的目录全路径 到 要导出的本地目录全路径，所有的本地修改将会保留，
　　　但是不在版本控制下(即没提交的新文件，因为.svn文件夹里没有与之相关的信息记录)的文件不会拷贝。
例子：
svn export svn://localhost/测试工具 /home/testtools --username wzhnsc
svn export svn://localhost/test/testapp --username wzhnsc
svn export /home/testapp /home/testtools

3、添加新文件 
svn　add　文件名
注：告诉SVN服务器要添加文件了，还要用svn commint -m真实的上传上去！
例子：
svn add test.php ＜－ 添加test.php 
svn commit -m “添加我的测试用test.php“ test.php
svn add *.php ＜－ 添加当前目录下所有的php文件
svn commit -m “添加我的测试用全部php文件“ *.php

4、提交
svn　commit　-m　“提交备注信息文本“　[-N]　[--no-unlock]　文件名
svn　ci　-m　“提交备注信息文本“　[-N]　[--no-unlock]　文件名
必须带上-m参数，参数可以为空，但是必须写上-m
例子：
svn commit -m “提交当前目录下的全部在版本控制下的文件“ * ＜－ 注意这个*表示全部文件
svn commit -m “提交我的测试用test.php“ test.php
svn commit -m “提交我的测试用test.php“ -N --no-unlock test.php ＜－ 保持锁就用–no-unlock开关
svn ci -m “提交当前目录下的全部在版本控制下的文件“ * ＜－ 注意这个*表示全部文件
svn ci -m “提交我的测试用test.php“ test.php
svn ci -m “提交我的测试用test.php“ -N --no-unlock test.php ＜－ 保持锁就用–no-unlock开关

5、更新文件
svn　update
svn　update　-r　修正版本　文件名
svn　update　文件名
例子：
svn update ＜－ 后面没有目录，默认将当前目录以及子目录下的所有文件都更新到最新版本
svn update -r 200 test.cpp ＜－ 将版本库中的文件 test.cpp 还原到修正版本（revision）200
svn update test.php ＜－ 更新与版本库同步。
　　　　　　　　　　　 提交的时候提示过期冲突，需要先 update 修改文件，
　　　　　　　　　　　 然后清除svn resolved，最后再提交commit。

6、删除文件
svn　delete　svn://路径(目录或文件的全路径) -m “删除备注信息文本”
推荐如下操作：
svn　delete　文件名 
svn　ci　-m　“删除备注信息文本”
例子：
svn delete svn://localhost/testapp/test.php -m “删除测试文件test.php”
推荐如下操作：
svn delete test.php 
svn ci -m “删除测试文件test.php”

７、加锁/解锁 
svn　lock　-m　“加锁备注信息文本“　[--force]　文件名 
svn　unlock　文件名
例子：
svn lock -m “锁信测试用test.php文件“ test.php 
svn unlock test.php

8、比较差异 
svn　diff　文件名 
svn　diff　-r　修正版本号m:修正版本号n　文件名
例子：
svn diff test.php＜－ 将修改的文件与基础版本比较
svn diff -r 200:201 test.php＜－ 对 修正版本号200 和 修正版本号201 比较差异

9、查看文件或者目录状态
svn st 目录路径/名
svn status 目录路径/名＜－ 目录下的文件和子目录的状态，正常状态不显示 
　　　　　　　　　　　　　【?：不在svn的控制中；  M：内容被修改；C：发生冲突；
　　　　　　　　　　　　　　A：预定加入到版本库；K：被锁定】 
svn  -v 目录路径/名
svn status -v 目录路径/名＜－ 显示文件和子目录状态
　　　　　　　　　　　　　　【第一列保持相同，第二列显示工作版本号，
　　　　　　　　　　　　　　　第三和第四列显示最后一次修改的版本号和修改人】 
注：svn status、svn diff和 svn revert这三条命令在没有网络的情况下也可以执行的，
　　原因是svn在本地的.svn中保留了本地版本的原始拷贝。 

10、查看日志
svn　log　文件名
例子：
svn log test.php＜－ 显示这个文件的所有修改记录，及其版本号的变化 

11、查看文件详细信息
svn　info　文件名
例子：
svn info test.php

12、SVN 帮助
svn　help ＜－ 全部功能选项
svn　help　ci ＜－ 具体功能的说明

13、查看版本库下的文件和目录列表 
svn　list　svn://路径(目录或文件的全路径)
svn　ls　svn://路径(目录或文件的全路径)
例子：
svn list svn://localhost/test
svn ls svn://localhost/test ＜－ 显示svn://localhost/test目录下的所有属于版本库的文件和目录 

14、创建纳入版本控制下的新目录
svn　mkdir　目录名
svn　mkdir　-m　"新增目录备注文本"　http://目录全路径
例子：
svn mkdir newdir
svn mkdir -m "Making a new dir." svn://localhost/test/newdir 
注：添加完子目录后，一定要回到根目录更新一下，不然在该目录下提交文件会提示“提交失败”
svn update
注：如果手工在checkout出来的目录里创建了一个新文件夹newsubdir，
　　再用svn mkdir newsubdir命令后，SVN会提示：
　　svn: 尝试用 “svn add”或 “svn add --non-recursive”代替？
　　svn: 无法创建目录“hello”: 文件已经存在
　　此时，用如下命令解决：
　　svn add --non-recursive newsubdir
　　在进入这个newsubdir文件夹，用ls -a查看它下面的全部目录与文件，会发现多了：.svn目录
　　再用 svn mkdir -m "添hello功能模块文件" svn://localhost/test/newdir/newsubdir 命令，
　　SVN提示：
　　svn: File already exists: filesystem '/data/svnroot/test/db', transaction '4541-1',
　　path '/newdir/newsubdir '

15、恢复本地修改 
svn　revert　[--recursive]　文件名
注意: 本子命令不会存取网络，并且会解除冲突的状况。但是它不会恢复被删除的目录。
例子：
svn revert foo.c ＜－ 丢弃对一个文件的修改
svn revert --recursive . ＜－恢复一整个目录的文件，. 为当前目录 

16、把工作拷贝更新到别的URL 
svn　switch　http://目录全路径　本地目录全路径
例子：
svn switch http://localhost/test/456 . ＜－ (原为123的分支)当前所在目录分支到localhost/test/456

17、解决冲突 
svn　resolved　[本地目录全路径]
例子：
$ svn update
C foo.c
Updated to revision 31.
如果你在更新时得到冲突，你的工作拷贝会产生三个新的文件：
$ ls
foo.c
foo.c.mine
foo.c.r30
foo.c.r31
当你解决了foo.c的冲突，并且准备提交，运行svn resolved让你的工作拷贝知道你已经完成了所有事情。
你可以仅仅删除冲突的文件并且提交，但是svn resolved除了删除冲突文件，还修正了一些记录在工作拷贝管理区域的记录数据，所以我们推荐你使用这个命令。

18、不checkout而查看输出特定文件或URL的内容 
svn　cat　http://文件全路径
例子：
svn cat http://localhost/test/readme.txt

19、新建一个分支copy
svn copy branchA branchB  -m "make B branch" // 从branchA拷贝出一个新分支branchB

20、合并内容到分支merge
svn merge branchA branchB  // 把对branchA的修改合并到分支branchB



svn st 各个状态解释：
输出的前七栏各占一个字符宽度: 
    第一栏: 表示一个项目是增加、删除，还是修改
      “ ” 无修改
      “A” 增加
      “C” 冲突
      “D” 删除
      “I” 忽略
      “M” 改变
      “R” 替换
      “X” 未纳入版本控制的目录，被外部引用的目录所创建
      “?” 未纳入版本控制
      “!” 该项目已遗失(被非 svn 命令删除)或不完整
      “~” 版本控制下的项目与其它类型的项目重名
    第二栏: 显示目录或文件的属性状态
      “ ” 无修改
      “C” 冲突
      “M” 改变
    第三栏: 工作副本目录是否被锁定
      “ ” 未锁定
      “L” 锁定
    第四栏: 已调度的提交是否包含副本历史
      “ ” 没有历史
      “+” 包含历史
    第五栏: 该条目相对其父目录是否已切换，或者是外部引用的文件
      “ ” 正常
      “S” 已切换
      “X” 被外部引用创建的文件
    第六栏: 版本库锁定标记
      (没有 -u)
      “ ” 没有锁定标记
      “K” 存在锁定标记
      (使用 -u)
      “ ” 没有在版本库中锁定，没有锁定标记
      “K” 在版本库中被锁定，存在锁定标记
      “O” 在版本库中被锁定，锁定标记在一些其他工作副本中
      “T” 在版本库中被锁定，存在锁定标记但已被窃取
      “B” 没有在版本库中被锁定，存在锁定标记但已被破坏
    第七栏: 项目冲突标记
      “ ” 正常
      “C” 树冲突
    如果项目包含于树冲突之中，在项目状态行后会附加行，说明冲突的种类。

  是否过期的信息出现的位置是第九栏(与 -u 并用时): 
      “*” 服务器上有更新版本
      “ ” 工作副本是最新版的


=========================================================
 relocate svn server in project after svn server changed
---------------------------------------------------------
svn relocate https://192.168.0.10:8443/svn/rivpiebase/branches/lora_gateway  https://172.16.11.10:8443/svn/rivpiebase/branches/lora_gateway


EOF

