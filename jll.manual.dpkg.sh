#!/bin/bash

more >&1<<EOF


dpkg status database is locked by another process
--------------------------------------------------
 rm /var/lib/dpkg/lock
 dpkg --configure -a



EOF

