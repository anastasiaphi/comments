/* варіант 16 */
%{
#include <stdio.h>
int single_count = 0;
int multi_count = 0;
%}

%option noyywrap
%x SINGLE MULTI

%%
\"[^"\n]*\"     { }   /* пропускаємо текст у лапках */
"//"            { single_count++; BEGIN(SINGLE); }
"/*"            { multi_count++;  BEGIN(MULTI); }
.|\n            { }

<SINGLE>\n      { BEGIN(INITIAL); }
<SINGLE>.       { }

<MULTI>"*/"     { BEGIN(INITIAL); }
<MULTI>.|\n     { }
%%

int main()
{
    yylex();
    printf("однорядкових: %d\n", single_count);
    printf("багаторядкових: %d\n", multi_count);
    printf("всього: %d\n", single_count + multi_count);
    return 0;
}