
# Sources

# Influences

- <https://github.com/chef/chef/blob/master/lib/chef/mixin/shell_out.rb>
- <https://github.com/chef/mixlib-cli>
- <https://github.com/chef/mixlib-log>
- <https://github.com/chef/mixlib-shellout>
- <https://github.com/piotrmurach/tty>
- [Optimist, formerly trollop](https://github.com/ManageIQ/optimist)
- <https://github.com/slackhq/magic-cli>
- <https://slackengineering/the-joy-of-internal-tools-4a1bb5fe905b>

## Read Up On These

- <https://github.com/leejarvis/slop>
- <https://github.com/ahoward/main>
- <http://whatisthor.com/>
- <https://github.com/svenfuchs/cl>
- <https://github.com/gettalong/cmdparse>
- <https://github.com/davetron5000/methadone>
- <http://davetron5000.github.io/gli/>
- <https://github.com/jeg2/highline>
- <https://github.com/manageiq/optimist>
- <https://github.com/thoughtbot/terrapin>
- <https://github.com/chef/mixlib-cli>



### Close, Good example

- <https://github.com/mdub/clamp>
  - Similar command modeling, slightly different syntax
- <https://github.com/commander-rb/commander>
  - Some of the variants are SUPER close, but there is a LOT going on here.
- Soooo close: <https://dry-rb.org/gems/dry-cli/0.6/>
  - Probably copy a bunch of implementation from this if it's stand alone
  - The "registry" concept is great
  - Do like options, don't like arguments

### Not Quite

- <https://github.com/ddfreyne/cri>
  - Too much, too opinionated. Not pluggable

# Style

## Slack `magic-cli` forks:

<https://github.com/slackhq/magic-cli/compare/master...yothinko:master>

## Usage Banner

<https://developers.google.com/style/code-syntax>

<https://github.com/skorks/escort#required-arguments>

## CLI Documentation Syntax

### Examples

- <https://www.npmjs.com/package/command-line-usage>

### Microsoft Command-Line Syntax Key

From: <https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc771080(v=ws.11)>

- Text without brackets or braces
  Items you must type as shown

- \<Text inside angle brackets\>
  Placeholder for which you must supply a value

- \[Text inside square brackets\]
  Optional items

- \{Text inside braces\}
  Set of required items; choose one

- Vertical bar (|)
  Separator for mutually exclusive items; choose one

- Ellipsis (...)
  Items that can be repeated
