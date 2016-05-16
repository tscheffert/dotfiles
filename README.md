dotfiles
========

TScheffe's take on .dotfiles

## Installation ###
*Note, this is for me to remember as much as for others to follow!*

### To Start ####
````shell
cd ~

git clone https://github.com/tscheffe/dotfiles.git .dotfiles
```

### For OSX ####
```shell
bash bootstrap/osx_bootstrap.sh
```

### For Windows ####
```shell
bootstrap/bootstrap.bat

git submodule update --recursive --init
```

#### Potential Line Ending Issues ####
Run:

```shell
(git rm --cached -r . && git reset --hard &&  git pull origin master)

(git submodule update --init)

git submodule foreach "(git rm --cached -r . && git reset --hard && git pull origin master)"
```


### Install Python dependencies
```shell
pip install -r requirements.txt
```
