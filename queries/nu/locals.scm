; Scopes

(function_definition @scope)
(block @scope)
(record_or_block @scope)

; Definitions
(variable_declaration name: (identifier) @definition.var)
(parameter (identifier) @definition.var)
(flag (flag_name) @definition.var)
(flag (flag_shorthand_name) @definition.var)
(record_entry entry_name: (identifier) @definition.var)
(block_args block_param: (identifier) @definition.var)

(function_definition
  func_name: (identifier) @definition.function)


; References
[
    (value_path)
] @reference
