#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.signal.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-07-15 16:18:21
#   ModifiedTime: 2017-07-15 16:46:07

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

可以列出信号与键盘按键的对应关系
${Fseablue}stty -a${AC}
SIGINT: ctrl+c
SIGQUIT: ctrl+\

trap捕捉到信号之后，可以有三种反应方式：
(1)执行一段程序来处理这一信号
${Fgreen}trap 'commands' signal-list ${AC}
${Fgreen}trap "commands" signal-list ${AC}
    For Example:
    when this script receive SIGHUP(=1),SIGINT(=2),SIGQUIT(=3),SIGTERM(=15)
    this script will execute echo "I have received 1 or 2 or 3 or 15"
        ${Fgreen}trap "echo 'I have received 1 or 2 or 3 or 15' " 1 2 3 15${AC}

(2)接受信号的默认操作
${Fgreen}trap signal-list ${AC}

(3)忽视这一信号
${Fgreen}trap " " signal-list ${AC}
${Fgreen}trap '' siganl-list ${AC}
${Fgreen}trap : signal-list ${AC}

通常我们需要忽略的信号有四个，即：HUP, INT, QUIT, TSTP，也就是信号1, 2, 3, 24
trap "" 1 2 3 24 或 trap "" HUP INT QUIT TSTP
trap ：1 2 3 24 或 trap HUP INT QUIT TSTP使其回复默认值

NOTE：trap 对同种signal只能相应一种设定，如果在一个shell里面设置多个trap，如：
    trap   ' echo “aaaaaaaaaaa”  '  INT
    trap   ' echo “bbbbbbbbbbb”  '  INT
它只会响应最后一个信号设定



kill -l可以列出系统的信号


Send a signal to Process
-s SIGTERM to specify the signal name, and -15 to specify the signal digit
${Fgreen}kill -s SIGTERM pid${AC} <=> ${Fgreen}kill -15 pid${AC} <=> ${Fgreen} kill pid${AC}


　  1) SIGHUP 本信号在用户终端连接(正常或非正常)结束时发出, 通常是在终端de控制进程结束时, 
       通知同一session内de各个作业, 这时它们与控制终端不再关联.
　　2) SIGINT 程序终止(interrupt)信号, 在用户键入INTR字符(通常是Ctrl-C)时发出
　　3) SIGQUIT 和SIGINT类似, 但由QUIT字符(通常是Ctrl-\)来控制. 进程在因收到SIGQUIT
       退出时会产生core文件, 在这个意义上类似于一个程序错误信号.
　　4) SIGILL 执行了非法指令. 通常是因为可执行文件本身出现错误, 或者试图执行数据段. 
       堆栈溢出时也you可能产生这个信号.
　　5) SIGTRAP 由断点指令或其它trap指令产生. 由debugger使用.
　　6) SIGABRT 程序自己发现错误并调用abort时产生.
　　7) SIGIOT 在PDP-11上由iot指令产生, 在其它机器上和SIGABRT一样.
　　8) SIGBUS 非法地址, 包括内存地址对齐(alignment)出错. eg: 访问一个四个字长de整数, 
       但其地址不是4de倍数.
　　9) SIGFPE 在发生致命de算术运算错误时发出. 不仅包括浮点运算错误, 还包括溢出及除数为0等
       其它所youde算术de错误.
　　10) SIGKILL(=9) 用来立即结束程序de运行. 本信号不能被阻塞, 处理和忽略.
　　11) SIGUSR1 留给用户使用
　　12) SIGSEGV 试图访问未分配给自己de内存, 或试图往没you写权限de内存地址写数据.
　　13) SIGUSR2 留给用户使用
　　14) SIGPIPE Broken pipe
　　15) SIGALRM 时钟定时信号, 计算de是实际de时间或时钟时间. alarm函数使用该信号.
　　16) SIGTERM(=15) 程序结束(terminate)信号, 与SIGKILL(=9)不同de是该信号可以被阻塞和处理. 
        通常用来要求程序自己正常退出. shell命令kill缺省产生这个信号.
　　17) SIGCHLD子进程结束时, 父进程会收到这个信号.
　　18) SIGCONT让一个停止(stopped)de进程继续执行. 本信号不能被阻塞. 可以用一个handler来让
        程序在由stopped状态变为继续执行时完成特定de工作. 例如, 重新显示提示符
　  19) SIGSTOP 停止(stopped)进程de执行. 注意它和terminate以及interruptde区别: 
        该进程还未结束, 只是暂停执行. 本信号不能被阻塞, 处理或忽略.
　　20) SIGTSTP(=20) 停止进程de运行, 但该信号可以被处理和忽略. 用户键入SUSP字符时(通常是Ctrl-Z)
        发出这个信号
　　21) SIGTTIN 当后台作业要从用户终端读数据时, 该作业中de所you进程会收到SIGTTIN信号. 
        缺省时这些进程会停止执行.
　　22) SIGTTOU 类似于SIGTTIN,但在写终端(或修改终端模式)时收到.
　　23) SIGURG you紧急数据或out-of-band数据到达socket时产生.
　　24) SIGXCPU 超过CPU时间资源限制. 这个限制可以由getrlimit/setrlimit来读取/改变
　　25) SIGXFSZ 超过文件大小资源限制.
　　26) SIGVTALRM 虚拟时钟信号. 类似于SIGALRM,但是计算de是该进程占用deCPU时间.
　　27) SIGPROF 类似于SIGALRM/SIGVTALRM,但包括该进程用deCPU时间以及系统调用de时间.
　　28) SIGWINCH 窗口大小改变时发出.
　　29) SIGIO 文件描述符准备就绪, 可以开始进行输入/输出操作.
　　30) SIGPWR Power failure



EOF

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"


