[
  (directive)
  (directive_start)
  (directive_end)
] @keyword

([
  (bracket_start)
  (bracket_end)
] @punctuation.special (#set! "priority" 110))

(comment) @comment @spell
((parameter) @include (#set! "priority" 110))
((php_only) @include (#set! "priority" 110))
