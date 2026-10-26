module.exports = grammar({
  name: 'autohotkey',

  word: $ => $.identifier,

  extras: $ => [
    /\s/,
  ],

  conflicts: $ => [
    [$.parameter, $._expression],
    [$.parameter, $.assignment_expression],
    [$.parameter, $._argument_rhs, $.assignment_expression],  // func(x := val)
    [$.variable_ref, $._expression],
    [$.loop_statement, $._statement],
    [$.catch_clause, $._statement],
    [$.else_clause, $._statement],
    [$._expression, $._concat_element],
    [$.function_definition, $.function_call],
  ],

  externals: $ => [
    $._statement_end,
  ],

  rules: {
    source_file: $ => repeat($._statement),

    _statement: $ => choice(
      $.comment,
      $.doc_comment,
      $.block_comment,
      $.if_directive,
      $.directive,
      $.hotkey,
      $.hotstring_definition,
      $.label,
      $.class_definition,
      $.function_definition,
      prec(1, $.statement_block),
      $.if_statement,
      $.while_statement,
      $.loop_statement,
      $.for_statement,
      $.try_statement,
      $.switch_statement,
      $.return_statement,
      $.throw_statement,
      $.assignment_expression,
      $.method_call,
      $.member_expression,
      $.index_expression,
      $.function_call,
      $.fat_arrow_function,
      $.parenthesized_expression,
      $.array_literal,
      $.string,
      $.number,
      $.boolean,
      $.keyword,
      prec(4, $.variable_ref),
      $.identifier,
      $._punctuation,
    ),

    comment: $ => seq(
      ';',
      /.*/
    ),

    block_comment: $ => seq(
      '/*',
      /[^*]*\*+([^/*][^*]*\*+)*/,
      '/'
    ),

    doc_comment: $ => seq(
      '/**',
      /[^*]*\*+([^/*][^*]*\*+)*/,
      '/'
    ),

    directive: $ => seq(
      '#',
      field('name', $.identifier),
      optional(field('arguments', $.directive_arguments))
    ),

    directive_arguments: $ => token.immediate(prec(5, /[, \t]+[^\s;][^;\n]*/)),

    if_directive: $ => choice(
      prec.right(6, seq(
        '#',
        token.immediate(/[Hh][Oo][Tt][Ii][Ff][ \t]+|[Ii][Ff][ \t]+/),
        field('condition', $._expression)
      )),
      prec.right(5, seq(
        '#',
        token.immediate(/[Hh][Oo][Tt][Ii][Ff]|[Ii][Ff]/)
      ))
    ),

    hotkey: $ => token(prec(5, seq(
      optional(/[#!^+<>*~$]+/),
      /[a-zA-Z0-9]+/,
      '::'
    ))),

    hotstring_definition: $ => seq(
      ':',
      optional(field('options', $.hotstring_options)),
      ':',
      field('trigger', $.hotstring_trigger),
      '::',
      optional(field('replacement', $.hotstring_replacement))
    ),

    hotstring_options: $ => token.immediate(/[*?a-zA-Z0-9]+/),
    hotstring_trigger: $ => token(/[^:\r\n]+/),
    hotstring_replacement: $ => token.immediate(/[^\r\n]+/),

    label: $ => seq(
      field('name', $.identifier),
      token.immediate(':')
    ),

    block: $ => repeat1($._statement),

    parenthesized_expression: $ => prec.dynamic(2, seq('(', $._expression, ')')),

    statement_block: $ => seq('{', optional($.block), '}'),

    if_statement: $ => prec.right(seq(
      'if',
      field('condition', seq(
        $.parenthesized_expression,
        repeat(seq(choice('&&', '||', 'and', 'or'), $.parenthesized_expression))
      )),
      field('consequence', choice($.statement_block, $._statement)),
      optional(field('alternative', $.else_clause))
    )),

    else_clause: $ => seq(
      'else',
      choice($.if_statement, $.statement_block, $._statement)
    ),

    while_statement: $ => seq(
      'while',
      field('condition', $.parenthesized_expression),
      field('body', choice($.statement_block, $._statement))
    ),

    loop_statement: $ => prec.right(seq(
      'loop',
      optional(choice(
        seq(
          field('type', $.loop_type),
          optional(field('arguments', $.loop_arguments))
        ),
        field('count', choice($.number, $.identifier))
      )),
      field('body', choice($.statement_block, $._statement))
    )),

    loop_type: $ => choice('parse', 'Parse', 'files', 'Files', 'read', 'Read', 'reg', 'Reg'),

    loop_arguments: $ => /[^\r\n{]+/,

    for_statement: $ => seq(
      'for',
      field('key', $.identifier),
      optional(seq(',', field('value', $.identifier))),
      'in',
      field('collection', $._expression),
      field('body', choice($.statement_block, $._statement))
    ),

    try_statement: $ => prec.right(seq(
      'try',
      field('body', choice($.statement_block, $._statement)),
      optional($.catch_clause),
      optional($.finally_clause)
    )),

    catch_clause: $ => seq(
      'catch',
      optional(choice(
        seq(field('type', $.identifier), 'as', field('exception', $.identifier)),
        seq('as', field('exception', $.identifier)),
        field('exception', $.identifier)
      )),
      field('body', choice($.statement_block, $._statement))
    ),

    finally_clause: $ => seq(
      'finally',
      field('body', choice($.statement_block, $._statement))
    ),

    switch_statement: $ => seq(
      'switch',
      optional(field('value', $._expression)),
      '{',
      repeat($.case_clause),
      optional($.default_clause),
      '}'
    ),

    case_clause: $ => seq(
      'case',
      field('values', seq($._expression, repeat(seq(',', $._expression)))),
      ':',
      optional($.block)
    ),

    default_clause: $ => seq(
      'default',
      ':',
      optional($.block)
    ),

    function_definition: $ => prec.dynamic(10, seq(
      field('name', $.identifier),
      token.immediate('('),
      optional($.parameter_list),
      ')',
      '{',
      optional(field('body', $.block)),
      '}'
    )),

    class_definition: $ => prec.dynamic(10, seq(
      'class',
      field('name', $.identifier),
      optional(seq('extends', field('parent', $.identifier))),
      '{',
      repeat($.class_member),
      '}'
    )),

    class_member: $ => choice(
      $.comment,
      $.doc_comment,
      $.block_comment,
      $.class_definition,
      $.method_definition,
      $.class_property,
    ),

    method_definition: $ => prec.dynamic(10, seq(
      optional('static'),
      field('name', $.identifier),
      token.immediate('('),
      optional($.parameter_list),
      ')',
      '{',
      optional(field('body', $.block)),
      '}'
    )),

    class_property: $ => seq(
      optional('static'),
      field('name', $.identifier),
      optional(choice(
        seq(':=', field('value', $._expression)),
        seq('=>', field('body', $._expression))
      ))
    ),

    function_call: $ => prec.dynamic(5, seq(
      field('name', $.identifier),
      token.immediate('('),
      optional($.argument_list),
      ')'
    )),

    member_expression: $ => prec.left(1, seq(
      field('object', choice($.identifier, $.member_expression, $.this_expression, $.super_expression)),
      token.immediate('.'),
      field('property', choice($.identifier, $.number))
    )),

    method_call: $ => prec(3, prec.left(2, seq(
      field('object', choice($.identifier, $.member_expression, $.this_expression, $.super_expression)),
      token.immediate('.'),
      field('method', $.identifier),
      token.immediate('('),
      optional($.argument_list),
      ')'
    ))),

    fat_arrow_function: $ => prec.right(2, choice(
      seq(
        field('name', $.identifier),
        token.immediate('('),
        optional($.parameter_list),
        ')',
        '=>',
        field('body', $._expression)
      ),
      seq(
        '(',
        optional($.parameter_list),
        ')',
        '=>',
        field('body', $._expression)
      ),
      seq(
        field('name', $.identifier),
        '=>',
        field('body', $._expression)
      )
    )),

    parameter_list: $ => seq(
      $.parameter,
      repeat(seq(',', $.parameter))
    ),

    parameter: $ => seq(
      optional(field('modifier', alias('&', $.parameter_modifier))),
      field('name', $.identifier),
      optional(field('variadic', alias('*', $.parameter_variadic))),
      optional(prec.right(1, seq(':=', field('default', $._expression))))
    ),

    _argument: $ => choice(
      prec(12, alias($._argument_assignment_expression, $.assignment_expression)),
      prec(11, $._string_identifier_concat),
      prec(11, $._identifier_string_concat),
      $._expression
    ),

    _argument_rhs: $ => choice(
      prec(11, $._identifier_string_concat),
      prec(11, $._string_identifier_concat),
      $._expression
    ),

    _argument_assignment_expression: $ => prec.right(1, seq(
      field('left', choice($.identifier, $.member_expression, $.index_expression)),
      field('operator', choice(':=', '+=', '-=', '*=', '/=', '.=', '||=', '&&=', '??=')),
      field('right', $._argument_rhs)
    )),

    argument_list: $ => seq(
      $._argument,
      repeat(seq(',', $._argument))
    ),

    _expression: $ => choice(
      $.concatenation_expression,
      $.ternary_expression,
      $.binary_expression,
      $.unary_expression,
      $.assignment_expression,
      $.this_expression,
      $.super_expression,
      $.string,
      $.number,
      $.boolean,
      $.variable_ref,
      $.array_literal,
      $.object_literal,
      $.index_expression,
      $.member_expression,
      $.method_call,
      $.identifier,
      $.function_call,
      $.fat_arrow_function,
      $.parenthesized_expression,
    ),

    _concat_element: $ => choice(
      $.string,
      $.number,
      $.variable_ref,
      $.function_call,
      $.method_call,
      $.parenthesized_expression,
    ),

    concatenation_expression: $ => prec.left(10, seq(
      choice($._concat_element, $.concatenation_expression),
      choice($.string, $.number, $.variable_ref, $.parenthesized_expression)
    )),

    _string_identifier_concat: $ => prec.left(10, seq(
      choice($.string, $.member_expression),
      repeat(choice($._concat_element, $.identifier, $.member_expression)),
      choice($.identifier, $.member_expression)
    )),

    _identifier_string_concat: $ => prec.left(10, seq(
      choice($.identifier, $.member_expression),
      $.string,
      repeat(choice($._concat_element, $.identifier, $.member_expression))
    )),

    _ternary_branch: $ => choice(
      prec(11, $._identifier_string_concat),
      $._expression
    ),

    ternary_expression: $ => prec.right(1, seq(
      field('condition', $._expression),
      '?',
      field('consequence', $._ternary_branch),
      ':',
      field('alternative', $._ternary_branch)
    )),

    binary_expression: $ => choice(
      prec.left(2, seq(field('left', $._expression), choice('||', 'or'), field('right', $._expression))),
      prec.left(3, seq(field('left', $._expression), choice('&&', 'and'), field('right', $._expression))),
      prec.left(2, seq(field('left', $._expression), '??', field('right', $._expression))),
      prec.left(4, seq(field('left', $._expression), '|', field('right', $._expression))),
      prec.left(5, seq(field('left', $._expression), '^', field('right', $._expression))),
      prec.left(6, seq(field('left', $._expression), '&', field('right', $._expression))),
      prec.left(7, seq(field('left', $._expression), choice('=', '==', '!='), field('right', $._expression))),
      prec.left(8, seq(field('left', $._expression), choice('<', '>', '<=', '>='), field('right', $._expression))),
      prec.left(9, seq(field('left', $._expression), choice('<<', '>>'), field('right', $._expression))),
      prec.left(10, seq(field('left', $._expression), choice('+', '-'), field('right', $._expression))),
      prec.left(11, seq(field('left', $._expression), choice('*', '/', '//', '%'), field('right', $._expression))),
      prec.left(10, seq(field('left', $._expression), '.', field('right', $._expression))),
      prec.right(12, seq(field('left', $._expression), '**', field('right', $._expression))),
    ),

    unary_expression: $ => prec(13, choice(
      seq('&', $._expression),
      seq('!', $._expression),
      seq('not', $._expression),
      seq('~', $._expression),
      seq('-', $._expression),
      seq('+', $._expression),
    )),

    assignment_expression: $ => prec.right(1, seq(
      field('left', choice($.identifier, $.member_expression, $.index_expression)),
      field('operator', choice(':=', '+=', '-=', '*=', '/=', '.=', '||=', '&&=', '??=')),
      field('right', $._expression)
    )),

    this_expression: $ => 'this',
    super_expression: $ => 'super',

    boolean: $ => choice('true', 'false'),

    array_literal: $ => prec(2, seq(
      '[',
      optional(seq(
        $._expression,
        repeat(seq(',', $._expression))
      )),
      ']'
    )),

    object_literal: $ => prec(2, seq(
      '{',
      optional(seq(
        $.object_property,
        repeat(seq(',', $.object_property))
      )),
      '}'
    )),

    object_property: $ => choice(
      seq(
        field('key', choice($.identifier, $.string, $.number)),
        ':',
        field('value', $._expression)
      ),
      field('key', $.identifier)
    ),

    index_expression: $ => prec.left(1, seq(
      field('object', choice($.identifier, $.member_expression, $.index_expression, $.this_expression, $.super_expression)),
      token.immediate('['),
      field('index', choice($._string_identifier_concat, $._identifier_string_concat, $._expression)),
      ']'
    )),

    string: $ => choice(
      seq('"', repeat(choice($.escape_sequence, /[^"`]+/)), '"'),
      seq("'", repeat(choice($.escape_sequence, /[^'`]+/)), "'"),
    ),

    escape_sequence: $ => token(seq(
      '`',
      choice('n', 't', 'r', '`', '"', "'", 'a', 'b', 'f', 'v', 's')
    )),

    number: $ => choice(
      /0[xX][0-9a-fA-F]+/,
      /\d+\.\d+/,
      /\d+/,
    ),

    return_statement: $ => prec.right(choice(
      seq('return', $._statement_end),
      seq('return', $._expression),
      'return',
    )),

    throw_statement: $ => prec.right(seq(
      'throw',
      optional($._expression)
    )),

    variable_ref: $ => seq('%', $.identifier, '%'),

    keyword: $ => choice(
      'break', 'continue', 'goto',
      'global', 'local', 'static',
      'unset',
    ),

    identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]*/,

    _punctuation: $ => /[.@$\\]+/,
  }
});