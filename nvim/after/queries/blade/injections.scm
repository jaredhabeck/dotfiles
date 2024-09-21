((text) @injection.content
    (#not-has-ancestor? @injection.content "envoy")
    (#set! injection.combined)
    (#set! injection.language php))
((parameter) @injection.content
    (#set! injection.language "php")) ; TODO: php_only
((php_only) @injection.content
    (#set! injection.language "php")) ; TODO: php_only
