%{
#include <iostream>
#include <string>
#include <locale>

std::locale loc;
std::string toUpper(std::string);

%}

%option noyywrap
%option outfile="pylex.cpp"

DIGIT [0-9]
NONZERODIGIT [1-9]

KEYWORD (False|class|finally|is|return|None|continue|for|lambda|try|True|def|from|nonlocal|while|and|del|global|not|with|as|elif|if|or|yield|assert|else|import|pass|break|except|in|raise)

%%

{KEYWORD} 	std::cout << toUpper(yytext);
{NONZERODIGIT}+{DIGIT}* 	std::cout << "'eto eh un numero: " << yytext;

%%

std::string toUpper(std::string original) {
	for (std::string::size_type i=0; i<original.length(); ++i)
    	original[i] = std::toupper(original[i],loc);
    return original;
}

int main(int argc, char *argv[]){
    extern FILE* yyin;
    yyin=fopen(argv[1],"r");
    yylex();
}