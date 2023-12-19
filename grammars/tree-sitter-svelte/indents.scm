
((start_tag "<" @indent) @__IGNORE__
  ; Only indent if this isn't a self-closing tag.
  (#not-match? @__IGNORE__ "^<(?:area|base|br|col|embed|hr|img|input|keygen|link|meta|param|source|track|wbr)\\s"))


; `end_tag` will still match when only `</div` is present. Without enforcing
; the presence of `>`, the dedent happens too soon.
((end_tag) @dedent
  (#match? @dedent ">$"))


[
  (if_start_expr)
  (each_start_expr)
  (await_start_expr)
  (key_start_expr)
  (else_if_expr)
  (else_expr)
] @indent


[
  (if_end_expr)
  (each_end_expr)
  (await_end_expr)
  (key_end_expr)
  (else_if_expr)
  (else_expr)
] @dedent
