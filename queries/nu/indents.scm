; copied from tree-sitter-nu/queries/nu/indents.scm at 7e0f16f608a9e804fae61430ade734f9f849fb80

[
  (expr_parenthesized)
  (parameter_bracks)
  (ctrl_match)

  (val_record)
  (val_list)
  (val_closure)
  (val_table)

  (block)
] @indent.begin

[
  "}"
  "]"
  ")"
] @indent.end

[
  "}"
  "]"
  ")"
] @indent.branch

(comment) @indent.auto
