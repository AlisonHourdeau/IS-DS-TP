%{
/* Fichier expEns.lex */
#include "yygrammar.h"

char err[20]; /* Chaine de caracteres pour les erreurs de syntaxe */
%}

/* Definition de macros */
chiffre         [0-9]
lettre          [A-Z]
separateur      [ \t]

%%
\n                  {
                      yypos++;         /* Compte le nombre de lignes du fichier source */
                      return RC;       /* Indique au parser qu un retour chariot (retour à la ligne) est reconnu */
                    }
{lettre}            return LETTRE;     /* Indique au parser qu une lettre est reconnu */
{chiffre}+          return ENTIER;     /* Indique au parser qu un entier est reconnu */
"union"             return UNI;        /* Indique au parser qu un opérateur d'union est reconnu */
"inter"             return INT;        /* Indique au parser qu un opérateur d'intersection est reconnu */
"comp"              return COM;        /* Indique au parser qu un opérateur de complémentarité est reconnu */
"diff"              return DIF;        /* Indique au parser qu un opérateur de différence est reconnu */
":="                return AFF;        /* Indique au parser qu un opérateur d'affectation est reconnu */
"\{"                return ACCOUV;     /* Indique au parser qu une accolade ouvrante est reconnu */
"\}"                return ACCFER;     /* Indique au parser qu une accolade fermante est reconnu */
"\("                return PAROUV;     /* Indique au parser qu une parenthèse ouvrante est reconnu */
"\)"                return PARFER;     /* Indique au parser qu une parenthèse fermante est reconnu */
","                 return VIR;        /* Indique au parser qu une virgule est reconnu */
{separateur}+       ;                  /* Elimination des espaces */
.                   {
                      sprintf(err,"Mauvais caractere %c",yytext[0]); /* Caractere incorrect rencontré */
                      yyerror(err);    /* Generation d'une erreur de syntaxe */
                    }

%%
