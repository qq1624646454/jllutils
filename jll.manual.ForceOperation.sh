#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

###
### List all the related processes which are using the application with <Keyword>
###
lsof <Keyword>

#
# For Example:
#
root@TpvServer:/# umount /Rescue
umount: /Rescue: device is busy.
        (In some cases useful info about processes that use
         the device is found by lsof(8) or fuser(1))
root@TpvServer:/# sync
root@TpvServer:/# lsof /Rescue/
COMMAND  PID USER   FD   TYPE DEVICE    SIZE/OFF   NODE NAME
mv      8918 root  cwd    DIR    8,6        4096 523265 /Rescue/TPV.Corportaion
mv      8918 root    4w   REG    8,6 23160750080 527997 /Rescue/TPV.Corportaion/Other/Reposity.tgz (deleted)
root@TpvServer:/# kill -9 8918
root@TpvServer:/# lsof /Rescue/
[1]+  Killed                  mv /home/jielong.lin/Other/Reposity.tgz Other/  (wd: /Rescue/TPV.Corportaion)
(wd now: /)
root@TpvServer:/#
root@TpvServer:/#
root@TpvServer:/# lsof /Rescue/

EOF

