# Bash Style Guide

## References

- [Google Bash Style Guide](https://google.github.io/styleguide/shellguide.html)
- [Wooledge BashGuide](http://mywiki.wooledge.org/BashGuide)
- Lots and lots of Stack Overflow and Server Fault research

## Guide

### Functions

Prefer the `foo() { ... }` function definition format.

```bash
# Right - POSIX compliant, more portable.
foo() { ... }

# Wrong - Allows functions to shadow aliases, but that should be avoided anyways
function foo { ... }

# Very Wrong - Only works incidentally as an amalgamation between the other two.
function foo() { ... }
```

Supporting Stack Overflow answer: <https://stackoverflow.com/a/22238259/2675529>
