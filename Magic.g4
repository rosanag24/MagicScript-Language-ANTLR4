grammar Magic;

/*starting Parser */

main:   functions EOF;

functions: (function_list+= function)* main_aberto?;
main_aberto: T_INT ABERTO '(' ')' NEWLINE* block;
function: type ALOHOMORA VAR '('declaration?')' block;

type:   T_INT | T_FLOAT | T_DOUBLE | T_BOOL | T_STRING | T_VOID ;

block: NEWLINE*'{' NEWLINE* (statementList+=stmt)* NEWLINE*'}'NEWLINE*;

/*general statements */
stmt: assignment_stmt
    | if_stmt
    | print_stmt
    | itfor_stmt
    | return_stmt
    | inequalities;


/*assignation statements */
assignment_stmt:VAR '=' (VAR|INT|FLOAT|BOOLEANO|NULL|CHAR|STRING)
                | declaration '=' (VAR|INT|FLOAT|BOOLEANO|NULL|CHAR|STRING)
                | declaration '=' expr
                | VAR '=' expr;

autoincrement_stmt: declaration '+=' expr;
decrement_stm:  declaration '-=' expr;

/* return statement */
return_stmt:  REDITUS '('expr')'
            | REDITUS ;

/*boolean statements */
bool_stmt:  inequalities
            | bool_expr;
            
inequalities: data '<' data
            | data '<=' data
            | data '>' data
            | data '>=' data
            | data '==' data
            | data '!=' data;

bool_expr:  bool_expr '^' bool_expr
            | bool_expr (AND|OR) bool_expr
            | NOT bool_expr
            | TRUE
            | FALSE;

data: VAR | INT | FLOAT|'('data')'| expr ;

/*if-elif-else statements */
if_stmt: IF '(' bool_stmt ')' block
        |IF '(' bool_stmt ')' block (opt+= elif_stmt)* ELSE block;
elif_stmt: ELIF '(' bool_stmt ')' block;

/* Iterative For statement */
itfor_stmt: FOCUS VAR IN (array | VAR) block 
            | FOCUS declaration IN (array|VAR) block;

/* variables declaration */
declaration: type VAR (dek+=declare)*;
declare:    ',' declaration;


/* aritmethic expression */

expr: expr '^' expr
    | expr ('*'|'/'|'%') expr
    | expr ('+'|'-') expr
    | INT
    | FLOAT
    | VAR;

/* array */
array: '[' (VAR|INT|FLOAT|BOOLEANO|NULL|CHAR|STRING|NULL)* ']';

/* print statement */
print_stmt: PRINT '('VAR?')'
            | PRINT '('STRING (varlist+=print_var_list)* ')';
print_var_list: ',' VAR;

/*starting Lexer */
ABERTO:     'aberto';
ALOHOMORA:  'alohomora';
FOCUS:      'focus';
IN:         'in';
GEMINIO:    'geminio';
TURNER:     'turner';
FINITE:     'finite'; /*break*/
REDITUS:    'reditus';
AVADAKEDAVRA:   'avadakedavra';
SALTUS:     'saltus';
PRINT:      'print';
OR:         'or';
AND:        'and';
NOT:        'not';
INT:        [0-9]|[1-9][0-9]+;
FLOAT:      [0-9]+'.'[0-9]*;
TRUE:       'True';
FALSE:      'False';
CHAR:       '\'.\'';
STRING:     '"'(~["])+'"';
NEWLINE:    '\r'?'\n';
BOOLEANO:   TRUE|FALSE;
IF:         'if';
ELSE:       'else';
ELIF:       'elif';
T_INT:      'int';
T_FLOAT:    'float';
T_DOUBLE:   'double';
T_STRING:   'string';
NULL:       ('null'|'Null');
T_VOID:     'void';
T_BOOL:     'bool';
VAR:        [a-zA-Z_] [a-zA-Z_0-9]*;
WHITESPACE :( '\t' | ' ' | '\r' | '\n'| '\u000C' )+ -> skip ;