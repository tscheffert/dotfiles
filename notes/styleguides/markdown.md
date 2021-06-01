# Markdown Style Guide

## Pages to Review

<https://google.github.io/styleguide/docguide/style.html>
<https://loopback.io/doc/en/contrib/Markdown-style-guide.html>
<https://cirosantilli.com/markdown-style-guide/>


### Use Semantic Linefeeds aka Semantic linewrapping

TLDR:

Break up lines in Markdown paragraphs after a complete "thought fragment".
This could be after the sentence is complete,
after a semi-colon or comma,
or simply between wherever one thought is finished and another begins.

This optimizes for A) version control systems and B) raw markdown review.
Git loves this technique;
it shows it by capturing your process as clearly and concisely as possible.
This in turn allows any reviewers to review each line and provide feedback with context.
No more of the "For the line starting with 'foo' and ending with 'bar', here is my feedback" style review.

The alternatives are "insert linefeed around arbitrary column length, such as 80"
or "put every paragraph on one line and let your editor do soft linewrapping".
While both of these work, the only realizable benefit to either of them is consistency.
In that when reviewing the raw markdown will be formatted in the way that you expect and find to the norm,
even if it's not the format you prefer.
This provides a calming effect which reduces friction just like `gofmt` does for Golang code.

Semantic linefeeds can still provide consistency,
though maybe with more slightly more deviation as everyone structures their thoughts differently.
The lack of a hard "80 characters or less" style rule require a little additional thought when authoring,
but the version control system and raw markdown reviewing benefits should outweigh that cost.
Additionally, it should become easier and easier with practice;
change is friction but is usually worth it.

It has no effect on how the text is rendered due to markdown paragraph formatting requiring blank lines between paragraphs.
Though I have noticed myself adding "debatable" commas or semi-colons in order to fight the imaginary "run on line" that goes past 80 characters.

Other than taking some time to get used to, there doesn't seem to be any actual downsides.
Even if you don't necessarily agree with or benefit from it,
your teammates and co-authors will appreciate you for it.


Sources:
- Great overview of the technique: <https://scott.mn/2014/02/21/semantic_linewrapping/>
- More discussion on the topic here: <https://rhodesmill.org/brandon/2012/one-sentence-per-line/>
