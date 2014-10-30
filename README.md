dotfiles
========

TScheffe's take on .dotfiles

### Installation ###
*Note, this is for me to remember as much as for others to follow!*

#### To Start ####
'
cd ~
git clone https://github.com/tscheffe/dotfiles.git .dotfiles
cd .dotfiles
git init
'

#### For Windows ####
'
bootstrap/bootstrap.bat
git submodule update --recursive --init
'

#### For OSX ####
'bash bootstrap/osx_bootstrap.sh'

#### Potential Line Ending Issues ####
Run:
'(git rm --cached -r . && git reset --hard &&  git pull origin master)'
followed by:
'(git submodule update --init)'
then:
'git submodule foreach "(git rm --cached -r . && git reset --hard && git pull origin master)"'
