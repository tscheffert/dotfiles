# Notes on the Rugged Gem for Ruby

## Notes

## Surprises

### Rugged::Index is the Git Index, README is misleading

Docs: <https://github.com/libgit2/rugged#index-staging-area>>

Based on the README, I thought the `Rugged::Index` would be the "staging area" but it's actually the entire working tree.
AKA The actual "git index".

### Rugged::Repository.status is weird

Docs: <https://www.rubydoc.info/github/libgit2/rugged/Rugged/Repository#status-instance_method>

The block method reads like it will yield each object in the index, but it actually only yields the objects which have an actual status.

When I modified a file in the repo, the example of:

```
repo.status { |file, status_data| puts "#{file} has status: #{status_data.inspect}" }
```

Only printed the file that was modified, not every file in the repo as expected.

### Rugged::Repository.status is still weird

To convert it to an array you must do this:

```
rugged_repo.enum_for(:status).to_a
```

Which uses `Object#enum_for`: <https://ruby-doc.org/core-2.7.4/Object.html#method-i-enum_for>
