# Vanilla `irb` Issue:

```
>>> which irb
/mingw64/bin/irb
```

Initial problem with Enter
```
irb(main):001:0> Thing # Press Enter
T                      # Hangs here with the first letter of the previous line showing
```

After pressing Enter again:
```
irb(main):001:0> Thing
Thing
NameError: uninitialized constant Thing
        from (irb):1
        from C:/git-sdk-64/mingw64/bin/irb:11:in `<main>'
irb(main):002:0>
irb(main):003:0*
```

# Vanilla Pry issue:

```
>>> which pry
/mingw64/bin/pry
```

Eats the line above it, double lines when odd numbered?
```
[1] chef-repo(main)> book_generator) >>> pry
[1] chef-repo(main)>
[2] chef-repo(main)>
[3] chef-repo(main)>
[3] chef-repo(main)>
[4] chef-repo(main)>
[5] chef-repo(main)>
[5] chef-repo(main)>
[6] chef-repo(main)>
```

# Chef Exec IRB

Seems to work!
```
>>> which chef
/c/opscode/chefdk/bin/chef
>>> chef exec irb
irb(main):001:0> Thing
NameError: uninitialized constant Thing
        from (irb):1
        from C:/opscode/chefdk/embedded/bin/irb.cmd:19:in `<main>'
irb(main):002:0>
irb(main):003:0> "thing".length
=> 5
```

# Chef Exec PRY

Eats the line above it still
```
[1] chef-repo(main)> o](cookbook_generator) >>> chef exec pry
```

Double outputs the last letter, but still works somehow?
NOTE: This is not consistent, can't always reproduce it
```
...
[3] pry(main)> "thing".lengthh
=> 5
```

# Potential Problems:
- ConEmu
- .irbrc
- .pryrc
- `console_config.rb`
- Git64SDK vs Chef Exec embedded
