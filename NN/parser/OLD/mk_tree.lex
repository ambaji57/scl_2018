%option nounput
%option noinput
%%
\<      {printf("[");}
\>      {printf("]");}
[^<>\-]+        {printf("[.%s ]",yytext);}
\-      {}
%%
int main()
{
printf("\\documentclass[a4paper]{article}\n");
printf("\\usepackage{fontspec}\n");
//printf("\\setmainfont[Script=Devanagari]{Sanskrit 2003}\n");
printf("\\usepackage{qtree}\n");
printf("\\begin{document}\n");
printf("\\tiny\n");
printf("\\qsetw{0.05in}\n");
printf("\\Tree");
			yylex();
printf("\\end{document}");
return 1;
}
