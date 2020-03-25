#!/usr/bin/env bash

function build_vim {

  # Install Universal Dependencies:
  yum install \
    gcc \
    make \
    ncurses \
    ncurses-devel

  # Install Language Dependencies:
  yum install -y \
    ctags \
    git \
    lua \
    lua-devel \
    luajit \
    luajit-devel \
    perl \
    perl-ExtUtils-CBuilder \
    perl-ExtUtils-Embed \
    perl-ExtUtils-ParseXS \
    perl-ExtUtils-XSpp \
    perl-devel \
    python \
    python-devel \
    python3 \
    python3-devel \
    ruby \
    ruby-devel \
    tcl-devel \

  # TODO: Investigate
  # - +acl
  # - +iconv
  # - +iconv/dyn
  # How do I enable clipboard?
  #
  ./configure \
    --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp \
    --enable-pythoninterp
    # --enable-perlinterp
    # --enable-python3interp \
    # --enable-luainterp
}

build_vim "$@"

# No package luajit available.
# No package luajit-devel available.
# Package python-2.7.5-86.el7.x86_64 already installed and latest vers
# ion
# No package perl-ExtUtils-XSpp available.
