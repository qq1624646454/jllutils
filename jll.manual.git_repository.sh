#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.git_repository.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-06-28 16:43:38
#   ModifiedTime: 2017-06-29 13:43:10

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary
issueID=0

more >&1 << EOF

******************************************************************
** How to build git project management:
**   Linux(Debian,Ubuntu) as git remote repository
**   Window7(installed Git-Bash, ConEmu) as git local repository
**
** Such as Android APP code development workaround in windows7
******************************************************************
##
## Check if 80 and 8888 ports are used. Proposal use 8888 port.
${Fyellow} netstat -nap | grep -E -w '80|8888' ${AC}
 
${Fyellow} dpkg --get-selections | grep git ${AC}

${Fyellow} apt-get install git git-svn git-doc git-email git-gui gitk gitweb ${AC}


## install apache2 to support for gitweb
${Fyellow} apt-get install apache2 ${AC}

## Create a common default account to access git repository.
${Fyellow} jll.user.sh add ${AC}
## After git account is created, switch root to git account
${Fyellow} su - git ${AC} 
## Create a test project
${Fyellow} mkdir -pv test ${AC}
${Fyellow} cd test ${AC}
${Fyellow} touch readme ${AC}
${Fyellow} git config --global user.email "jielong.lin@tpv-tech.com" ${AC}
${Fyellow} git config --global user.name "jielong.lin" ${AC}
${Fyellow} git init ${AC}
${Fyellow} git add -A ${AC}
${Fyellow} git commit -m "create first time" ${AC}
${Fyellow} git log ${AC}

# arrive here, please switch to root account...
${Fyellow} su - root ${AC}

## For enable the url http://localhost/gitweb
##     or enable the url http://localhost:80/gitweb
##     or enable the url localhost:80/gitweb
## the one of the below methods is valid, default by method-2.
## ${Fgreen}proposal use method-2, it seems nothing to do. [jielong.lin] ${AC}
## method-1:
${Fyellow} ln -s /usr/share/gitweb /var/www/ ${AC}

## method-2: add a new configure file /etc/apache2/conf.d/gitweb
${Fyellow} vim /etc/apache2/conf.d/gitweb ${AC}
${Fyellow} 1 Alias /gitweb /usr/share/gitweb ${AC}
${Fyellow} 2 ${AC}
${Fyellow} 3 <Directory /usr/share/gitweb> ${AC}
${Fyellow} 4   Options FollowSymLinks +ExecCGI ${AC}
${Fyellow} 5   AddHandler cgi-script .cgi ${AC}
${Fyellow} 6 </Directory> ${AC}

## let gitweb be customized. 
${Fyellow} vim /etc/gitweb.conf ${AC}
  1 # path to git projects (<project>.git)
  2 \$projectroot = "${Fyellow}/home/git${AC}";
  3
  4 # directory to use for temp files
  ...
 31
 32 ${Fyellow}\$site_name = "GitWeb @ TPV-Server";${AC}
 33 ${Fyellow}#\$feature{'search'}{'default'} = [1]; ${AC}
 34 ${Fyellow}#\$feature{'blame'}{'default'} = [1]; ${AC}


## be actived after restart apache server 
${Fyellow} /etc/init.d/apache2 restart ${AC}

## Testing...type "http://localhost/gitweb"
${Fyellow} m3w http://localhost:80/gitweb ${AC}
${Fyellow} m3w http://localhost:8888/gitweb ${AC}



${Bred}${Fwhite}                                                               ${AC}
${Bred}${Fwhite}  ${AC}  ISSUE-$((issueID++))
${Bred}${Fwhite}                                                               ${AC}
${Fwhite}root@TpvServer:~# ${Fgreen}w3m http://localhost:8888/gitweb${AC}
${Fgreen}git${Fblue}projects${AC} /

404 - No projects found
${Fblue}OPML TXT${AC}

${Bgreen}${Fblack}SOLVE ${AC}                                                    
${Fgreen}The root-caused reason is that not perssion for the current account.${AC}
${Fgreen}Please create a new account and enable some git project ${AC}




${Bred}${Fwhite}                                                               ${AC}
${Bred}${Fwhite}  ${AC}  ISSUE-$((issueID++))
${Bred}${Fwhite}                                                               ${AC}
${Fwhite}root@TpvServer:/etc/apache2# ${Fgreen}/etc/init.d/apache2 start${AC}
${Fred} * Starting web server apache2${AC}
${Fred}apache2: Could not reliably determine the server's fully qualified domain name, ${AC}
${Fred}         using 127.0.1.1 for ServerName${AC}

${Bgreen}${Fblack}SOLVE ${AC}                                                    
${Fwhite}root@TpvServer:/etc/apache2# ${Fgreen}echo "ServerName localhost" > httpd.conf${AC}



${Bred}${Fwhite}                                                               ${AC}
${Bred}${Fwhite}  ${AC}  ISSUE-$((issueID++))
${Bred}${Fwhite}                                                               ${AC}
${Fwhite}root@TpvServer:/etc/apache2# ${Fgreen}/etc/init.d/apache2 start${AC}
${Fred} * Starting web server apache2${AC}
${Fred}(98)Address already in use: make_sock: could not bind to address 0.0.0.0:80${AC}
${Fred}no listening sockets available, shutting down${AC}
${Fred}Unable to open logs${AC}
${Fred}Action 'start' failed.${AC}
${Fred}The Apache error log may have more information.${AC}

${Bgreen}${Fblack}SOLVE ${AC}                                                    
${Fwhite}root@TpvServer:/etc/apache2# ${Fgreen}vim /etc/apache2/ports.conf${AC}
  7
  8 NameVirtualHost *:80
  9 Listen ${Fgreen}8888${AC}
 10



${Bgreen}${Fwhite}                                                               ${AC}
${Bgreen}${Fwhite}  ${AC}   GIT SERVER                                           ${AC}
${Bgreen}${Fwhite}  ${AC}   building a Git Remote Repository without work tree
${Bgreen}${Fwhite}  ${AC}   namely all files only belong to .git and none source code
${Bgreen}${Fwhite}  ${AC}   ITS URL is "username@server_ip:projectname" 
${Bgreen}${Fwhite}  ${AC}   such as  "git@172.20.30.29:drmplayer_demo" 
${Bgreen}${Fwhite}                                                               ${AC}
${Fyellow} su - git ${AC}
${Fyellow} mkdir -pv drmplayer_demo ${AC}
${Fyellow} cd drmplayer_demo ${AC}
${Fyellow} git init --bare ${AC}
${Fyellow} ls -al ${AC}

${Bgreen}${Fwhite}                                                               ${AC}
${Bgreen}${Fwhite}  ${AC}   GIT CLIENT                                           ${AC}
${Bgreen}${Fwhite}  ${AC}   building a Git Local Repository with work tree
${Bgreen}${Fwhite}  ${AC}   namely contained .git and source code
${Bgreen}${Fwhite}                                                               ${AC}
jielong.lin@XMNB4003161 MINGW32 /d/System/jielong.lin/Desktop/hello 
\$${Fyellow} git init ${AC}
Initialized empty Git repository in D:/System/jielong.lin/Desktop/hello/.git/

jielong.lin@XMNB4003161 MINGW32 /d/System/jielong.lin/Desktop/hello (master)
\$${Fyellow} git add . ${AC}
warning: LF will be replaced by CRLF in hello.txt.
The file will have its original line endings in your working directory.

jielong.lin@XMNB4003161 MINGW32 /d/System/jielong.lin/Desktop/hello (master)
\$${Fyellow} git commit -m "add" ${AC}
[master (root-commit) e3ab94c] add
 1 file changed, 1 insertion(+)
 create mode 100644 hello.txt

jielong.lin@XMNB4003161 MINGW32 /d/System/jielong.lin/Desktop/hello (master)
\$${Fyellow} git log ${AC}
commit e3ab94c3025b28b48a47ed4260d0c9730d933039
Author: jielong.lin <493164984@qq.com>
Date:   Wed Jun 28 23:21:57 2017 +0800

    add

jielong.lin@XMNB4003161 MINGW32 /d/System/jielong.lin/Desktop/hello (master)
\$${Fyellow} git remote add origin git@172.20.30.29:drmplayer_demo ${AC}

jielong.lin@XMNB4003161 MINGW32 /d/System/jielong.lin/Desktop/hello (master)
\$${Fyellow} git push origin master ${AC}
Enter passphrase for key '/c/Users/jielong.lin/.ssh/id_rsa':
git@172.20.30.29's password:
Counting objects: 3, done.
Writing objects: 100% (3/3), 211 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To 172.20.30.29:drmplayer_demo
 * [new branch]      master -> master

jielong.lin@XMNB4003161 MINGW32 /d/System/jielong.lin/Desktop/hello (master)
\$


${Bred}${Fwhite}                                                               ${AC}
${Bred}${Fwhite}  ${AC}  ISSUE-$((issueID++)) on git version 2.9.3.windows.2
${Bred}${Fwhite}                                                               ${AC}
${Fwhite}jielong.lin@XMNB4003161 MINGW32 ~/hello \$${Fyellow} git add .        ${AC}
${Fred}warning: LF will be replaced by CRLF in hello.txt. ${AC}
${Fred}The file will have its original line endings in your working directory. ${AC}

${Bgreen}${Fblack}SOLVE ${AC}                                                    
${Bgreen}${Fblack}Windows use CRLF to break line, but Unix/Linux use LF, so git${AC}
${Bgreen}${Fblack}will translate LF to CRLF for compatible with Windows        ${AC}
${Fwhite}jielong.lin@XMNB4003161 MINGW32 ~/hello \
\$ ${Fgreen}git config --global core.autocrlf false${AC}



${Bred}${Fwhite}                                                               ${AC}
${Bred}${Fwhite}  ${AC}  ISSUE-$((issueID++)) on git version 2.9.3.windows.2
${Bred}${Fwhite}                                                               ${AC}
${Fwhite}jielong.lin@XMNB4003161 MINGW32 ~/hello \$${Fyellow} git add -A       ${AC}
${Fred}... Filename too long ${AC}

${Bgreen}${Fblack}SOLVE ${AC}                                                    
${Bgreen}${Fblack}The path name length is limited for mysys-git in windows${AC}
${Fwhite}jielong.lin@XMNB4003161 MINGW32 ~/hello \
\$ ${Fgreen}git config --global core.longpaths true ${AC}


Please make a shell script file "build_git.sh"
===============================================================================
#!/bin/bash

exit 0 # please disable after build git repository successfully.
if [ x"\$1" = x ]; then
    echo
    echo "Exit: please type the legal URL, such as:"
    echo "      git@172.20.30.29:project_test"
    echo "For example: \$0 \"git@172.20.30.29:project_test\""
    echo
    exit 0
fi

_my_URL=\$1
_my_Project=\${_my_URL##*:}
_my_URL=\${_my_URL%%:*}

ssh \${_my_URL} "ls \${_my_Project} 2>/dev/null"

if [ x"\$?" != x"0" ]; then
    echo
    echo "Exit: please type the legal USERNAME@URL:PROJECT, such as:"
    echo "      git@172.20.30.29:project_test"
    echo
    exit 0
fi

_my_DT="\$(date +%Y-%m-%d\ %H:%M)"

echo "git init"
git init
echo "git add -A"
git add -A
echo "git commit -m \"create the new project @ \${_my_DT}\""
git commit -m "create the new project @ \${_my_DT}"
echo "git remote add origin \$1"
git remote add origin \$1
echo "#git push origin master"
# git push origin master


${Bgreen}${Fwhite}                                                               ${AC}
${Bgreen}${Fwhite}  ${AC}   GIT CLIENT                                           ${AC}
${Bgreen}${Fwhite}  ${AC}   clone a Git Local Repository with work tree
${Bgreen}${Fwhite}  ${AC}   namely contained .git and source code
${Bgreen}${Fwhite}                                                               ${AC}
jielong.lin@XMNB4003161 MINGW32 ~
\$${Fyellow} git clone git@172.20.30.29:drmplayer_demo ${AC}
Cloning into 'drmplayer_demo'...
git@172.20.30.29's password:
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 7 (delta 1), reused 0 (delta 0)
Receiving objects: 100% (7/7), done.
Resolving deltas: 100% (1/1), done.
Checking connectivity... done.


EOF

