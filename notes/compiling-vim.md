# Steps

```
cd C:/Projects/github/vim
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/mingw64/bin/python/config \ # pay attention here check directory correct
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.5/config \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=/usr/local

make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
```

# Versions

Existing Version:

```
VIM - Vi IMproved 8.0 (2016 Sep 12, compiled Sep 12 2016 22:03:09)
MS-Windows 64-bit console version
Included patches: 1-3
Compiled by appveyor@APPVYR-WIN
Huge version without GUI.  Features included (+) or not (-):
+acl                +ex_extra           -mouseshape         +tag_old_static
+arabic             +extra_search       +multi_byte_ime/dyn -tag_any_white
+autocmd            +farsi              +multi_lang         +tcl/dyn
-balloon_eval       +file_in_path       +mzscheme/dyn       +termguicolors
-browse             +find_in_path       -netbeans_intg      -tgetent
++builtin_terms     +float              +num64              -termresponse
+byte_offset        +folding            +packages           +textobjects
+channel            -footer             +path_extra         +timers
+cindent            +gettext/dyn        +perl/dyn           +title
+clientserver       -hangul_input       +persistent_undo    -toolbar
+clipboard          +iconv/dyn          -postscript         +user_commands
+cmdline_compl      +insert_expand      +printer            +vertsplit
+cmdline_hist       +job                +profile            +virtualedit
+cmdline_info       +jumplist           +python/dyn         +visual
+comments           +keymap             +python3/dyn        +visualextra
+conceal            +lambda             +quickfix           +viminfo
+cryptv             +langmap            +reltime            +vreplace
+cscope             +libcall            +rightleft          +wildignore
+cursorbind         +linebreak          +ruby/dyn           +wildmenu
+cursorshape        +lispindent         +scrollbind         +windows
+dialog_con         +listcmds           +signs              +writebackup
+diff               +localmap           +smartindent        -xfontset
+digraphs           +lua/dyn            +startuptime        -xim
-dnd                +menu               +statusline         -xpm_w32
-ebcdic             +mksession          -sun_workshop       -xterm_save
+emacs_tags         +modify_fname       +syntax
+eval               +mouse              +tag_binary
   system vimrc file: "$VIM\vimrc"
     user vimrc file: "$HOME\_vimrc"
 2nd user vimrc file: "$HOME\vimfiles\vimrc"
 3rd user vimrc file: "$VIM\_vimrc"
      user exrc file: "$HOME\_exrc"
  2nd user exrc file: "$VIM\_exrc"
       defaults file: "$VIMRUNTIME\defaults.vim"
Compilation: cl -c /W3 /nologo  -I. -Iproto -DHAVE_PATHDEF -DWIN32  -DFEAT_CSCOPE  -DFEAT_JOB_CHANNEL
 -DWINVER=0x500 -D_WIN32_WINNT=0x500  /Fo.\ObjCULYHTRZAMD64/ -DHAVE_STDINT_H /Ox /GL -DNDEBUG  /Zl /MT -DFEAT_MBYTE_IME -DDYNAMIC_IME -DFEAT_MBYTE -DDYNAMIC_ICONV -DDYNAMIC_GETTEXT -DFEAT_TCL -DDYNAMIC_TCL -DDYNAMIC_TCL_DLL=\"tcl86.dll\" -DDYNAMIC_TCL_VER=\"8.6\" -DFEAT_LUA -DDYNAMIC_LUA -DDYNAMIC_LUA_DLL=\"lua53.dll\" -DFEAT_PYTHON -DDYNAMIC_PYTHON -DDYNAMIC_PYTHON_DLL=\"python27.dll\" -DFEAT_PYTHON3 -DDYNAMIC_PYTHON3 -DDYNAMIC_PYTHON3_DLL=\"python35.dll\" -DFEAT_MZSCHEME -I "C:\Program Files\Racket\include" -DMZ_PRECISE_GC -DDYNAMIC_MZSCHEME -DDYNAMIC_MZSCH_DLL=\"libracket3m_a0solc.dll\" -DDYNAMIC_MZGC_DLL=\"libracket3m_a0solc.dll\" -DFEAT_PERL -DPERL_IMPLICIT_CONTEXT -DPERL_IMPLICIT_SYS -DDYNAMIC_PERL -DDYNAMIC_PERL_DLL=\"perl524.dll\" -DFEAT_RUBY -DDYNAMIC_RUBY -DDYNAMIC_RUBY_VER=22 -DDYNAMIC_RUBY_DLL=\"x64-msvcrt-ruby220.dll\" -DFEAT_HUGE /Fd.\ObjCULYHTRZAMD64/ /Zi
Linking: link /RELEASE /nologo /subsystem:console /LTCG:STATUS oldnames.lib kernel32.lib advapi32.lib shell32.lib gdi32.lib  comdlg32.lib ole32.lib uuid.lib /machine:AMD64  /nodefaultlib libcmt.lib  user32.lib  /nodefaultlib:lua53.lib  /STACK:8388608  /nodefaultlib:python27.lib /nodefaultlib:python35.lib   "C:\Tcl\lib\tclstub86.lib" WSock32.lib /PDB:vim.pdb -debug
```
