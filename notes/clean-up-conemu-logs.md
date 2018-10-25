## Removal Commands:

Vim Regex help:
- http://vimregex.com/
- https://vi.stackexchange.com/a/3118/9963
```
%s#zsh.exe: SetConsoleCursorPosition(0,.\{1,5})"##g

%s#zsh.exe: SetConsoleTextAttribute(.\{-})".\{-}9;11##g

%s#zsh.exe: SetConsoleCursorPosition(.\{-})".\{-}9;11##g

%s#[a-zA-Z]\{-}.exe: SetConsoleCursorPosition(.\{-})".\{-}9;11##g
%s#[a-zA-Z]\{-}.exe: SetConsoleTextAttribute(.\{-})".\{-}9;11##g

%s#.\{-}\]9;11;";"[a-zA-Z]\{-}.exe: SetConsoleTextAttribute(.\{-})".\{-}##g

%s#.\]9;11\(;"\)\{1,4}[a-zA-Z]\{-}.exe: SetConsoleTextAttribute(.\{-})".\{-}##

%s#\\\n##g
```
