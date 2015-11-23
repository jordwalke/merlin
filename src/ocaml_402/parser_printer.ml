open Parser_raw

let print_symbol = function
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_error) -> "error"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_WITH) -> "WITH"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_WHILE_LWT) -> "WHILE_LWT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_WHILE) -> "WHILE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_WHEN) -> "WHEN"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_VIRTUAL) -> "VIRTUAL"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_VAL) -> "VAL"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_UNDERSCORE) -> "UNDERSCORE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_UIDENT) -> "UIDENT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_TYPE) -> "TYPE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_TRY_LWT) -> "TRY_LWT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_TRY) -> "TRY"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_TRUE) -> "TRUE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_TO) -> "TO"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_TILDE) -> "TILDE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_THEN) -> "THEN"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_STRUCT) -> "STRUCT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_STRING) -> "STRING"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_STAR) -> "STAR"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_SIG) -> "SIG"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_SHARPSHARP) -> "SHARPSHARP"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_SHARPOP) -> "SHARPOP"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_SHARP) -> "SHARP"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_SEMISEMI) -> "SEMISEMI"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_SEMI) -> "SEMI"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_RPAREN) -> "RPAREN"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_REC) -> "REC"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_RBRACKET) -> "RBRACKET"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_RBRACE) -> "RBRACE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_QUOTE) -> "QUOTE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_QUESTION) -> "QUESTION"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_PRIVATE) -> "PRIVATE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_PREFIXOP) -> "PREFIXOP"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_PLUSEQ) -> "PLUSEQ"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_PLUSDOT) -> "PLUSDOT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_PLUS) -> "PLUS"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_PERCENT) -> "PERCENT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_P4_QUOTATION) -> "P4_QUOTATION"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_OUNIT_TEST_UNIT) -> "OUNIT_TEST_UNIT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_OUNIT_TEST_MODULE) -> "OUNIT_TEST_MODULE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_OUNIT_TEST) -> "OUNIT_TEST"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_OUNIT_BENCH_MODULE) -> "OUNIT_BENCH_MODULE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_OUNIT_BENCH_INDEXED) -> "OUNIT_BENCH_INDEXED"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_OUNIT_BENCH_FUN) -> "OUNIT_BENCH_FUN"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_OUNIT_BENCH) -> "OUNIT_BENCH"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_OR) -> "OR"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_OPTLABEL) -> "OPTLABEL"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_OPEN) -> "OPEN"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_OF) -> "OF"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_OBJECT) -> "OBJECT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_NONREC) -> "NONREC"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_NEW) -> "NEW"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_NATIVEINT) -> "NATIVEINT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_MUTABLE) -> "MUTABLE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_MODULE) -> "MODULE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_MINUSGREATER) -> "MINUSGREATER"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_MINUSDOT) -> "MINUSDOT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_MINUS) -> "MINUS"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_METHOD) -> "METHOD"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_MATCH_LWT) -> "MATCH_LWT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_MATCH) -> "MATCH"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LPAREN) -> "LPAREN"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LIDENT) -> "LIDENT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LET_LWT) -> "LET_LWT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LETOP) -> "LETOP"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LET) -> "LET"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LESSMINUS) -> "LESSMINUS"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LESS) -> "LESS"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETPERCENTPERCENT) -> "LBRACKETPERCENTPERCENT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETPERCENT) -> "LBRACKETPERCENT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETLESS) -> "LBRACKETLESS"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETGREATER) -> "LBRACKETGREATER"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETBAR) -> "LBRACKETBAR"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETATATAT) -> "LBRACKETATATAT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETATAT) -> "LBRACKETATAT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETAT) -> "LBRACKETAT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LBRACKET) -> "LBRACKET"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LBRACELESS) -> "LBRACELESS"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LBRACE) -> "LBRACE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LAZY) -> "LAZY"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_LABEL) -> "LABEL"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_JSNEW) -> "JSNEW"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_INT64) -> "INT64"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_INT32) -> "INT32"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_INT) -> "INT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_INITIALIZER) -> "INITIALIZER"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_INHERIT) -> "INHERIT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_INFIXOP4) -> "INFIXOP4"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_INFIXOP3) -> "INFIXOP3"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_INFIXOP2) -> "INFIXOP2"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_INFIXOP1) -> "INFIXOP1"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_INFIXOP0) -> "INFIXOP0"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_INCLUDE) -> "INCLUDE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_IN) -> "IN"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_IF) -> "IF"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_GREATERRBRACKET) -> "GREATERRBRACKET"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_GREATERRBRACE) -> "GREATERRBRACE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_GREATERDOT) -> "GREATERDOT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_GREATER) -> "GREATER"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_FUNCTOR) -> "FUNCTOR"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_FUNCTION) -> "FUNCTION"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_FUN) -> "FUN"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_FOR_LWT) -> "FOR_LWT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_FOR) -> "FOR"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_FLOAT) -> "FLOAT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_FINALLY_LWT) -> "FINALLY_LWT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_FALSE) -> "FALSE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_EXTERNAL) -> "EXTERNAL"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_EXITPOINT) -> "EXITPOINT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_EXCEPTION) -> "EXCEPTION"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_EQUAL) -> "EQUAL"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_EOL) -> "EOL"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_EOF) -> "EOF"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_END) -> "END"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_ELSE) -> "ELSE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_DOWNTO) -> "DOWNTO"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_DOTTILDE) -> "DOTTILDE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_DOTLESS) -> "DOTLESS"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_DOTDOT) -> "DOTDOT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_DOT) -> "DOT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_DONE) -> "DONE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_DO) -> "DO"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_CUSTOM_BANG) -> "CUSTOM_BANG"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_CONSTRAINT) -> "CONSTRAINT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_COMMENT) -> "COMMENT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_COMMA) -> "COMMA"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_COLONGREATER) -> "COLONGREATER"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_COLONEQUAL) -> "COLONEQUAL"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_COLONCOLON) -> "COLONCOLON"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_COLON) -> "COLON"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_CLASS) -> "CLASS"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_CHAR) -> "CHAR"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_BEGIN) -> "BEGIN"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_BARRBRACKET) -> "BARRBRACKET"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_BARBAR) -> "BARBAR"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_BAR) -> "BAR"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_BANG) -> "BANG"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_BACKQUOTE) -> "BACKQUOTE"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_ASSERT) -> "ASSERT"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_AS) -> "AS"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_AND) -> "AND"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_AMPERSAND) -> "AMPERSAND"
  | MenhirInterpreter.X (MenhirInterpreter.T MenhirInterpreter.T_AMPERAMPER) -> "AMPERAMPER"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_with_type_binder) -> "with_type_binder"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_with_extensions) -> "with_extensions"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_with_constraints) -> "with_constraints"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_with_constraint) -> "with_constraint"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_virtual_flag) -> "virtual_flag"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_value_type) -> "value_type"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_value) -> "value"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_val_longident) -> "val_longident"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_val_ident) -> "val_ident"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_typevar_list) -> "typevar_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_type_variance) -> "type_variance"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_type_variable) -> "type_variable"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_type_parameters) -> "type_parameters"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_type_parameter_list) -> "type_parameter_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_type_parameter) -> "type_parameter"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_type_longident) -> "type_longident"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_type_kind) -> "type_kind"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_type_declarations) -> "type_declarations"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_type_declaration) -> "type_declaration"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_type_constraint) -> "type_constraint"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_toplevel_directives) -> "toplevel_directives"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_tag_field) -> "tag_field"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_subtractive) -> "subtractive"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_structure_tail) -> "structure_tail"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_structure_item) -> "structure_item"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_structure_head) -> "structure_head"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_structure) -> "structure"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_strict_binding) -> "strict_binding"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_str_type_extension) -> "str_type_extension"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_str_extension_constructors) -> "str_extension_constructors"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_str_exception_declaration) -> "str_exception_declaration"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_single_attr_id) -> "single_attr_id"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_simple_pattern_not_ident) -> "simple_pattern_not_ident"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_simple_pattern) -> "simple_pattern"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_simple_labeled_expr_list) -> "simple_labeled_expr_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_simple_expr) -> "simple_expr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_simple_core_type_or_tuple_no_attr) -> "simple_core_type_or_tuple_no_attr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_simple_core_type_or_tuple) -> "simple_core_type_or_tuple"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_simple_core_type_no_attr) -> "simple_core_type_no_attr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_simple_core_type2) -> "simple_core_type2"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_simple_core_type) -> "simple_core_type"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_signed_constant) -> "signed_constant"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_signature_item) -> "signature_item"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_signature) -> "signature"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_sig_type_extension) -> "sig_type_extension"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_sig_extension_constructors) -> "sig_extension_constructors"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_sig_exception_declaration) -> "sig_exception_declaration"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_seq_expr) -> "seq_expr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_row_field_list) -> "row_field_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_row_field) -> "row_field"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_record_expr) -> "record_expr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_rec_module_declarations) -> "rec_module_declarations"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_rec_flag) -> "rec_flag"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_private_virtual_flags) -> "private_virtual_flags"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_private_flag) -> "private_flag"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_primitive_declaration) -> "primitive_declaration"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_post_item_attributes) -> "post_item_attributes"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_post_item_attribute) -> "post_item_attribute"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_poly_type_no_attr) -> "poly_type_no_attr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_poly_type) -> "poly_type"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_payload) -> "payload"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_pattern_var) -> "pattern_var"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_pattern_semi_list) -> "pattern_semi_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_pattern_comma_list) -> "pattern_comma_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_pattern) -> "pattern"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_parse_expression) -> "parse_expression"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_parent_binder) -> "parent_binder"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_package_type_cstrs) -> "package_type_cstrs"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_package_type_cstr) -> "package_type_cstr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_package_type) -> "package_type"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_override_flag) -> "override_flag"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_optional_type_variable) -> "optional_type_variable"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_optional_type_parameters) -> "optional_type_parameters"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_optional_type_parameter_list) -> "optional_type_parameter_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_optional_type_parameter) -> "optional_type_parameter"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_option_STRING_) -> "option_STRING_"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_opt_semi) -> "opt_semi"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_opt_default) -> "opt_default"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_opt_bar) -> "opt_bar"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_opt_ampersand) -> "opt_ampersand"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_operator) -> "operator"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_open_statement) -> "open_statement"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_newtype) -> "newtype"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_name_tag_list) -> "name_tag_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_name_tag) -> "name_tag"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_mutable_flag) -> "mutable_flag"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_mty_longident) -> "mty_longident"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_module_type) -> "module_type"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_module_rec_declaration) -> "module_rec_declaration"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_module_expr) -> "module_expr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_module_declaration) -> "module_declaration"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_module_bindings) -> "module_bindings"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_module_binding_body) -> "module_binding_body"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_module_binding) -> "module_binding"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_mod_longident) -> "mod_longident"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_mod_ext_longident) -> "mod_ext_longident"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_method_) -> "method_"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_meth_list) -> "meth_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_match_cases) -> "match_cases"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_match_case) -> "match_case"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_lident_list) -> "lident_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_let_pattern) -> "let_pattern"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_let_operator) -> "let_operator"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_let_bindings_no_attrs) -> "let_bindings_no_attrs"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_let_bindings) -> "let_bindings"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_let_binding_) -> "let_binding_"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_let_binding) -> "let_binding"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_lbl_pattern_list) -> "lbl_pattern_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_lbl_pattern) -> "lbl_pattern"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_lbl_expr_list) -> "lbl_expr_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_lbl_expr) -> "lbl_expr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_labeled_simple_pattern) -> "labeled_simple_pattern"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_labeled_simple_expr) -> "labeled_simple_expr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_label_var) -> "label_var"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_label_longident) -> "label_longident"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_label_let_pattern) -> "label_let_pattern"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_label_ident) -> "label_ident"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_label_expr) -> "label_expr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_label_declarations) -> "label_declarations"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_label_declaration) -> "label_declaration"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_label) -> "label"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_item_extension) -> "item_extension"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_interface) -> "interface"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_implementation) -> "implementation"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_ident) -> "ident"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_generalized_constructor_arguments) -> "generalized_constructor_arguments"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_functor_args) -> "functor_args"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_functor_arg_name) -> "functor_arg_name"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_functor_arg) -> "functor_arg"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_fun_def) -> "fun_def"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_fun_binding) -> "fun_binding"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_floating_attribute) -> "floating_attribute"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_field_expr_list) -> "field_expr_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_field) -> "field"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_extension_constructor_rebind) -> "extension_constructor_rebind"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_extension_constructor_declaration) -> "extension_constructor_declaration"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_extension) -> "extension"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_ext_attributes) -> "ext_attributes"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_expr_semi_list) -> "expr_semi_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_expr_open) -> "expr_open"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_expr_comma_opt_list) -> "expr_comma_opt_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_expr_comma_list) -> "expr_comma_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_expr) -> "expr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_dummy) -> "dummy"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_direction_flag) -> "direction_flag"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_core_type_no_attr) -> "core_type_no_attr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_core_type_list_no_attr) -> "core_type_list_no_attr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_core_type_list) -> "core_type_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_core_type_comma_list) -> "core_type_comma_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_core_type2) -> "core_type2"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_core_type) -> "core_type"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_constructor_declarations) -> "constructor_declarations"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_constructor_declaration) -> "constructor_declaration"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_constraints) -> "constraints"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_constrain_field) -> "constrain_field"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_constrain) -> "constrain"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_constr_longident) -> "constr_longident"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_constr_ident) -> "constr_ident"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_constant) -> "constant"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_clty_longident) -> "clty_longident"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_type_parameters) -> "class_type_parameters"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_type_declarations) -> "class_type_declarations"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_type_declaration) -> "class_type_declaration"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_type) -> "class_type"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_structure) -> "class_structure"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_simple_expr) -> "class_simple_expr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_signature) -> "class_signature"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_sig_fields) -> "class_sig_fields"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_sig_field) -> "class_sig_field"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_sig_body) -> "class_sig_body"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_self_type) -> "class_self_type"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_self_pattern) -> "class_self_pattern"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_longident) -> "class_longident"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_fun_def) -> "class_fun_def"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_fun_binding) -> "class_fun_binding"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_fields) -> "class_fields"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_field) -> "class_field"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_expr) -> "class_expr"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_descriptions) -> "class_descriptions"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_description) -> "class_description"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_declarations) -> "class_declarations"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_class_declaration) -> "class_declaration"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_attributes) -> "attributes"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_attribute) -> "attribute"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_attr_id) -> "attr_id"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_amper_type_list) -> "amper_type_list"
  | MenhirInterpreter.X (MenhirInterpreter.N MenhirInterpreter.N_additive) -> "additive"

let print_value (type a) : a MenhirInterpreter.symbol -> a -> string = function
  | MenhirInterpreter.T MenhirInterpreter.T_error -> (fun _ -> "error")
  | MenhirInterpreter.T MenhirInterpreter.T_WITH -> (fun _ -> "WITH")
  | MenhirInterpreter.T MenhirInterpreter.T_WHILE_LWT -> (fun _ -> "WHILE_LWT")
  | MenhirInterpreter.T MenhirInterpreter.T_WHILE -> (fun _ -> "WHILE")
  | MenhirInterpreter.T MenhirInterpreter.T_WHEN -> (fun _ -> "WHEN")
  | MenhirInterpreter.T MenhirInterpreter.T_VIRTUAL -> (fun _ -> "VIRTUAL")
  | MenhirInterpreter.T MenhirInterpreter.T_VAL -> (fun _ -> "VAL")
  | MenhirInterpreter.T MenhirInterpreter.T_UNDERSCORE -> (fun _ -> "UNDERSCORE")
  | MenhirInterpreter.T MenhirInterpreter.T_UIDENT -> (fun _ -> "UIDENT")
  | MenhirInterpreter.T MenhirInterpreter.T_TYPE -> (fun _ -> "TYPE")
  | MenhirInterpreter.T MenhirInterpreter.T_TRY_LWT -> (fun _ -> "TRY_LWT")
  | MenhirInterpreter.T MenhirInterpreter.T_TRY -> (fun _ -> "TRY")
  | MenhirInterpreter.T MenhirInterpreter.T_TRUE -> (fun _ -> "TRUE")
  | MenhirInterpreter.T MenhirInterpreter.T_TO -> (fun _ -> "TO")
  | MenhirInterpreter.T MenhirInterpreter.T_TILDE -> (fun _ -> "TILDE")
  | MenhirInterpreter.T MenhirInterpreter.T_THEN -> (fun _ -> "THEN")
  | MenhirInterpreter.T MenhirInterpreter.T_STRUCT -> (fun _ -> "STRUCT")
  | MenhirInterpreter.T MenhirInterpreter.T_STRING -> (fun _ -> "STRING")
  | MenhirInterpreter.T MenhirInterpreter.T_STAR -> (fun _ -> "STAR")
  | MenhirInterpreter.T MenhirInterpreter.T_SIG -> (fun _ -> "SIG")
  | MenhirInterpreter.T MenhirInterpreter.T_SHARPSHARP -> (fun _ -> "SHARPSHARP")
  | MenhirInterpreter.T MenhirInterpreter.T_SHARPOP -> (fun _ -> "SHARPOP")
  | MenhirInterpreter.T MenhirInterpreter.T_SHARP -> (fun _ -> "SHARP")
  | MenhirInterpreter.T MenhirInterpreter.T_SEMISEMI -> (fun _ -> "SEMISEMI")
  | MenhirInterpreter.T MenhirInterpreter.T_SEMI -> (fun _ -> "SEMI")
  | MenhirInterpreter.T MenhirInterpreter.T_RPAREN -> (fun _ -> "RPAREN")
  | MenhirInterpreter.T MenhirInterpreter.T_REC -> (fun _ -> "REC")
  | MenhirInterpreter.T MenhirInterpreter.T_RBRACKET -> (fun _ -> "RBRACKET")
  | MenhirInterpreter.T MenhirInterpreter.T_RBRACE -> (fun _ -> "RBRACE")
  | MenhirInterpreter.T MenhirInterpreter.T_QUOTE -> (fun _ -> "QUOTE")
  | MenhirInterpreter.T MenhirInterpreter.T_QUESTION -> (fun _ -> "QUESTION")
  | MenhirInterpreter.T MenhirInterpreter.T_PRIVATE -> (fun _ -> "PRIVATE")
  | MenhirInterpreter.T MenhirInterpreter.T_PREFIXOP -> (fun _ -> "PREFIXOP")
  | MenhirInterpreter.T MenhirInterpreter.T_PLUSEQ -> (fun _ -> "PLUSEQ")
  | MenhirInterpreter.T MenhirInterpreter.T_PLUSDOT -> (fun _ -> "PLUSDOT")
  | MenhirInterpreter.T MenhirInterpreter.T_PLUS -> (fun _ -> "PLUS")
  | MenhirInterpreter.T MenhirInterpreter.T_PERCENT -> (fun _ -> "PERCENT")
  | MenhirInterpreter.T MenhirInterpreter.T_P4_QUOTATION -> (fun _ -> "P4_QUOTATION")
  | MenhirInterpreter.T MenhirInterpreter.T_OUNIT_TEST_UNIT -> (fun _ -> "OUNIT_TEST_UNIT")
  | MenhirInterpreter.T MenhirInterpreter.T_OUNIT_TEST_MODULE -> (fun _ -> "OUNIT_TEST_MODULE")
  | MenhirInterpreter.T MenhirInterpreter.T_OUNIT_TEST -> (fun _ -> "OUNIT_TEST")
  | MenhirInterpreter.T MenhirInterpreter.T_OUNIT_BENCH_MODULE -> (fun _ -> "OUNIT_BENCH_MODULE")
  | MenhirInterpreter.T MenhirInterpreter.T_OUNIT_BENCH_INDEXED -> (fun _ -> "OUNIT_BENCH_INDEXED")
  | MenhirInterpreter.T MenhirInterpreter.T_OUNIT_BENCH_FUN -> (fun _ -> "OUNIT_BENCH_FUN")
  | MenhirInterpreter.T MenhirInterpreter.T_OUNIT_BENCH -> (fun _ -> "OUNIT_BENCH")
  | MenhirInterpreter.T MenhirInterpreter.T_OR -> (fun _ -> "OR")
  | MenhirInterpreter.T MenhirInterpreter.T_OPTLABEL -> (fun _ -> "OPTLABEL")
  | MenhirInterpreter.T MenhirInterpreter.T_OPEN -> (fun _ -> "OPEN")
  | MenhirInterpreter.T MenhirInterpreter.T_OF -> (fun _ -> "OF")
  | MenhirInterpreter.T MenhirInterpreter.T_OBJECT -> (fun _ -> "OBJECT")
  | MenhirInterpreter.T MenhirInterpreter.T_NONREC -> (fun _ -> "NONREC")
  | MenhirInterpreter.T MenhirInterpreter.T_NEW -> (fun _ -> "NEW")
  | MenhirInterpreter.T MenhirInterpreter.T_NATIVEINT -> (fun _ -> "NATIVEINT")
  | MenhirInterpreter.T MenhirInterpreter.T_MUTABLE -> (fun _ -> "MUTABLE")
  | MenhirInterpreter.T MenhirInterpreter.T_MODULE -> (fun _ -> "MODULE")
  | MenhirInterpreter.T MenhirInterpreter.T_MINUSGREATER -> (fun _ -> "MINUSGREATER")
  | MenhirInterpreter.T MenhirInterpreter.T_MINUSDOT -> (fun _ -> "MINUSDOT")
  | MenhirInterpreter.T MenhirInterpreter.T_MINUS -> (fun _ -> "MINUS")
  | MenhirInterpreter.T MenhirInterpreter.T_METHOD -> (fun _ -> "METHOD")
  | MenhirInterpreter.T MenhirInterpreter.T_MATCH_LWT -> (fun _ -> "MATCH_LWT")
  | MenhirInterpreter.T MenhirInterpreter.T_MATCH -> (fun _ -> "MATCH")
  | MenhirInterpreter.T MenhirInterpreter.T_LPAREN -> (fun _ -> "LPAREN")
  | MenhirInterpreter.T MenhirInterpreter.T_LIDENT -> (fun _ -> "LIDENT")
  | MenhirInterpreter.T MenhirInterpreter.T_LET_LWT -> (fun _ -> "LET_LWT")
  | MenhirInterpreter.T MenhirInterpreter.T_LETOP -> (fun _ -> "LETOP")
  | MenhirInterpreter.T MenhirInterpreter.T_LET -> (fun _ -> "LET")
  | MenhirInterpreter.T MenhirInterpreter.T_LESSMINUS -> (fun _ -> "LESSMINUS")
  | MenhirInterpreter.T MenhirInterpreter.T_LESS -> (fun _ -> "LESS")
  | MenhirInterpreter.T MenhirInterpreter.T_LBRACKETPERCENTPERCENT -> (fun _ -> "LBRACKETPERCENTPERCENT")
  | MenhirInterpreter.T MenhirInterpreter.T_LBRACKETPERCENT -> (fun _ -> "LBRACKETPERCENT")
  | MenhirInterpreter.T MenhirInterpreter.T_LBRACKETLESS -> (fun _ -> "LBRACKETLESS")
  | MenhirInterpreter.T MenhirInterpreter.T_LBRACKETGREATER -> (fun _ -> "LBRACKETGREATER")
  | MenhirInterpreter.T MenhirInterpreter.T_LBRACKETBAR -> (fun _ -> "LBRACKETBAR")
  | MenhirInterpreter.T MenhirInterpreter.T_LBRACKETATATAT -> (fun _ -> "LBRACKETATATAT")
  | MenhirInterpreter.T MenhirInterpreter.T_LBRACKETATAT -> (fun _ -> "LBRACKETATAT")
  | MenhirInterpreter.T MenhirInterpreter.T_LBRACKETAT -> (fun _ -> "LBRACKETAT")
  | MenhirInterpreter.T MenhirInterpreter.T_LBRACKET -> (fun _ -> "LBRACKET")
  | MenhirInterpreter.T MenhirInterpreter.T_LBRACELESS -> (fun _ -> "LBRACELESS")
  | MenhirInterpreter.T MenhirInterpreter.T_LBRACE -> (fun _ -> "LBRACE")
  | MenhirInterpreter.T MenhirInterpreter.T_LAZY -> (fun _ -> "LAZY")
  | MenhirInterpreter.T MenhirInterpreter.T_LABEL -> (fun _ -> "LABEL")
  | MenhirInterpreter.T MenhirInterpreter.T_JSNEW -> (fun _ -> "JSNEW")
  | MenhirInterpreter.T MenhirInterpreter.T_INT64 -> (fun _ -> "INT64")
  | MenhirInterpreter.T MenhirInterpreter.T_INT32 -> (fun _ -> "INT32")
  | MenhirInterpreter.T MenhirInterpreter.T_INT -> (fun _ -> "INT")
  | MenhirInterpreter.T MenhirInterpreter.T_INITIALIZER -> (fun _ -> "INITIALIZER")
  | MenhirInterpreter.T MenhirInterpreter.T_INHERIT -> (fun _ -> "INHERIT")
  | MenhirInterpreter.T MenhirInterpreter.T_INFIXOP4 -> (fun _ -> "INFIXOP4")
  | MenhirInterpreter.T MenhirInterpreter.T_INFIXOP3 -> (fun _ -> "INFIXOP3")
  | MenhirInterpreter.T MenhirInterpreter.T_INFIXOP2 -> (fun _ -> "INFIXOP2")
  | MenhirInterpreter.T MenhirInterpreter.T_INFIXOP1 -> (fun _ -> "INFIXOP1")
  | MenhirInterpreter.T MenhirInterpreter.T_INFIXOP0 -> (fun _ -> "INFIXOP0")
  | MenhirInterpreter.T MenhirInterpreter.T_INCLUDE -> (fun _ -> "INCLUDE")
  | MenhirInterpreter.T MenhirInterpreter.T_IN -> (fun _ -> "IN")
  | MenhirInterpreter.T MenhirInterpreter.T_IF -> (fun _ -> "IF")
  | MenhirInterpreter.T MenhirInterpreter.T_GREATERRBRACKET -> (fun _ -> "GREATERRBRACKET")
  | MenhirInterpreter.T MenhirInterpreter.T_GREATERRBRACE -> (fun _ -> "GREATERRBRACE")
  | MenhirInterpreter.T MenhirInterpreter.T_GREATERDOT -> (fun _ -> "GREATERDOT")
  | MenhirInterpreter.T MenhirInterpreter.T_GREATER -> (fun _ -> "GREATER")
  | MenhirInterpreter.T MenhirInterpreter.T_FUNCTOR -> (fun _ -> "FUNCTOR")
  | MenhirInterpreter.T MenhirInterpreter.T_FUNCTION -> (fun _ -> "FUNCTION")
  | MenhirInterpreter.T MenhirInterpreter.T_FUN -> (fun _ -> "FUN")
  | MenhirInterpreter.T MenhirInterpreter.T_FOR_LWT -> (fun _ -> "FOR_LWT")
  | MenhirInterpreter.T MenhirInterpreter.T_FOR -> (fun _ -> "FOR")
  | MenhirInterpreter.T MenhirInterpreter.T_FLOAT -> (fun _ -> "FLOAT")
  | MenhirInterpreter.T MenhirInterpreter.T_FINALLY_LWT -> (fun _ -> "FINALLY_LWT")
  | MenhirInterpreter.T MenhirInterpreter.T_FALSE -> (fun _ -> "FALSE")
  | MenhirInterpreter.T MenhirInterpreter.T_EXTERNAL -> (fun _ -> "EXTERNAL")
  | MenhirInterpreter.T MenhirInterpreter.T_EXITPOINT -> (fun _ -> "EXITPOINT")
  | MenhirInterpreter.T MenhirInterpreter.T_EXCEPTION -> (fun _ -> "EXCEPTION")
  | MenhirInterpreter.T MenhirInterpreter.T_EQUAL -> (fun _ -> "EQUAL")
  | MenhirInterpreter.T MenhirInterpreter.T_EOL -> (fun _ -> "EOL")
  | MenhirInterpreter.T MenhirInterpreter.T_EOF -> (fun _ -> "EOF")
  | MenhirInterpreter.T MenhirInterpreter.T_END -> (fun _ -> "END")
  | MenhirInterpreter.T MenhirInterpreter.T_ELSE -> (fun _ -> "ELSE")
  | MenhirInterpreter.T MenhirInterpreter.T_DOWNTO -> (fun _ -> "DOWNTO")
  | MenhirInterpreter.T MenhirInterpreter.T_DOTTILDE -> (fun _ -> "DOTTILDE")
  | MenhirInterpreter.T MenhirInterpreter.T_DOTLESS -> (fun _ -> "DOTLESS")
  | MenhirInterpreter.T MenhirInterpreter.T_DOTDOT -> (fun _ -> "DOTDOT")
  | MenhirInterpreter.T MenhirInterpreter.T_DOT -> (fun _ -> "DOT")
  | MenhirInterpreter.T MenhirInterpreter.T_DONE -> (fun _ -> "DONE")
  | MenhirInterpreter.T MenhirInterpreter.T_DO -> (fun _ -> "DO")
  | MenhirInterpreter.T MenhirInterpreter.T_CUSTOM_BANG -> (fun _ -> "CUSTOM_BANG")
  | MenhirInterpreter.T MenhirInterpreter.T_CONSTRAINT -> (fun _ -> "CONSTRAINT")
  | MenhirInterpreter.T MenhirInterpreter.T_COMMENT -> (fun _ -> "COMMENT")
  | MenhirInterpreter.T MenhirInterpreter.T_COMMA -> (fun _ -> "COMMA")
  | MenhirInterpreter.T MenhirInterpreter.T_COLONGREATER -> (fun _ -> "COLONGREATER")
  | MenhirInterpreter.T MenhirInterpreter.T_COLONEQUAL -> (fun _ -> "COLONEQUAL")
  | MenhirInterpreter.T MenhirInterpreter.T_COLONCOLON -> (fun _ -> "COLONCOLON")
  | MenhirInterpreter.T MenhirInterpreter.T_COLON -> (fun _ -> "COLON")
  | MenhirInterpreter.T MenhirInterpreter.T_CLASS -> (fun _ -> "CLASS")
  | MenhirInterpreter.T MenhirInterpreter.T_CHAR -> (fun _ -> "CHAR")
  | MenhirInterpreter.T MenhirInterpreter.T_BEGIN -> (fun _ -> "BEGIN")
  | MenhirInterpreter.T MenhirInterpreter.T_BARRBRACKET -> (fun _ -> "BARRBRACKET")
  | MenhirInterpreter.T MenhirInterpreter.T_BARBAR -> (fun _ -> "BARBAR")
  | MenhirInterpreter.T MenhirInterpreter.T_BAR -> (fun _ -> "BAR")
  | MenhirInterpreter.T MenhirInterpreter.T_BANG -> (fun _ -> "BANG")
  | MenhirInterpreter.T MenhirInterpreter.T_BACKQUOTE -> (fun _ -> "BACKQUOTE")
  | MenhirInterpreter.T MenhirInterpreter.T_ASSERT -> (fun _ -> "ASSERT")
  | MenhirInterpreter.T MenhirInterpreter.T_AS -> (fun _ -> "AS")
  | MenhirInterpreter.T MenhirInterpreter.T_AND -> (fun _ -> "AND")
  | MenhirInterpreter.T MenhirInterpreter.T_AMPERSAND -> (fun _ -> "AMPERSAND")
  | MenhirInterpreter.T MenhirInterpreter.T_AMPERAMPER -> (fun _ -> "AMPERAMPER")
  | MenhirInterpreter.N MenhirInterpreter.N_with_type_binder -> (fun _ -> "with_type_binder")
  | MenhirInterpreter.N MenhirInterpreter.N_with_extensions -> (fun _ -> "with_extensions")
  | MenhirInterpreter.N MenhirInterpreter.N_with_constraints -> (fun _ -> "with_constraints")
  | MenhirInterpreter.N MenhirInterpreter.N_with_constraint -> (fun _ -> "with_constraint")
  | MenhirInterpreter.N MenhirInterpreter.N_virtual_flag -> (fun _ -> "virtual_flag")
  | MenhirInterpreter.N MenhirInterpreter.N_value_type -> (fun _ -> "value_type")
  | MenhirInterpreter.N MenhirInterpreter.N_value -> (fun _ -> "value")
  | MenhirInterpreter.N MenhirInterpreter.N_val_longident -> (fun _ -> "val_longident")
  | MenhirInterpreter.N MenhirInterpreter.N_val_ident -> (fun _ -> "val_ident")
  | MenhirInterpreter.N MenhirInterpreter.N_typevar_list -> (fun _ -> "typevar_list")
  | MenhirInterpreter.N MenhirInterpreter.N_type_variance -> (fun _ -> "type_variance")
  | MenhirInterpreter.N MenhirInterpreter.N_type_variable -> (fun _ -> "type_variable")
  | MenhirInterpreter.N MenhirInterpreter.N_type_parameters -> (fun _ -> "type_parameters")
  | MenhirInterpreter.N MenhirInterpreter.N_type_parameter_list -> (fun _ -> "type_parameter_list")
  | MenhirInterpreter.N MenhirInterpreter.N_type_parameter -> (fun _ -> "type_parameter")
  | MenhirInterpreter.N MenhirInterpreter.N_type_longident -> (fun _ -> "type_longident")
  | MenhirInterpreter.N MenhirInterpreter.N_type_kind -> (fun _ -> "type_kind")
  | MenhirInterpreter.N MenhirInterpreter.N_type_declarations -> (fun _ -> "type_declarations")
  | MenhirInterpreter.N MenhirInterpreter.N_type_declaration -> (fun _ -> "type_declaration")
  | MenhirInterpreter.N MenhirInterpreter.N_type_constraint -> (fun _ -> "type_constraint")
  | MenhirInterpreter.N MenhirInterpreter.N_toplevel_directives -> (fun _ -> "toplevel_directives")
  | MenhirInterpreter.N MenhirInterpreter.N_tag_field -> (fun _ -> "tag_field")
  | MenhirInterpreter.N MenhirInterpreter.N_subtractive -> (fun _ -> "subtractive")
  | MenhirInterpreter.N MenhirInterpreter.N_structure_tail -> (fun _ -> "structure_tail")
  | MenhirInterpreter.N MenhirInterpreter.N_structure_item -> (fun _ -> "structure_item")
  | MenhirInterpreter.N MenhirInterpreter.N_structure_head -> (fun _ -> "structure_head")
  | MenhirInterpreter.N MenhirInterpreter.N_structure -> (fun _ -> "structure")
  | MenhirInterpreter.N MenhirInterpreter.N_strict_binding -> (fun _ -> "strict_binding")
  | MenhirInterpreter.N MenhirInterpreter.N_str_type_extension -> (fun _ -> "str_type_extension")
  | MenhirInterpreter.N MenhirInterpreter.N_str_extension_constructors -> (fun _ -> "str_extension_constructors")
  | MenhirInterpreter.N MenhirInterpreter.N_str_exception_declaration -> (fun _ -> "str_exception_declaration")
  | MenhirInterpreter.N MenhirInterpreter.N_single_attr_id -> (fun _ -> "single_attr_id")
  | MenhirInterpreter.N MenhirInterpreter.N_simple_pattern_not_ident -> (fun _ -> "simple_pattern_not_ident")
  | MenhirInterpreter.N MenhirInterpreter.N_simple_pattern -> (fun _ -> "simple_pattern")
  | MenhirInterpreter.N MenhirInterpreter.N_simple_labeled_expr_list -> (fun _ -> "simple_labeled_expr_list")
  | MenhirInterpreter.N MenhirInterpreter.N_simple_expr -> (fun _ -> "simple_expr")
  | MenhirInterpreter.N MenhirInterpreter.N_simple_core_type_or_tuple_no_attr -> (fun _ -> "simple_core_type_or_tuple_no_attr")
  | MenhirInterpreter.N MenhirInterpreter.N_simple_core_type_or_tuple -> (fun _ -> "simple_core_type_or_tuple")
  | MenhirInterpreter.N MenhirInterpreter.N_simple_core_type_no_attr -> (fun _ -> "simple_core_type_no_attr")
  | MenhirInterpreter.N MenhirInterpreter.N_simple_core_type2 -> (fun _ -> "simple_core_type2")
  | MenhirInterpreter.N MenhirInterpreter.N_simple_core_type -> (fun _ -> "simple_core_type")
  | MenhirInterpreter.N MenhirInterpreter.N_signed_constant -> (fun _ -> "signed_constant")
  | MenhirInterpreter.N MenhirInterpreter.N_signature_item -> (fun _ -> "signature_item")
  | MenhirInterpreter.N MenhirInterpreter.N_signature -> (fun _ -> "signature")
  | MenhirInterpreter.N MenhirInterpreter.N_sig_type_extension -> (fun _ -> "sig_type_extension")
  | MenhirInterpreter.N MenhirInterpreter.N_sig_extension_constructors -> (fun _ -> "sig_extension_constructors")
  | MenhirInterpreter.N MenhirInterpreter.N_sig_exception_declaration -> (fun _ -> "sig_exception_declaration")
  | MenhirInterpreter.N MenhirInterpreter.N_seq_expr -> (fun _ -> "seq_expr")
  | MenhirInterpreter.N MenhirInterpreter.N_row_field_list -> (fun _ -> "row_field_list")
  | MenhirInterpreter.N MenhirInterpreter.N_row_field -> (fun _ -> "row_field")
  | MenhirInterpreter.N MenhirInterpreter.N_record_expr -> (fun _ -> "record_expr")
  | MenhirInterpreter.N MenhirInterpreter.N_rec_module_declarations -> (fun _ -> "rec_module_declarations")
  | MenhirInterpreter.N MenhirInterpreter.N_rec_flag -> (fun _ -> "rec_flag")
  | MenhirInterpreter.N MenhirInterpreter.N_private_virtual_flags -> (fun _ -> "private_virtual_flags")
  | MenhirInterpreter.N MenhirInterpreter.N_private_flag -> (fun _ -> "private_flag")
  | MenhirInterpreter.N MenhirInterpreter.N_primitive_declaration -> (fun _ -> "primitive_declaration")
  | MenhirInterpreter.N MenhirInterpreter.N_post_item_attributes -> (fun _ -> "post_item_attributes")
  | MenhirInterpreter.N MenhirInterpreter.N_post_item_attribute -> (fun _ -> "post_item_attribute")
  | MenhirInterpreter.N MenhirInterpreter.N_poly_type_no_attr -> (fun _ -> "poly_type_no_attr")
  | MenhirInterpreter.N MenhirInterpreter.N_poly_type -> (fun _ -> "poly_type")
  | MenhirInterpreter.N MenhirInterpreter.N_payload -> (fun _ -> "payload")
  | MenhirInterpreter.N MenhirInterpreter.N_pattern_var -> (fun _ -> "pattern_var")
  | MenhirInterpreter.N MenhirInterpreter.N_pattern_semi_list -> (fun _ -> "pattern_semi_list")
  | MenhirInterpreter.N MenhirInterpreter.N_pattern_comma_list -> (fun _ -> "pattern_comma_list")
  | MenhirInterpreter.N MenhirInterpreter.N_pattern -> (fun _ -> "pattern")
  | MenhirInterpreter.N MenhirInterpreter.N_parse_expression -> (fun _ -> "parse_expression")
  | MenhirInterpreter.N MenhirInterpreter.N_parent_binder -> (fun _ -> "parent_binder")
  | MenhirInterpreter.N MenhirInterpreter.N_package_type_cstrs -> (fun _ -> "package_type_cstrs")
  | MenhirInterpreter.N MenhirInterpreter.N_package_type_cstr -> (fun _ -> "package_type_cstr")
  | MenhirInterpreter.N MenhirInterpreter.N_package_type -> (fun _ -> "package_type")
  | MenhirInterpreter.N MenhirInterpreter.N_override_flag -> (fun _ -> "override_flag")
  | MenhirInterpreter.N MenhirInterpreter.N_optional_type_variable -> (fun _ -> "optional_type_variable")
  | MenhirInterpreter.N MenhirInterpreter.N_optional_type_parameters -> (fun _ -> "optional_type_parameters")
  | MenhirInterpreter.N MenhirInterpreter.N_optional_type_parameter_list -> (fun _ -> "optional_type_parameter_list")
  | MenhirInterpreter.N MenhirInterpreter.N_optional_type_parameter -> (fun _ -> "optional_type_parameter")
  | MenhirInterpreter.N MenhirInterpreter.N_option_STRING_ -> (fun _ -> "option_STRING_")
  | MenhirInterpreter.N MenhirInterpreter.N_opt_semi -> (fun _ -> "opt_semi")
  | MenhirInterpreter.N MenhirInterpreter.N_opt_default -> (fun _ -> "opt_default")
  | MenhirInterpreter.N MenhirInterpreter.N_opt_bar -> (fun _ -> "opt_bar")
  | MenhirInterpreter.N MenhirInterpreter.N_opt_ampersand -> (fun _ -> "opt_ampersand")
  | MenhirInterpreter.N MenhirInterpreter.N_operator -> (fun _ -> "operator")
  | MenhirInterpreter.N MenhirInterpreter.N_open_statement -> (fun _ -> "open_statement")
  | MenhirInterpreter.N MenhirInterpreter.N_newtype -> (fun _ -> "newtype")
  | MenhirInterpreter.N MenhirInterpreter.N_name_tag_list -> (fun _ -> "name_tag_list")
  | MenhirInterpreter.N MenhirInterpreter.N_name_tag -> (fun _ -> "name_tag")
  | MenhirInterpreter.N MenhirInterpreter.N_mutable_flag -> (fun _ -> "mutable_flag")
  | MenhirInterpreter.N MenhirInterpreter.N_mty_longident -> (fun _ -> "mty_longident")
  | MenhirInterpreter.N MenhirInterpreter.N_module_type -> (fun _ -> "module_type")
  | MenhirInterpreter.N MenhirInterpreter.N_module_rec_declaration -> (fun _ -> "module_rec_declaration")
  | MenhirInterpreter.N MenhirInterpreter.N_module_expr -> (fun _ -> "module_expr")
  | MenhirInterpreter.N MenhirInterpreter.N_module_declaration -> (fun _ -> "module_declaration")
  | MenhirInterpreter.N MenhirInterpreter.N_module_bindings -> (fun _ -> "module_bindings")
  | MenhirInterpreter.N MenhirInterpreter.N_module_binding_body -> (fun _ -> "module_binding_body")
  | MenhirInterpreter.N MenhirInterpreter.N_module_binding -> (fun _ -> "module_binding")
  | MenhirInterpreter.N MenhirInterpreter.N_mod_longident -> (fun _ -> "mod_longident")
  | MenhirInterpreter.N MenhirInterpreter.N_mod_ext_longident -> (fun _ -> "mod_ext_longident")
  | MenhirInterpreter.N MenhirInterpreter.N_method_ -> (fun _ -> "method_")
  | MenhirInterpreter.N MenhirInterpreter.N_meth_list -> (fun _ -> "meth_list")
  | MenhirInterpreter.N MenhirInterpreter.N_match_cases -> (fun _ -> "match_cases")
  | MenhirInterpreter.N MenhirInterpreter.N_match_case -> (fun _ -> "match_case")
  | MenhirInterpreter.N MenhirInterpreter.N_lident_list -> (fun _ -> "lident_list")
  | MenhirInterpreter.N MenhirInterpreter.N_let_pattern -> (fun _ -> "let_pattern")
  | MenhirInterpreter.N MenhirInterpreter.N_let_operator -> (fun _ -> "let_operator")
  | MenhirInterpreter.N MenhirInterpreter.N_let_bindings_no_attrs -> (fun _ -> "let_bindings_no_attrs")
  | MenhirInterpreter.N MenhirInterpreter.N_let_bindings -> (fun _ -> "let_bindings")
  | MenhirInterpreter.N MenhirInterpreter.N_let_binding_ -> (fun _ -> "let_binding_")
  | MenhirInterpreter.N MenhirInterpreter.N_let_binding -> (fun _ -> "let_binding")
  | MenhirInterpreter.N MenhirInterpreter.N_lbl_pattern_list -> (fun _ -> "lbl_pattern_list")
  | MenhirInterpreter.N MenhirInterpreter.N_lbl_pattern -> (fun _ -> "lbl_pattern")
  | MenhirInterpreter.N MenhirInterpreter.N_lbl_expr_list -> (fun _ -> "lbl_expr_list")
  | MenhirInterpreter.N MenhirInterpreter.N_lbl_expr -> (fun _ -> "lbl_expr")
  | MenhirInterpreter.N MenhirInterpreter.N_labeled_simple_pattern -> (fun _ -> "labeled_simple_pattern")
  | MenhirInterpreter.N MenhirInterpreter.N_labeled_simple_expr -> (fun _ -> "labeled_simple_expr")
  | MenhirInterpreter.N MenhirInterpreter.N_label_var -> (fun _ -> "label_var")
  | MenhirInterpreter.N MenhirInterpreter.N_label_longident -> (fun _ -> "label_longident")
  | MenhirInterpreter.N MenhirInterpreter.N_label_let_pattern -> (fun _ -> "label_let_pattern")
  | MenhirInterpreter.N MenhirInterpreter.N_label_ident -> (fun _ -> "label_ident")
  | MenhirInterpreter.N MenhirInterpreter.N_label_expr -> (fun _ -> "label_expr")
  | MenhirInterpreter.N MenhirInterpreter.N_label_declarations -> (fun _ -> "label_declarations")
  | MenhirInterpreter.N MenhirInterpreter.N_label_declaration -> (fun _ -> "label_declaration")
  | MenhirInterpreter.N MenhirInterpreter.N_label -> (fun _ -> "label")
  | MenhirInterpreter.N MenhirInterpreter.N_item_extension -> (fun _ -> "item_extension")
  | MenhirInterpreter.N MenhirInterpreter.N_interface -> (fun _ -> "interface")
  | MenhirInterpreter.N MenhirInterpreter.N_implementation -> (fun _ -> "implementation")
  | MenhirInterpreter.N MenhirInterpreter.N_ident -> (fun _ -> "ident")
  | MenhirInterpreter.N MenhirInterpreter.N_generalized_constructor_arguments -> (fun _ -> "generalized_constructor_arguments")
  | MenhirInterpreter.N MenhirInterpreter.N_functor_args -> (fun _ -> "functor_args")
  | MenhirInterpreter.N MenhirInterpreter.N_functor_arg_name -> (fun _ -> "functor_arg_name")
  | MenhirInterpreter.N MenhirInterpreter.N_functor_arg -> (fun _ -> "functor_arg")
  | MenhirInterpreter.N MenhirInterpreter.N_fun_def -> (fun _ -> "fun_def")
  | MenhirInterpreter.N MenhirInterpreter.N_fun_binding -> (fun _ -> "fun_binding")
  | MenhirInterpreter.N MenhirInterpreter.N_floating_attribute -> (fun _ -> "floating_attribute")
  | MenhirInterpreter.N MenhirInterpreter.N_field_expr_list -> (fun _ -> "field_expr_list")
  | MenhirInterpreter.N MenhirInterpreter.N_field -> (fun _ -> "field")
  | MenhirInterpreter.N MenhirInterpreter.N_extension_constructor_rebind -> (fun _ -> "extension_constructor_rebind")
  | MenhirInterpreter.N MenhirInterpreter.N_extension_constructor_declaration -> (fun _ -> "extension_constructor_declaration")
  | MenhirInterpreter.N MenhirInterpreter.N_extension -> (fun _ -> "extension")
  | MenhirInterpreter.N MenhirInterpreter.N_ext_attributes -> (fun _ -> "ext_attributes")
  | MenhirInterpreter.N MenhirInterpreter.N_expr_semi_list -> (fun _ -> "expr_semi_list")
  | MenhirInterpreter.N MenhirInterpreter.N_expr_open -> (fun _ -> "expr_open")
  | MenhirInterpreter.N MenhirInterpreter.N_expr_comma_opt_list -> (fun _ -> "expr_comma_opt_list")
  | MenhirInterpreter.N MenhirInterpreter.N_expr_comma_list -> (fun _ -> "expr_comma_list")
  | MenhirInterpreter.N MenhirInterpreter.N_expr -> (fun _ -> "expr")
  | MenhirInterpreter.N MenhirInterpreter.N_dummy -> (fun _ -> "dummy")
  | MenhirInterpreter.N MenhirInterpreter.N_direction_flag -> (fun _ -> "direction_flag")
  | MenhirInterpreter.N MenhirInterpreter.N_core_type_no_attr -> (fun _ -> "core_type_no_attr")
  | MenhirInterpreter.N MenhirInterpreter.N_core_type_list_no_attr -> (fun _ -> "core_type_list_no_attr")
  | MenhirInterpreter.N MenhirInterpreter.N_core_type_list -> (fun _ -> "core_type_list")
  | MenhirInterpreter.N MenhirInterpreter.N_core_type_comma_list -> (fun _ -> "core_type_comma_list")
  | MenhirInterpreter.N MenhirInterpreter.N_core_type2 -> (fun _ -> "core_type2")
  | MenhirInterpreter.N MenhirInterpreter.N_core_type -> (fun _ -> "core_type")
  | MenhirInterpreter.N MenhirInterpreter.N_constructor_declarations -> (fun _ -> "constructor_declarations")
  | MenhirInterpreter.N MenhirInterpreter.N_constructor_declaration -> (fun _ -> "constructor_declaration")
  | MenhirInterpreter.N MenhirInterpreter.N_constraints -> (fun _ -> "constraints")
  | MenhirInterpreter.N MenhirInterpreter.N_constrain_field -> (fun _ -> "constrain_field")
  | MenhirInterpreter.N MenhirInterpreter.N_constrain -> (fun _ -> "constrain")
  | MenhirInterpreter.N MenhirInterpreter.N_constr_longident -> (fun _ -> "constr_longident")
  | MenhirInterpreter.N MenhirInterpreter.N_constr_ident -> (fun _ -> "constr_ident")
  | MenhirInterpreter.N MenhirInterpreter.N_constant -> (fun _ -> "constant")
  | MenhirInterpreter.N MenhirInterpreter.N_clty_longident -> (fun _ -> "clty_longident")
  | MenhirInterpreter.N MenhirInterpreter.N_class_type_parameters -> (fun _ -> "class_type_parameters")
  | MenhirInterpreter.N MenhirInterpreter.N_class_type_declarations -> (fun _ -> "class_type_declarations")
  | MenhirInterpreter.N MenhirInterpreter.N_class_type_declaration -> (fun _ -> "class_type_declaration")
  | MenhirInterpreter.N MenhirInterpreter.N_class_type -> (fun _ -> "class_type")
  | MenhirInterpreter.N MenhirInterpreter.N_class_structure -> (fun _ -> "class_structure")
  | MenhirInterpreter.N MenhirInterpreter.N_class_simple_expr -> (fun _ -> "class_simple_expr")
  | MenhirInterpreter.N MenhirInterpreter.N_class_signature -> (fun _ -> "class_signature")
  | MenhirInterpreter.N MenhirInterpreter.N_class_sig_fields -> (fun _ -> "class_sig_fields")
  | MenhirInterpreter.N MenhirInterpreter.N_class_sig_field -> (fun _ -> "class_sig_field")
  | MenhirInterpreter.N MenhirInterpreter.N_class_sig_body -> (fun _ -> "class_sig_body")
  | MenhirInterpreter.N MenhirInterpreter.N_class_self_type -> (fun _ -> "class_self_type")
  | MenhirInterpreter.N MenhirInterpreter.N_class_self_pattern -> (fun _ -> "class_self_pattern")
  | MenhirInterpreter.N MenhirInterpreter.N_class_longident -> (fun _ -> "class_longident")
  | MenhirInterpreter.N MenhirInterpreter.N_class_fun_def -> (fun _ -> "class_fun_def")
  | MenhirInterpreter.N MenhirInterpreter.N_class_fun_binding -> (fun _ -> "class_fun_binding")
  | MenhirInterpreter.N MenhirInterpreter.N_class_fields -> (fun _ -> "class_fields")
  | MenhirInterpreter.N MenhirInterpreter.N_class_field -> (fun _ -> "class_field")
  | MenhirInterpreter.N MenhirInterpreter.N_class_expr -> (fun _ -> "class_expr")
  | MenhirInterpreter.N MenhirInterpreter.N_class_descriptions -> (fun _ -> "class_descriptions")
  | MenhirInterpreter.N MenhirInterpreter.N_class_description -> (fun _ -> "class_description")
  | MenhirInterpreter.N MenhirInterpreter.N_class_declarations -> (fun _ -> "class_declarations")
  | MenhirInterpreter.N MenhirInterpreter.N_class_declaration -> (fun _ -> "class_declaration")
  | MenhirInterpreter.N MenhirInterpreter.N_attributes -> (fun _ -> "attributes")
  | MenhirInterpreter.N MenhirInterpreter.N_attribute -> (fun _ -> "attribute")
  | MenhirInterpreter.N MenhirInterpreter.N_attr_id -> (fun _ -> "attr_id")
  | MenhirInterpreter.N MenhirInterpreter.N_amper_type_list -> (fun _ -> "amper_type_list")
  | MenhirInterpreter.N MenhirInterpreter.N_additive -> (fun _ -> "additive")

let print_token = function
  | WITH -> print_value (MenhirInterpreter.T MenhirInterpreter.T_WITH) ()
  | WHILE_LWT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_WHILE_LWT) ()
  | WHILE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_WHILE) ()
  | WHEN -> print_value (MenhirInterpreter.T MenhirInterpreter.T_WHEN) ()
  | VIRTUAL -> print_value (MenhirInterpreter.T MenhirInterpreter.T_VIRTUAL) ()
  | VAL -> print_value (MenhirInterpreter.T MenhirInterpreter.T_VAL) ()
  | UNDERSCORE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_UNDERSCORE) ()
  | UIDENT v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_UIDENT) v
  | TYPE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_TYPE) ()
  | TRY_LWT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_TRY_LWT) ()
  | TRY -> print_value (MenhirInterpreter.T MenhirInterpreter.T_TRY) ()
  | TRUE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_TRUE) ()
  | TO -> print_value (MenhirInterpreter.T MenhirInterpreter.T_TO) ()
  | TILDE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_TILDE) ()
  | THEN -> print_value (MenhirInterpreter.T MenhirInterpreter.T_THEN) ()
  | STRUCT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_STRUCT) ()
  | STRING v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_STRING) v
  | STAR -> print_value (MenhirInterpreter.T MenhirInterpreter.T_STAR) ()
  | SIG -> print_value (MenhirInterpreter.T MenhirInterpreter.T_SIG) ()
  | SHARPSHARP -> print_value (MenhirInterpreter.T MenhirInterpreter.T_SHARPSHARP) ()
  | SHARPOP v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_SHARPOP) v
  | SHARP -> print_value (MenhirInterpreter.T MenhirInterpreter.T_SHARP) ()
  | SEMISEMI -> print_value (MenhirInterpreter.T MenhirInterpreter.T_SEMISEMI) ()
  | SEMI -> print_value (MenhirInterpreter.T MenhirInterpreter.T_SEMI) ()
  | RPAREN -> print_value (MenhirInterpreter.T MenhirInterpreter.T_RPAREN) ()
  | REC -> print_value (MenhirInterpreter.T MenhirInterpreter.T_REC) ()
  | RBRACKET -> print_value (MenhirInterpreter.T MenhirInterpreter.T_RBRACKET) ()
  | RBRACE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_RBRACE) ()
  | QUOTE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_QUOTE) ()
  | QUESTION -> print_value (MenhirInterpreter.T MenhirInterpreter.T_QUESTION) ()
  | PRIVATE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_PRIVATE) ()
  | PREFIXOP v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_PREFIXOP) v
  | PLUSEQ -> print_value (MenhirInterpreter.T MenhirInterpreter.T_PLUSEQ) ()
  | PLUSDOT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_PLUSDOT) ()
  | PLUS -> print_value (MenhirInterpreter.T MenhirInterpreter.T_PLUS) ()
  | PERCENT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_PERCENT) ()
  | P4_QUOTATION -> print_value (MenhirInterpreter.T MenhirInterpreter.T_P4_QUOTATION) ()
  | OUNIT_TEST_UNIT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_OUNIT_TEST_UNIT) ()
  | OUNIT_TEST_MODULE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_OUNIT_TEST_MODULE) ()
  | OUNIT_TEST -> print_value (MenhirInterpreter.T MenhirInterpreter.T_OUNIT_TEST) ()
  | OUNIT_BENCH_MODULE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_OUNIT_BENCH_MODULE) ()
  | OUNIT_BENCH_INDEXED -> print_value (MenhirInterpreter.T MenhirInterpreter.T_OUNIT_BENCH_INDEXED) ()
  | OUNIT_BENCH_FUN -> print_value (MenhirInterpreter.T MenhirInterpreter.T_OUNIT_BENCH_FUN) ()
  | OUNIT_BENCH -> print_value (MenhirInterpreter.T MenhirInterpreter.T_OUNIT_BENCH) ()
  | OR -> print_value (MenhirInterpreter.T MenhirInterpreter.T_OR) ()
  | OPTLABEL v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_OPTLABEL) v
  | OPEN -> print_value (MenhirInterpreter.T MenhirInterpreter.T_OPEN) ()
  | OF -> print_value (MenhirInterpreter.T MenhirInterpreter.T_OF) ()
  | OBJECT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_OBJECT) ()
  | NONREC -> print_value (MenhirInterpreter.T MenhirInterpreter.T_NONREC) ()
  | NEW -> print_value (MenhirInterpreter.T MenhirInterpreter.T_NEW) ()
  | NATIVEINT v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_NATIVEINT) v
  | MUTABLE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_MUTABLE) ()
  | MODULE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_MODULE) ()
  | MINUSGREATER -> print_value (MenhirInterpreter.T MenhirInterpreter.T_MINUSGREATER) ()
  | MINUSDOT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_MINUSDOT) ()
  | MINUS -> print_value (MenhirInterpreter.T MenhirInterpreter.T_MINUS) ()
  | METHOD -> print_value (MenhirInterpreter.T MenhirInterpreter.T_METHOD) ()
  | MATCH_LWT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_MATCH_LWT) ()
  | MATCH -> print_value (MenhirInterpreter.T MenhirInterpreter.T_MATCH) ()
  | LPAREN -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LPAREN) ()
  | LIDENT v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LIDENT) v
  | LET_LWT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LET_LWT) ()
  | LETOP v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LETOP) v
  | LET -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LET) ()
  | LESSMINUS -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LESSMINUS) ()
  | LESS -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LESS) ()
  | LBRACKETPERCENTPERCENT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETPERCENTPERCENT) ()
  | LBRACKETPERCENT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETPERCENT) ()
  | LBRACKETLESS -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETLESS) ()
  | LBRACKETGREATER -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETGREATER) ()
  | LBRACKETBAR -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETBAR) ()
  | LBRACKETATATAT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETATATAT) ()
  | LBRACKETATAT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETATAT) ()
  | LBRACKETAT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LBRACKETAT) ()
  | LBRACKET -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LBRACKET) ()
  | LBRACELESS -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LBRACELESS) ()
  | LBRACE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LBRACE) ()
  | LAZY -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LAZY) ()
  | LABEL v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_LABEL) v
  | JSNEW -> print_value (MenhirInterpreter.T MenhirInterpreter.T_JSNEW) ()
  | INT64 v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_INT64) v
  | INT32 v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_INT32) v
  | INT v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_INT) v
  | INITIALIZER -> print_value (MenhirInterpreter.T MenhirInterpreter.T_INITIALIZER) ()
  | INHERIT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_INHERIT) ()
  | INFIXOP4 v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_INFIXOP4) v
  | INFIXOP3 v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_INFIXOP3) v
  | INFIXOP2 v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_INFIXOP2) v
  | INFIXOP1 v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_INFIXOP1) v
  | INFIXOP0 v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_INFIXOP0) v
  | INCLUDE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_INCLUDE) ()
  | IN -> print_value (MenhirInterpreter.T MenhirInterpreter.T_IN) ()
  | IF -> print_value (MenhirInterpreter.T MenhirInterpreter.T_IF) ()
  | GREATERRBRACKET -> print_value (MenhirInterpreter.T MenhirInterpreter.T_GREATERRBRACKET) ()
  | GREATERRBRACE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_GREATERRBRACE) ()
  | GREATERDOT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_GREATERDOT) ()
  | GREATER -> print_value (MenhirInterpreter.T MenhirInterpreter.T_GREATER) ()
  | FUNCTOR -> print_value (MenhirInterpreter.T MenhirInterpreter.T_FUNCTOR) ()
  | FUNCTION -> print_value (MenhirInterpreter.T MenhirInterpreter.T_FUNCTION) ()
  | FUN -> print_value (MenhirInterpreter.T MenhirInterpreter.T_FUN) ()
  | FOR_LWT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_FOR_LWT) ()
  | FOR -> print_value (MenhirInterpreter.T MenhirInterpreter.T_FOR) ()
  | FLOAT v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_FLOAT) v
  | FINALLY_LWT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_FINALLY_LWT) ()
  | FALSE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_FALSE) ()
  | EXTERNAL -> print_value (MenhirInterpreter.T MenhirInterpreter.T_EXTERNAL) ()
  | EXITPOINT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_EXITPOINT) ()
  | EXCEPTION -> print_value (MenhirInterpreter.T MenhirInterpreter.T_EXCEPTION) ()
  | EQUAL -> print_value (MenhirInterpreter.T MenhirInterpreter.T_EQUAL) ()
  | EOL -> print_value (MenhirInterpreter.T MenhirInterpreter.T_EOL) ()
  | EOF -> print_value (MenhirInterpreter.T MenhirInterpreter.T_EOF) ()
  | END -> print_value (MenhirInterpreter.T MenhirInterpreter.T_END) ()
  | ELSE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_ELSE) ()
  | DOWNTO -> print_value (MenhirInterpreter.T MenhirInterpreter.T_DOWNTO) ()
  | DOTTILDE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_DOTTILDE) ()
  | DOTLESS -> print_value (MenhirInterpreter.T MenhirInterpreter.T_DOTLESS) ()
  | DOTDOT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_DOTDOT) ()
  | DOT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_DOT) ()
  | DONE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_DONE) ()
  | DO -> print_value (MenhirInterpreter.T MenhirInterpreter.T_DO) ()
  | CUSTOM_BANG -> print_value (MenhirInterpreter.T MenhirInterpreter.T_CUSTOM_BANG) ()
  | CONSTRAINT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_CONSTRAINT) ()
  | COMMENT v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_COMMENT) v
  | COMMA -> print_value (MenhirInterpreter.T MenhirInterpreter.T_COMMA) ()
  | COLONGREATER -> print_value (MenhirInterpreter.T MenhirInterpreter.T_COLONGREATER) ()
  | COLONEQUAL -> print_value (MenhirInterpreter.T MenhirInterpreter.T_COLONEQUAL) ()
  | COLONCOLON -> print_value (MenhirInterpreter.T MenhirInterpreter.T_COLONCOLON) ()
  | COLON -> print_value (MenhirInterpreter.T MenhirInterpreter.T_COLON) ()
  | CLASS -> print_value (MenhirInterpreter.T MenhirInterpreter.T_CLASS) ()
  | CHAR v -> print_value (MenhirInterpreter.T MenhirInterpreter.T_CHAR) v
  | BEGIN -> print_value (MenhirInterpreter.T MenhirInterpreter.T_BEGIN) ()
  | BARRBRACKET -> print_value (MenhirInterpreter.T MenhirInterpreter.T_BARRBRACKET) ()
  | BARBAR -> print_value (MenhirInterpreter.T MenhirInterpreter.T_BARBAR) ()
  | BAR -> print_value (MenhirInterpreter.T MenhirInterpreter.T_BAR) ()
  | BANG -> print_value (MenhirInterpreter.T MenhirInterpreter.T_BANG) ()
  | BACKQUOTE -> print_value (MenhirInterpreter.T MenhirInterpreter.T_BACKQUOTE) ()
  | ASSERT -> print_value (MenhirInterpreter.T MenhirInterpreter.T_ASSERT) ()
  | AS -> print_value (MenhirInterpreter.T MenhirInterpreter.T_AS) ()
  | AND -> print_value (MenhirInterpreter.T MenhirInterpreter.T_AND) ()
  | AMPERSAND -> print_value (MenhirInterpreter.T MenhirInterpreter.T_AMPERSAND) ()
  | AMPERAMPER -> print_value (MenhirInterpreter.T MenhirInterpreter.T_AMPERAMPER) ()
