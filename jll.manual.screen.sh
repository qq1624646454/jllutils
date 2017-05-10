#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

# New Session
screen -S <NewSessionName>

# List All Sessions
screen -ls <DetachedSession>

# Login the specfied Session
screen -x <DetachedSession> 
screen -r <DetachedSession>

# Remove dead screens:
screen -wipe <SessionName> 

# Exit or terminate the specfied Session
1.Login the session: screen -x <SessionName>
2.Enter the command: exit
3.Detach the session: Ctrl_a_z

EOF


