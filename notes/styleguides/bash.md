# Bash Style Guide

## References

- [Google Bash Style Guide](https://google.github.io/styleguide/shellguide.html)
- [Wooledge BashGuide](http://mywiki.wooledge.org/BashGuide)
- Lots and lots of Stack Overflow and Server Fault research

## Guide

### Functions

Prefer the `foo() { ... }` function definition format.

Examples:

```bash
# Right - POSIX compliant, more portable.
foo() { ... }

# Wrong - Allows functions to shadow aliases, but that should be avoided anyways
function foo { ... }

# Very Wrong - Only works incidentally as an amalgamation between the other two.
function foo() { ... }
```

Supporting Stack Overflow answer: <https://stackoverflow.com/a/22238259/2675529>

### Variable Validation with Parameter Expansion

Prefer `${<digit>:?<message>}` to `${<digit>?<message>}`.

Examples:

```bash
# Right - Validates that $2 is not null or empty
source_path="${2:?Must provide a source path}"

# Wrong - Only validates that $2 is not null
source_path="${2?Must provide a source path}"
```

### Sourcing Dependencies

Supporting Evidence: <https://stackoverflow.com/a/67571462>

#### Prefer `source` to `.`

Rule: Prefer `source` to `.`.

Reason:

They're the same thing, but `source` is much harder to miss and it actually suggests what it does.
With `.` you have to see it and remember that it sources the file.

Examples:

```bash
# Right
source "$library/my/dependency.sh"

# Wrong
. "$library/my/dependency.sh"
```

#### Provide absolute paths when sourcing dependencies

Rule: Provide absolute paths when sourcing dependencies

Reason:

The behavior of `source` is _interesting_.
When the sourced file is not a full path it will search the `$PATH`.
If it can't find it there, it will search the current directory.
To avoid unexpected behavior, just pass an absolute path

Examples:

```bash
# Right
source "$(realpath ./lib/helpers.sh)"

# Also Right, when in a git repo
repo_root="$(git -C "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" rev-parse --show-toplevel)"
dependency="$repo_root/tools/lib/helpers.sh"

# Wrong
source "lib/helpers.sh"
```

#### Check the return code of the sourced dependencies and fail the script

Rule:

Check the return code of the sourced dependencies and fail the script if you cannot successfully source the dependency.

Reason:

If you have a dependency, you want the script to fail when it tries to load the dependency.
Avoid continuing as it will still fail later in the script, when the dependency is used.
This unnecessary indirection is confusing and can hide the actual source of the issue.

```bash
# Right
set -e
...
source "$path_to_file" # Will fail with non-zero exit code and a relevant message

# Also Right, if you don't have `set -e` or want better messaging
dependency="$repo_root/tools/lib/helpers-bad.sh"
if ! source "$dependency" >/dev/null 2>&1; then
  printf "Failed to load dependency file:\n  %s\n" "$dependency" 1>&2
  exit 1
fi
```
