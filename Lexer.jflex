/*
 * INTEGRANTES:
 * 1. Cancelada de la O Gerardo Alexander
 * 2. Castellanos Hernández Alan
 * 3. Lara Jiménez Pablo César
 * 4. Medina Robledo Brandon Ernie
 */

import java_cup.runtime.Symbol;

%%

%class Lexer
%public
%unicode
%cup
%line
%column

%{
  private Symbol token(int type) {
    System.out.println("Linea " + (yyline + 1) + ", Columna " + (yycolumn + 1) + " -> Token: " + yytext() + " [ID: " + type + "]");
    return new Symbol(type, yyline + 1, yycolumn + 1, yytext());
  }

  private Symbol error(String descripcion) {
    System.out.println(">>> ERROR LEXICO en Linea " + (yyline + 1) + ", Columna " + (yycolumn + 1) + ": " + descripcion + " ('" + yytext() + "')");
    return new Symbol(sym.ERROR_LEXICO, yyline + 1, yycolumn + 1, yytext());
  }
%}

// Macros
LineTerminator = \r|\n|\r\n
WhiteSpace     = {LineTerminator} | [ \t\f]
Letra          = [a-zA-Z_]
Digito         = [0-9]
Id             = {Letra}({Letra}|{Digito})*

// Comentarios
Comment = "//".* | "/*" [^*]* ~"*/"

// Patrones de Errores Léxicos
IdMalFormado       = {Digito}+{Letra}+({Letra}|{Digito})*
NumeroMalFormado   = {Digito}+\.{Digito}+\.[0-9.]+
CadenaSinCerrar    = \"([^\"\\\n\r]|\\.)*

%%

{Comment}        { /* Ignorar */ }
{WhiteSpace}     { /* Ignorar */ }

// Directivas (atrapa "#include <iostream>" completo y "#include")
"#"[a-zA-Z_]+[ \t]*[<\"].+[>\"}] { return token(sym.DIRECTIVA); }
"#"[a-zA-Z_]+                      { return token(sym.DIRECTIVA); }

// Palabras reservadas
"package"        { return token(sym.PACKAGE); }
"if"             { return token(sym.IF); }
"else"           { return token(sym.ELSE); }
"while"          { return token(sym.WHILE); }
"for"            { return token(sym.FOR); }
"do"             { return token(sym.DO); }
"return"         { return token(sym.RETURN); }
"int"            { return token(sym.INT); }
"float"          { return token(sym.FLOAT); }
"double"         { return token(sym.DOUBLE); }
"char"           { return token(sym.CHAR); }
"bool"           { return token(sym.BOOL); }
"void"           { return token(sym.VOID); }
"class"          { return token(sym.CLASS); }
"struct"         { return token(sym.STRUCT); }
"public"         { return token(sym.PUBLIC); }
"private"        { return token(sym.PRIVATE); }
"using"          { return token(sym.USING); }
"namespace"      { return token(sym.NAMESPACE); }

// Operadores
"::" | "->"      { return token(sym.OP_ACCESO); }
"&&"             { return token(sym.OP_AND); }
"||"             { return token(sym.OP_OR); }
"!"              { return token(sym.OP_NOT); }
"=="             { return token(sym.OP_IGUAL); }
"!="             { return token(sym.OP_DISTINTO); }
"<="             { return token(sym.OP_MENOR_IGUAL); }
">="             { return token(sym.OP_MAYOR_IGUAL); }
"<"              { return token(sym.OP_MENOR); }
">"              { return token(sym.OP_MAYOR); }
"++"             { return token(sym.OP_INC); }
"--"             { return token(sym.OP_DEC); }
"+"              { return token(sym.OP_SUMA); }
"-"              { return token(sym.OP_RESTA); }
"*"              { return token(sym.OP_MULT); }
"/"              { return token(sym.OP_DIV); }
"%"              { return token(sym.OP_MOD); }
"="              { return token(sym.OP_ASIG); }
"+="             { return token(sym.OP_ASIG_SUMA); }
"-="             { return token(sym.OP_ASIG_RESTA); }

// Delimitadores y agrupación
"."              { return token(sym.PUNTO); }
"("              { return token(sym.PAR_A); }
")"              { return token(sym.PAR_C); }
"{"              { return token(sym.LLAVE_A); }
"}"              { return token(sym.LLAVE_C); }
"["              { return token(sym.CORCH_A); }
"]"              { return token(sym.CORCH_C); }
";"              { return token(sym.PUNTO_COMA); }
","              { return token(sym.COMA); }
":"              { return token(sym.DOS_PUNTOS); }

// Literales
\"([^\"\\\n\r]|\\.)*\"  { return token(sym.CADENA); }
\'([^\'\\\n\r]|\\.)\'   { return token(sym.CARACTER); }
{Digito}+\.{Digito}+[fF]? { return token(sym.FLOTANTE); }
{Digito}+               { return token(sym.ENTERO); }

// Identificadores válidos
{Id}                    { return token(sym.ID); }

// Manejo de errores léxicos
{CadenaSinCerrar}       { return error("Cadena de texto sin comilla de cierre"); }
{NumeroMalFormado}      { return error("Literal numerico incorrecto (multiples puntos)"); }
{IdMalFormado}          { return error("Identificador mal formado (inicia con digitos)"); }
.                       { return error("Caracter no reconocido"); }