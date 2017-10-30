#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.svn_git.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-10-31 01:02:19
#   ModifiedTime: 2017-10-31 01:03:20

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

Git VS SVN  
区别
比较项目	Git 命令						SVN 命令
URL	      git://host/path/to/repos.git	  svn://host/path/to/repos
		  ssh://user@host/path/to/repos	  https://host/path/repos
		  file:///path/to/repos			  file:///path/to/repos
		  user@host:path/to/repos		  /path/to/repos.git
	　
版本库初始化	git init[--bare]<path>	        svnadmin create<path>
导入数据	    git clone; git add; git commit	svn import<path><url>-m
版本库检验出	git clone<url><path>	        svn checkout<url/of/trunk><path>
版本库分支检出	git clone -b <branch><url><path>	svn checkout<url/ofranches/name><path>
工作区更新   	git pull	                        svn update
更新至历史版本	git checkout <commit>	            suv update -r <rev>
更新到指定日期	git  checkout HEAD@'{<date>}'
                git update -r {<date>}
更新至最新提交	git checkout master	
                git update -r HEAD
切换至里程碑	git checkout <tag>			  	    svn switch<url/of/tags/name>
切换至分支	    git checkout <branch>              	svn switch<url/of/branches/name>
还原文件／强制覆盖	git checkout --<path>			svn revert<path>
添加文件	git add <path>							svn add <path>
删除文件	git rm <path>							svn rm <path>
移动文件	git mv <old> <new>						svn mv <old><new>
清除未跟踪文件	git clean							svn status | sed -e??
清除工作锁定	_									svn clean
读取文件历史版本	git show <commit>:<path>><output>	svn cat -r<rev><url/of/file>@<rev>><output>
反删除文件			git add <path>						svn cp -r
工作区差异比较	    git diff
                    git diff --cached
                    git diff HEAD						svn diff
版本间差异比较	git diff <commit1><commit2>--<path>		svn diff -r <rev1>:<rev2><path>
查看工作区状态	git status -s	svn status
提交	        git commit -a -m "<msg>":git push		svn commit -m "<msg>"
显示提交日志	git log									svn log | less
逐行追溯	    git blame	git blame
显示里程碑／分支	git tag
                    git branch
                    git show -ref						svn ls <url/of/tags/>
                                                        svn ls <url/of/branches/>
创建里程碑	git tag [-m "<msg>"]<tagname> [<commit>]	svn cp <url/of/trunk><url/of/tags/name>
删除里程碑	git tag -d <tagname>						svn  rm <url/of/tags/name>
创建分支	git branch <brach> <commit> git checkout -b <branch><commit>	svn cp <url/of/trunk> <url/braches/name>
删除分支	git bracn -d<branch>											svn rm <url/of/branches/name>
导出项目文件	git archive -o <output.tar><commit>							svn export -r <rev> <path><oupt/path>
																			svn export -r <rev><url><output/path>
反转提交	git revert<commit>	git merge -c <rev>
提交练选	git cherry-pick<commit>		git merg -c <rev>
分支合并	git merge <branch>												svn merge <url/of/branch>
冲突解决	git mergetool git add <path>				svn resolve --accept = <ARG><path>     svn resolved<path>
显示文件列表	git ls-files	 git ls-tree<commit>	git ls	 git ls <url> -r <rev>
更改提交说明	git commit -amend							svn ps -revprop -r <rev>svn:log "<<msg>"
撤销提交	git reset[--soft|hard]HEAD^						svnadmin dump, svnadmin load ,svndumpfiler

EOF


