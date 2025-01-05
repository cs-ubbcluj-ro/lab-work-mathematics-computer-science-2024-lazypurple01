%{
#include "y.tab.h"
%}

%%

"if"          { return IF; }
"for"         { return FOR; }
"while"       { return WHILE; }
"return"      { return RETURN; }

"<"           { return LESS; }
">"           { return GREATER; }
"=="          { return EQUAL; }
"!="          { return NOTEQUAL; }
"+"           { return PLUS; }
"-"           { return MINUS; }
"*"           { return MULTIPLY; }
"/"           { return DIVIDE; }
"%"           { return MODULO; }
"("           { return LPAREN; }
")"           { return RPAREN; }
"{"           { return LBRACE; }
"}"           { return RBRACE; }
";"           { return SEMICOLON; }
"="           { return ASSIGN; }

[0-9]+        { yylval = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval = strdup(yytext); return IDENTIFIER; }

[ \t\n]       { /* Ignore whitespace */ }
.             { printf("Unknown character: %s\n", yytext); exit(1); }

%%

int yywrap() {
    return 1;
}
