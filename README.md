dotfiles
========

TScheffe's take on .dotfiles

### Installation ###
*Note, this is for me to remember as much as for others to follow!*

#### To Start ####
````
cd ~

git clone https://github.com/tscheffe/dotfiles.git .dotfiles
````

#### For OSX ####
````
bash bootstrap/osx_bootstrap.sh
````

#### For Windows ####
````
bootstrap/bootstrap.bat

git submodule update --recursive --init
````

#### Potential Line Ending Issues ####
Run:

````
(git rm --cached -r . && git reset --hard &&  git pull origin master)

(git submodule update --init)

git submodule foreach "(git rm --cached -r . && git reset --hard && git pull origin master)"
````
