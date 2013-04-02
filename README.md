# java_regex

A gem for converting Java-style regular expressions to Ruby ones.

## Overview

With Java's `String.match()` a regex has to match the entire string to be a match. In ruby, you have to explicitly use `\A` and `\z` if you want only matches for the whole string. 
    
The `JavaRegex` class automatically adds those characters to every Java string that it converts. Also, it will attempt to convert Java regex conventions to the Ruby equivalent where possible, and throw an exception where a feature does not exist in Ruby. It's still very much a work in progress.

## Installation

    $ gem install java_regex

## Example Usage

    > require java_regex
    => true
    > jre = JavaRegex.new('.*some_regex_\p{Digit}')
    => #<JavaRegex:0x007fea73075ea8 @regex=".*some_regex_\\p{Digit}">
    puts jre.to_ruby()
    \A.*some_regex_[[:digit:]]\z
    => nil
    > re = jre.to_ruby_regex()
    => /\A.*some_regex_[[:digit:]]\z/
    > 'some_regex_1'.scan(re)
    => ["some_regex_1"]
    
## Supported Features

The regex feature differences between Java and Ruby were obtained from the comparison charts at [Regular-Expressions.info].

### Characters
*   `\Q`...`\E` escapes a string of metacharacters

    `Java Support` Java 6
    
    `Ruby Support` No
    
    `Result if Found` Throws an exception.
    
*    `\cA` through `\cZ` (control character)

    `Java Support` Yes
    
    `Ruby Support` No
    
    `Result if Found` Throws an exception.

### Character Classes of Character Sets [abc]

*   Hyphen in `[\d-z]` is a literal

    `Java Support` Yes
    
    `Ruby Support` No
    
    `Result if Found` Escapes the hyphen: `[\d-z]` -> `[\d\-z]`

### Word Boundaries

*   `\b` (at the beginning or end of a word)

    `Java Support` Yes
    
    `Ruby Support` Ascii only
    
    `Result if Found` Throws an exception if followed by a non-ascii character.

*   `\B` (NOT the beginning or end of a word)

    `Java Support` Yes
    
    `Ruby Support` Ascii only
    
    `Result if Found` Throws an exception if followed by a non-ascii character.

### Grouping and Backreferences

*   Backreferences non-existent groups are an error

    `Java Support` Yes
    
    `Ruby Support` No
    
    `Result if Found` Throws an exception.

### Modifiers

*   `(?s)` (dot matches newlines)

    `Java Support` Yes
    
    `Ruby Support` `(?m)`
    
    `Result if Found` Throws an exception if a newline character is found.

*   `(?m)` (`^` and `$` match at line breaks)

    `Java Support` Yes
    
    `Ruby Support` Always on
    
    `Result if Found` Handling not implemented.

### Atomic Grouping and Possessive Quantifiers

*   `?+`, `*+`, `++` and `{m, n}+` (possessive quantifiers)

    `Java Support` Yes
    
    `Ruby Support` No
    
    `Result if Found` Handling not implemented.

### Lookaround

*   `(?<=text)` (positive lookbehind)

    `Java Support` Finite Length
    
    `Ruby Support` No
    
    `Result if Found` Handling not implemented.

*   `(?<!text)` (negative lookbehind)

    `Java Support` Finite Length
    
    `Ruby Support` No
    
    `Result if Found` Handling not implemented.

### Unicode Characters

*   `\u0000` through `\uFFFF` (Unicode character)

    `Java Support` Yes
    
    `Ruby Support` No
    
    `Result if Found` Converted to 0x0000 format.

### Unicode Properties, Scripts and Blocks

*   `\pL` through `\pC` (Unicode properties)

    `Java Support` Yes
    
    `Ruby Support` No
    
    `Result if Found` Handling not implemented.

*   `\p{L}` through `\p{C}` (Unicode properties)

    `Java Support` Yes
    
    `Ruby Support` No
    
    `Result if Found` Handling not implemented.

*   `\p{Lu}` through `\p{Cn}` (Unicode property)

    `Java Support` Yes
    
    `Ruby Support` No
    
    `Result if Found` Handling not implemented.

*   `\p{IsL}` through `\p{IsC}` (Unicode properties)

    `Java Support` Yes
    
    `Ruby Support` No
    
    `Result if Found` Handling not implemented.

*   `\p{IsLu}` through `\p{IsCn}` (Unicode property)

    `Java Support` Yes
    
    `Ruby Support` No
    
    `Result if Found` Handling not implemented.

*   `\p{IsBasicLatin}` through `\p{InSpecials}` (Unicode block)

    `Java Support` Yes
    
    `Ruby Support` No
    
    `Result if Found` Handling not implemented.

*   Spaces, hyphens, and underscores allowed in all long names listed above (e.g. `BasicLatin` can be written as `Basic-Latin` or `Basic_Latin` or `Basic Latin`)

    `Java Support` Yes
    
    `Ruby Support` No
    
    `Result if Found` Handling not implemented.

*   `\P` (negated variants of all `\p` as listed above)

    `Java Support` Yes
    
    `Ruby Support` No
    
    `Result if Found` Handling not implemented.

### POSIX Bracket Expressions

*   `\p{Alpha}` POSIX character class

    `Java Support` Ascii
    
    `Ruby Support` No
    
    `Result if Found` Converted to `[:alpha:]` POSIX character class.

## Copyright

Copyright (c) 2013 Dean Morin. See [LICENSE] for details.

[Regular-Expressions.info]: http://www.regular-expressions.info/refflavors.html
[LICENSE]: https://github.com/deanmorin/java_regex/blob/master/LICENSE
