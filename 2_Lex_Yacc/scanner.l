%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_SYMBOLS 100

char *symbol_table[MAX_SYMBOLS];
int symbol_count = 0;
%}

%option noyywrap

DIGIT       [0-9]
ID          [a-zA-Z_][a-zA-Z0-9_]*
KEYWORD     (int|float|char|return|if|else)
OPERATOR    (\+|\-|\*|\/|\=|\+\+|\-\-|\<|\>|\<=|\>=|\==|\!=)
DELIMITER   [\(\)\[\]\{\};,]
STRING      \"[^\"]*\"
COMMENT     (\/\/[^\n]*|\/\*.*?\*\/)

%%
  
{KEYWORD} {
    printf("Keyword: %s\n", yytext); 
    
}

{ID} {
    
    int found = 0;
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbol_table[i], yytext) == 0) {
            found = 1;
            break;
        }
    }

    if (!found && symbol_count < MAX_SYMBOLS) {
        symbol_table[symbol_count] = strdup(yytext);  
        symbol_count++;
    }

    printf("Identifier: %s\n", yytext);
}

{DIGIT}+(\.{DIGIT}*)?([eE][+-]?{DIGIT}*)? {
    printf("Number: %s\n", yytext);  }

{OPERATOR} {
    printf("Operator: %s\n", yytext);  }

{DELIMITER} {
    printf("Delimiter: %s\n", yytext);  }

{STRING} {
    printf("String: %s\n", yytext);  }

{COMMENT} {
    }

. {
    printf("Lexical Error: Invalid token '%s'\n", yytext);
}

%%

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <source_file>\n", argv[0]);
        return 1;
    }

    FILE *source_file = fopen(argv[1], "r");
    if (!source_file) {
        perror("Error opening file");
        return 1;
    }

    yyin = source_file;  
    yylex();  

    printf("\nSymbol Table:\n");
    for (int i = 0; i < symbol_count; i++) {
        printf("%s\n", symbol_table[i]);
    }

    fclose(source_file);
    return 0;
}
