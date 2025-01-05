%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;

void yyerror(const char *s);
%}

%token NUMBER IDENTIFIER
%token IF FOR WHILE RETURN
%token LESS GREATER EQUAL NOTEQUAL
%token PLUS MINUS MULTIPLY DIVIDE MODULO
%token LPAREN RPAREN LBRACE RBRACE SEMICOLON ASSIGN

%%

program:
    function { printf("Program syntactic correct\n"); }
    ;

function:
    IDENTIFIER LPAREN RPAREN LBRACE statements RBRACE { printf("Rule 1: Function definition\n"); }
    ;

statements:
    statements statement { printf("Rule 2: Multiple statements\n"); }
  | statement            { printf("Rule 3: Single statement\n"); }
  ;

statement:
    assignment SEMICOLON { printf("Rule 4: Assignment statement\n"); }
  | loop                 { printf("Rule 5: Loop statement\n"); }
  | conditional          { printf("Rule 6: Conditional statement\n"); }
  | RETURN expression SEMICOLON { printf("Rule 7: Return statement\n"); }
  ;

assignment:
    IDENTIFIER ASSIGN expression { printf("Rule 8: Assignment\n"); }
    ;

loop:
    FOR LPAREN assignment SEMICOLON condition SEMICOLON assignment RPAREN statement { printf("Rule 9: For loop\n"); }
  | WHILE LPAREN condition RPAREN statement                                          { printf("Rule 10: While loop\n"); }
  ;

conditional:
    IF LPAREN condition RPAREN statement { printf("Rule 11: If statement\n"); }
    ;

condition:
    expression LESS expression     { printf("Rule 12: Less than condition\n"); }
  | expression GREATER expression  { printf("Rule 13: Greater than condition\n"); }
  | expression EQUAL expression    { printf("Rule 14: Equality condition\n"); }
  | expression NOTEQUAL expression { printf("Rule 15: Inequality condition\n"); }
  ;

expression:
    expression PLUS term    { printf("Rule 16: Addition\n"); }
  | expression MINUS term   { printf("Rule 17: Subtraction\n"); }
  | term                    { printf("Rule 18: Single term\n"); }
  ;

term:
    term MULTIPLY factor    { printf("Rule 19: Multiplication\n"); }
  | term DIVIDE factor      { printf("Rule 20: Division\n"); }
  | term MODULO factor      { printf("Rule 21: Modulo\n"); }
  | factor                  { printf("Rule 22: Single factor\n"); }
  ;

factor:
    NUMBER                  { printf("Rule 23: Number\n"); }
  | IDENTIFIER              { printf("Rule 24: Variable\n"); }
  | LPAREN expression RPAREN { printf("Rule 25: Parenthesized expression\n"); }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
