# Timestamps

## ISO 8601 and RFC 3339

<https://en.wikipedia.org/wiki/ISO_8601>

<https://tools.ietf.org/html/rfc3339>

ISO8601 is the orignal date time format standard, but it leaves a lot of things
ambiguous. RFC3339 aims to address that ambiguity and suggests a more explicit
format.

Use RFC3339 when possible.

## Date format string

```
%Y-%m-%dT%H:%M:%S.%3N%:z
```

## Ruby

```ruby
require 'date'
DateTime.now.rfc3339(3) # where 3 is the number of fractional seconds
```
