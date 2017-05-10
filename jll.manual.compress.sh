#!/bin/bash
# Copyright (c) 2016 - 2100.   jielong.lin    All rights reserved.

more >&1 << EOF

#####
#####  ZIP or UNZIP
#####

# Compress the specified file or folder to ZIP
zip -r9 YourFile.zip  YourFileOrFolder YourFileOrFolder2 ...

# Compress the specified file or folder to ZIP with encrypt
zip -r9 YourFile.zip  YourFileOrFolder -e

# Check if ZIP is OK
unzip -vt YourFile.zip

# Extract ZIP
unzip YourFile.zip -d YourPath



#####
##### Tar 
#####

# List file from compress file
tar -tvf YourFile.tar
tar -tzvf YourFile.tar.gz
tar -tjvf YourFile.tar.bz2

# Compress the specified file or folder to tar.gz file or tgz file 
tar -zvcf YourFile.tar.gz  YourFileOrFolder YourFileOrFolder2 ...

# Decompress tar.gz or tgz file  
tar -zvxf YourFile.tar.gz -C ./


# Compress the specified file or folder to tar.bz2 file 
tar -jvcf YourFile.tar.bz2  YourFileOrFolder YourFileOrFolder2 ...

# Decompress tar.bz2 file  
tar -jvxf YourFile.tar.bz2 -C ./



#####
#####  7z 
#####

# Decompress 7z [note: the space doest not exist between -o and <output_dir>]
7zr x -r  YourFile.7z -o<output_dir>

# Compress the specified file or folder to 7z file
7zr a -t7z -r YourFile.7z YourFileOrFolder YourFileOrFolder2 ... 

# List the files from 7z
7zr l YourFile.7z | less


#####
#####  xz 
#####

# Decompress xz 
xz -d ***.tar.xz



EOF


