#! /bin/bash

# enable vi-mode in IRB
echo "bind -v" >> ~/.editrc

# enable vi-mode in Bash and any other tool that uses GNU Readline
# (see [Vi mode in Bash](http://blog.sanctum.geek.nz/vi-mode-in-bash/))
echo "set editing-mode vi" >> ~/.inputrc

# enable vi-mode in Bash only (commented out because I already have it in my .bashrc)
# echo "set -o vi" >> ~/.bashrc

