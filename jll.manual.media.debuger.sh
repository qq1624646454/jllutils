#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.media.debuger.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-06-15 13:27:13
#   ModifiedTime: 2017-06-15 13:31:23

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

${Fyellow} Lookup the mediatek media module status: mute ${AC}
------------------------------------------------------------------------------------
android:/ #
android:/ # ${Fseablue}su${AC}
android:/ # ${Fseablue}cli${AC}
android:/ #
[  998.273122] DTV> ${Fseablue}n.mute.q 0 0${AC}
Video Path = 0
[ 1105.171500] ===============================================================
[ 1105.177597] Module =  0      (API_FORCE: AP) Invalid = 0x0 Delay conter = -1
[ 1105.184500] Module =  1           (BLUE: AP) Invalid = 0x0 Delay conter = 0
[ 1105.191511] Module =  2          (BLACK: AP) Invalid = 0x0 Delay conter = 0
[ 1105.197881] Module =  3             (MDDI01) Invalid = 0x0 Delay conter = 0
[ 1105.204912] Module =  4       (SCPOS_PLA_EN) Invalid = 0x0 Delay conter = -1
[ 1105.212287] Module =  5         (SCPOS_DRAM) Invalid = 0x0 Delay conter = 0
[ 1105.218594] Module =  6      (SCPOS_PATTERN) Invalid = 0x0 Delay conter = 0
[ 1105.225387] Module =  7         (SCPOS_FIFO) Invalid = 0x0 Delay conter = 0
[ 1105.232521] Module =  8    (SCPOS_DISP_TUNE) Invalid = 0x0 Delay conter = 0
[ 1105.239082] Module =  9     (SCPOS_PRE_DOWN) Invalid = 0x0 Delay conter = 0
[ 1105.245827] Module = 10              (REGEN) Invalid = 0x0 Delay conter = 0
[ 1105.252882] Module = 11         (SCPOS_MISC) Invalid = 0x0 Delay conter = 0
[ 1105.259408] Module = 12           (SCPOS_WA) Invalid = 0x0 Delay conter = 0
[ 1105.266201] Module = 13         (SCPOS_TV3D) Invalid = 0x0 Delay conter = 0
[ 1105.273087] Module = 14   (MODECHG: DECODER) Invalid = 0x0 Delay conter = -1
[ 1105.280282] Module = 15                (SRM) Invalid = 0x0 Delay conter = 0
[ 1105.287080] Module = 16                (DTV) Invalid = 0x0 Delay conter = 0
[ 1105.294117] Module = 17                (B2R) Invalid = 0x0 Delay conter = 0
[ 1105.300557] Module = 18               (HDMI) Invalid = 0x0 Delay conter = 0
[ 1105.307418] Module = 19        (MEMORY_TEST) Invalid = 0x0 Delay conter = 0
[ 1105.314332] Module = 20            (PPCLOCK) Invalid = 0x0 Delay conter = 0
[ 1105.321057] Module = 21                 (NR) Invalid = 0x0 Delay conter = 0
[ 1105.328249] Module = 22     (AutoSearch: SI) Invalid = 0x0 Delay conter = 0
[ 1105.334752] Module = 23        (MW_DISP_FMT) Invalid = 0x0 Delay conter = -1
[ 1105.341951] Module = 24                (MJC) Invalid = 0x0 Delay conter = 0
[ 1105.348766] Module = 25                (TDC) Invalid = 0x0 Delay conter = 0
[ 1105.355425] Module = 26                (FRC) Invalid = 0x0 Delay conter = 0
[ 1105.362081] ===============================================================
[ 1105.368888] Invalid Mask:
[ 1105.371452] 0x1: No signal Snow Scr
[ 1105.374895] 0x2: ATV Freeze chan chg
[ 1105.378493] 0x4: ATV Auto search
[ 1105.381573] 0x8: All Unmute


EOF

