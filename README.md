This script attempts to translate LaTeX math markup to a human-readable form 
that uses Unicode characters wherever possible.

This was inspired by a [similar project by ypsu][1].

[1]: https://github.com/ypsu/latex-to-unicode

TODO
----

* Improve the handling of whitespace.
* Support \text.
* Improve parenthesization of \sqrt and \frac.
  - Start by not parenthesizing atoms with \sqrt.
