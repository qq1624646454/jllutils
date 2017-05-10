#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.AndrBook.RunCommands.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2016-11-17 15:35:39
#   ModifiedTime: 2016-11-17 15:37:43

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1 <<EOF

// Write to generate shell file successfully, but run failure. Maybe permission is not allowwed. 
    public static void runCommand()
    {
        final String sLogcatStoredPath="/storage/5663-FC0E";
        new Thread(new Runnable()
        {
            public void run()
            {
                FileOutputStream  fosShell = null;
                File              flShell = null;
                try {
                    flShell = new File("/data/logcat_by_jll.sh");
                    if (!flShell.exists()) {
                        flShell.createNewFile();
                        flShell.setExecutable(true);
                        Log.d(TAG, "Create Shell File=/data/logcat_by_jll.sh");
                        fosShell = new FileOutputStream(flShell, true);
                        fosShell.write(
                            String.format(
                                "#!/system/bin/sh\n"
                                +"echo \"logcat_by_jll.sh\"\n"
                                +"if [ ! -e \"%s\" ]; then\n"
                                +"    echo \"Exit 0 - Not exist Path=%s\"\n"
                                +"    exit 0\n"
                                +"fi\n"
                                +"cd %s\n"
                                +"/system/bin/rm -f msaf_R*.log\n"
                                +"/system/bin/logcat -v time | /system/bin/grep -i JLL "
                                +"| /system/bin/tee msaf_R$(date +%%Y_%%m_%%d_%%H_%%M).log;\n",
                                sLogcatStoredPath, sLogcatStoredPath, sLogcatStoredPath
                            ).getBytes()
                        );
                        fosShell.flush();
                        fosShell.close();
                    }
                    if (flShell.exists() && flShell.canExecute()) {
                        java.lang.Process pContext = java.lang.Runtime.getRuntime().exec("su");
                        pContext.waitFor();
                        java.io.DataOutputStream dosStream = new java.io.DataOutputStream(
                                                                 pContext.getOutputStream()
                                                             );
                        dosStream.writeBytes("/data/logcat_by_jll.sh\n");
                        dosStream.writeBytes("echo \"JLL-Shell: hello\"\n");
                        dosStream.flush();
                        Log.d(TAG, "Done for run /data/logcat_by_jll.sh");
                    } else {
                        Log.d(TAG, "Failed to run /data/logcat_by_jll.sh");
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                    return;
                } catch (InterruptedException ie) {
                    ie.printStackTrace();
                    return;
                }
            }
        }).start();
    }



EOF

