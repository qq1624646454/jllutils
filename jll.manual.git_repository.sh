#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.git_repository.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-06-28 16:43:38
#   ModifiedTime: 2017-06-28 18:08:44

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


## enable the url http://localhost:80/gitweb

${Fyellow} ln -s /usr/share/gitweb /var/www/ ${AC}




## configure apache2 
##   modify the index page
${Fyellow} grep -iR DirectoryIndex /etc/apache2 ${AC}
./mods-available/dir.conf:  DirectoryIndex \\
    index.html index.cgi index.pl index.php index.xhtml index.htm
./mods-enabled/dir.conf:  DirectoryIndex \\
    index.html index.cgi index.pl index.php index.xhtml index.htm




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
  8 NameVirtualHost *:${Fgreen}8888${AC}
  9 Listen ${Fgreen}8888${AC}
 10



EOF

