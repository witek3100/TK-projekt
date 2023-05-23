grammar PWN;

@header {
package ;
}

program 
    : statement+ 
    ;

statement 
    : functionDefinition | assignment | declaration | returnStatement | ifStatement | whileStatement | forStatement 
    ;

loopStatement
    : statement | (BREAK SEMICOLON) | (CONTINUE SEMICOLON) 
    ;

declaration
    : ID COLON type ASSIGN expression SEMICOLON 
    ;

assignment
    : ID ((ASSIGN | ADDASSIGN | SUBASSIGN) expression) | (INCREMENT | DECREMENT) SEMICOLON
    ;

returnStatement
    : RETURN expression? SEMICOLON 
    ;

ifStatement
    : IF LPAR logicalExpression RPAR LBRACE statement* RBRACE (ELIF LPAR logicalExpression RPAR LBRACE statement* RBRACE)* (ELSE LBRACE statement* RBRACE)?
    ;

whileStatement
    : WHILE LPAR logicalExpression RPAR LBRACE loopStatement* RBRACE
    ;

iterable
    : RANGE | ID
    ;

forStatement 
    : FOR LPAR ID COLON type IN iterable RPAR LBRACE loopStatement* RBRACE
    ;
 
functionDefinition
    : FN ID LPAR argumentsDefinition RPAR (ARROW type)? LBRACE statement* RBRACE
    ;

argumentsDefinition
    : ((ID COLON type)(COMMA ID COLON type)*)?
    ;

arguments
    : (expression (COMMA expression)*)?
    ;

functionCall
    : ID LPAR arguments RPAR
    ;

type
    : normalType | arrayType
    ;

normalType
    : KW_INT | KW_FLOAT | KW_DOUBLE | KW_STRING | KW_BOOL
    ;

arrayType
    : normalType LBRACKET RBRACKET
    ;

array
    : normalType LBRACKET INDEX RBRACKET
    ;

expression
    : logicalExpression | operationExpression
    ;

logicalExpression
    : ( NOT logicalExpression ) | ( logicalExpression ( AND | OR ) logicalExpression ) | ( operationExpression ( LT | GT | LE | GE | EQ | NEQ ) operationExpression ) | ( operationExpression IN iterable ) | ( LPAR logicalExpression RPAR ) | logicalValue
    ;

operationExpression
    : ( logicalExpression (ADD | SUB | MUL | DIV) logicalExpression ) | ( LPAR operationExpression RPAR ) | value
    ;

variableValue
    : ID | ( ID LBRACKET INDEX RBRACKET )
    ;

value
    : variableValue | array | INT | FLOAT | STRING | RANGE | NULL | functionCall | ( LPAR value RPAR )
    ;

logicalValue
    : variableValue | TRUE | FALSE | ( LPAR logicalValue RPAR )
    ;





ID 
    : [a-zA-Z_][a-zA-Z0-9_]*
    ;

INT
    : ('-'|'0x'|'0b')?[0-9]+
    ;

INDEX
    : [0-9]+
    ;

FLOAT 
    : '-'?[0-9]+'.'[0-9]*
    ;

RANGE 
    : [0-9]+'..'[0-9]+ 
    ;

STRING
    : '"'[^"]*'"'
    ;

ADD : '+' ;

DIV : '/' ;

MUL : '*' ;

SUB : '-' ;

SEMICOLON : ';' ;

COLON : ':' ;

LPAR : '(' ;

RPAR : ')' ;

LBRACE : '{' ;

RBRACE : '}' ;

LBRACKET : '[' ;

RBRACKET : ']' ;

EQ : '==' ;

NEQ : '=/=' ;

ASSIGN : '=' ;

BREAK : 'break' ;

CONTINUE : 'continue' ;

ARROW : '->' ;

COMMA : ',' ;

INCREMENT : '++' ;

DECREMENT : '--';

ADDASSIGN : '+=' ;

SUBASSIGN : '-=' ;

KW_INT : 'int' ;

KW_STRING : 'string' ;

KW_FLOAT : 'float' ;

KW_DOUBLE : 'double' ;

KW_BOOL : 'bool' ;

GT : '>' ;

LT : '<' ;

GE : '>=' ;

LE : '<=' ;

ASSEMBLY : 'asm' ;

NOT : '!' ;

OR : 'or' ;

AND : 'and' ;

NULL : 'null' ;

FALSE : 'false' ;

TRUE : 'true' ;

IN : 'in' ;

IF : 'if' ;

ELIF : 'elif' ;

ELSE : 'else' ;

WHILE : 'while' ;

FOR : 'for' ;

FN : 'func' ;

RETURN : 'return' ;

WS : [ \t\n\r]+ -> skip ;