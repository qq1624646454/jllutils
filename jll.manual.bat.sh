#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.bat.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-08-08 16:01:43
#   ModifiedTime: 2020-11-27 11:38:21

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

FG=${Fgreen}

more >&1<<EOF

${FG}Run Microsoft DOS ${AC}
T:\>
T:\> ${FG}for /f "tokens=*" %i in ( ' ipconfig /all ^| find /i "ipv4" ' ) do set result=%i${AC}
T:\> set result=IPv4 地址 . . . . . . . . . . . . : 172.20.27.30(首选)
T:\>
T:\> ${FG}for /f "tokens=1" %i in ( ' ipconfig /all ^| find /i "ipv4" ' ) do set result=%i${AC}
T:\> set result=IPv4
T:\>
T:\> ${FG}for /f "tokens=2" %i in ( ' ipconfig /all ^| find /i "ipv4" ' ) do set result=%i${AC}
T:\> set result=地址
T:\>
T:\> ${FG}for /f "tokens=3" %i in ( ' ipconfig /all ^| find /i "ipv4" ' ) do set result=%i${AC}
T:\> set result=.
T:\>
T:\> ${FG}for /f "tokens=2 delims=:(" %i in ( ' ipconfig /all ^| find /i "ipv4" ' ) do set result=%i${AC}
T:\> set result= 172.20.27.30
T:\>
T:\>
T:\>
T:\> ${Fred}JLL: list filename with suffix${AC}
T:\> ${FG}for /f "tokens=1 delims=" %i in ( ' dir *.ppt /B ^&^& dir *.pptx /B ' ) ^
do @echo result=%i${AC}
T:\> result=te st.ppt
T:\> result=deplayer_design_draftbook.ppt
T:\> result=1.pptx
T:\> result=2.pptx
T:\>
T:\> ${Fred}JLL: list filename without suffix${AC}
T:\> ${FG}for /f "tokens=1 delims=" %i in ( ' dir *.ppt /B ^&^& dir *.pptx /B ' ) ^
do @echo result=%~ni${AC}
T:\> result=te st
T:\> result=deplayer_design_draftbook
T:\> result=1
T:\> result=2



FOR 变量参照的替换已被增强。您现在可以使用下列 
选项语法: 

~I - 删除任何引号(")，扩展 %I 
%~fI - 将 %I 扩展到一个完全合格的路径名 
%~dI - 仅将 %I 扩展到一个驱动器号 
%~pI - 仅将 %I 扩展到一个路径 
%~nI - 仅将 %I 扩展到一个文件名 
%~xI - 仅将 %I 扩展到一个文件扩展名 
%~sI - 扩展的路径只含有短名 
%~aI - 将 %I 扩展到文件的文件属性 
%~tI - 将 %I 扩展到文件的日期/时间 
%~zI - 将 %I 扩展到文件的大小 
%~\$PATH:I - 查找列在路径环境变量的目录，并将 %I 扩展 
到找到的第一个完全合格的名称。如果环境变量名 
未被定义，或者没有找到文件，此组合键会扩展到 
空字符串 

可以组合修饰符来得到多重结果: 

%~dpI - 仅将 %I 扩展到一个驱动器号和路径 
%~nxI - 仅将 %I 扩展到一个文件名和扩展名 
%~fsI - 仅将 %I 扩展到一个带有短名的完整路径名 
%~dp\\$PATH:I - 搜索列在路径环境变量的目录，并将 %I 扩展 
到找到的第一个驱动器号和路径。 
%~ftzaI - 将 %I 扩展到类似输出线路的 DIR 




%WINDIR%                 {系统目录 - C:\\WINDOWS}
%SYSTEMROOT%             {系统目录 - C:\\WINDOWS}
%SYSTEMDRIVE%            {系统根目录 - C:}
%HOMEDRIVE%              {当前用户根目录 - C:}
%USERPROFILE%            {当前用户目录 - C:\\Documents and Settings\\wy}
%HOMEPATH%               {当前用户路径 - \\Documents and Settings\\wy}
%TMP%                    {当前用户临时文件夹 - C:\\DOCUME~1\\wy\\LOCALS~1\\Temp}
%TEMP%                   {当前用户临时文件夹 - C:\\DOCUME~1\\wy\\LOCALS~1\\Temp}
%APPDATA%                {当前用户数据文件夹 - C:\\Documents and Settings\\wy\\Application Data}
%PROGRAMFILES%           {程序默认安装目录 - C:\\Program Files}
%COMMONPROGRAMFILES%     {文件通用目录 - C:\\Program Files\\Common Files}
%USERNAME%               {当前用户名 - wy}
%ALLUSERSPROFILE%        {所有用户文件目录 - C:\\Documents and Settings\\All Users}
%OS%                     {操作系统名 - Windows_NT}
%COMPUTERNAME%           {计算机名 - IBM-B63851E95C9}
%NUMBER_OF_PROCESSORS%   {处理器个数 - 1}
%PROCESSOR_ARCHITECTURE% {处理器芯片架构 - x86}
%PROCESSOR_LEVEL%        {处理器型号 - 6}
%PROCESSOR_REVISION%     {处理器修订号 - 0905}
%USERDOMAIN%             {包含用户帐号的域 - IBM-B63851E95C9}
%COMSPEC%                {C:\\WINDOWS\\system32\\cmd.exe}

%PATHEXT% {执行文件类型 - .COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.pyo;.pyc;.py;.pyw}
%PATH%    {搜索路径}
--------------------------------------------------------------------------------
另外, 可以利用 .. 到上层目录, 如:
--------------------------------------------------------------------------------
 
var
  s: string;
begin
  s := GetCurrentDir;
  ShowMessage(s); {C:\\Documents and Settings\\wy\\My Documents\\RAD Studio\\Projects}

  SetCurrentDir('..');
  s := GetCurrentDir;
  ShowMessage(s); {C:\\Documents and Settings\\wy\\My Documents\\RAD Studio}
  SetCurrentDir('..\\..');
  s := GetCurrentDir;
  ShowMessage(s); {C:\\Documents and Settings\\wy}
end;




@echo off


EOF

