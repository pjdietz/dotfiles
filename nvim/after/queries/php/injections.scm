;; extends
(
  (heredoc_start) @_start
  (heredoc_body) @sql

  (#match? @_start "SQL|QUERY")
 )
