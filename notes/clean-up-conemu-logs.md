# Clean Up ConEmu Logs

## Removal Commands:

Vim Regex help:

- <http://vimregex.com/>
- <https://vi.stackexchange.com/a/3118/9963>

Use These:

```
%s#.\]9;11\(;"\)\{1,}[a-zA-Z]\{-}.exe: SetConsoleTextAttribute(.\{-})"\\##g
%s#\]9;11;"[a-zA-Z]\{-}.exe: SetConsoleCursorPosition(.\{-})"\\##g
```

Have used these:

```
%s#zsh.exe: SetConsoleCursorPosition(0,.\{1,5})"##g
%s#zsh.exe: SetConsoleTextAttribute(.\{-})".\{-}9;11;##g
%s#zsh.exe: SetConsoleCursorPosition(.\{-})".\{-}9;11;##g

%s#[a-zA-Z]\{-}.exe: SetConsoleCursorPosition(.\{-})".\{-}9;11;##g
%s#[a-zA-Z]\{-}.exe: SetConsoleTextAttribute(.\{-})".\{-}9;11;##g

%s#\]9;11;";"\{1,8}less.exe: SetConsoleTextAttribute(0x07)"\\##g

%s#^$\n##g

%s#\\\n##g
```

### Working on Vim:

This:

```
%s#\]9;11;"vim.exe: ExtSetAttributes(0x[0-9a-zA-Z]\{2})"\\##g
```

Left this:

```
[38;2;88;89;96m[48;2;21;21;21m  6 |7m[38;2;211;232;232m[48;2;21;21;21m[38;2;191;151;129mpick|7m[38;2;211;232;232m[48;2;21;21;21m [38;2;238;182;198m42ba531d|7m[38;2;211;232;232m[48;2;21;21;21m[38;2;106;173;153m Generator: Fill files from Deadbolt for starting|7m[38;2;211;232;232m[48;2;21;21;21m[17C[48;2;0;0;0m |7m[38;2;211;232;232m[48;2;21;21;21m
```

```
%s#\[[0-9]\{1,3};[0-9]\{1,3};[0-9]\{1,3};[0-9]\{1,3};[0-9]\{1,3}m##g
```

```
22 |7mpick|7m bdb98528|7m Generator: Load cookbook contexts from ruby files|7m[16C |7m
```
