# zsh Notes

## zstyle

Source: <http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Overview-2>


### Background on Contexts

To determine completion, zsh uses the concept of a 'context'. When completion is
attempted the completion system begins building the context. Context starts generic
like "starting completion" and ends specific like "the current word might be a
variable name".

Context information is condensed into a string of multiple fields separated by
colons. Most often users will compose a _style_ pattern rather than a new _context_
string. Style patterns are matched against a context when needed to look up
context-sensitive options that configure the completion systems.

### Context Composition

Context strings always consist of a fixed set of fields, separated by colons and
with a leading colon. Unknown fields can be left empty, but the colons must still
appear.

Fields are always in the order of `:completion:function:completer:command:argument:tag`.

These mean:

- `completion`: The literal string `completion` indicating that this style is used
  by the completion system. Other systems use `zstyle` as well.
- `function`: Typically left blank but is sometimes set by special "system" widgets
  such as `predict-on` and the functions in the `Widgets` directory.
- `completer`: The currently active _completer_, meaning the name of the function
  without the leading underscore and with other underscores converted to hyphens
- `command`: The command or a special -context-, just at it appears following the
  `#compdef` tag or the _compdef_ function. Completion functions for commands that
  have sub-commands usually modify this field to contain the name of the command
  followed by a minus sign and the sub-command.
- `argument`: This indicates which command line or option argument we are completing.
  For command arguments this generally takes the form _argument-n_, where _n_ is
  the number of the argument, and for arguments to options the form _option-opt-n_
  where _n_ is the number of the argument to option opt. This is only set when the
  command line is parsed with standard UNIX-style options and arguments, not often.
- `tag`: used to discriminate between the types of matches a completion function
  can generate in a certain context. Any function can use any tag, but there are
  more common ones. Common tags [described here](http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Standard-Tags).

Putting it all together, the context name:

```
:completion::complete:dvips:option-o-1:files
```

says that normal completion was attempted as the first argument to the option `-o`
of the command `dvips`:

```
dvips -o ...
```

and the completion function will generate filenames.

Contexts are applied from the most specific to the least specific. Meaning that
`zstyle ':completion:*' verbose yes` makes every completion verbose, unless a more
specific context sets the value of `verbose` to `no`.

More precisely, strings are preferred over patterns (for example, `:completion::complete:::foo`
is more specific than `:completion::complete:::*`), and longer patterns are preferred
over shorter patterns.

A good rule of thumb is that any completion style pattern that needs to include
more than one wildcard (`*`) and that does not end in a tag name, should include
all six colons (`:`), possibly surrounding additional wildcards.

## Completions

Documentation:

- <http://zsh.sourceforge.net/Doc/Release/Completion-System.html>
- <https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org>
- <http://zsh.surceforge.net/Guide/zshguide06.html#l144>

Good examples of it in practice:

- <https://arcanis.me/en/2014/07/17/writting-own-completions-p1>
- <https://raw.githubusercontent.com/arcan1s/netctl-gui/master/sources/gui/zsh-completions>
- <https://blog.kloetzl.info/how-to-write-a-zsh-completion/>
- <https://github.com/vapniks/zsh-completions/blob/master/src/_rubocop>


