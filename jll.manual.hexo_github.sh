#!/bin/bash
#Copyright(c) 2018-2100.  jielong.lin@qq.com.  All rights reserved.
#
#


more >&1<<EOF
######################################
  Setup Hexo system on local machine
######################################

(1) Install git
####################
apt-get install git-core


(2) Install Node.js
####################

(2-1) Setup nvm environment
      ~/.nvm is downloaded and NVM environment variable is set BY the follows:
--------------------------------------------------------------------------------
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
       OR
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

       Topology for NVM
       -------------------
        /root/.nvm
        ├── alias
        │   ├── default
        │   └── lts
        ├── bash_completion
        ├── CONTRIBUTING.md
        ├── install.sh
        ├── LICENSE.md
        ├── Makefile
        ├── nvm-exec
        ├── nvm.sh
        ├── package.json
        ├── README.md
        ├── ROADMAP.md
        ├── test
        │   ├── common.sh
        │   ├── fast
        │   ├── installation_iojs
        │   ├── installation_node
        │   ├── install_script
        │   ├── mocks
        │   ├── slow
        │   └── sourcing
        ├── update_test_mocks.sh
        └── versions
            └── node
        
        Set NVM related information To PATH system environment by appending the follows to ~/.bashrc
        ---------------------------------------------------------------------------------------------
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion




EOF
