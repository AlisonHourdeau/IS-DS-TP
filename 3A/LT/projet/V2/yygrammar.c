#line 3 "expEns.acc"
 /* Code C */
   /* Inclusion de bibliotheques C */
   #include <stdio.h>
   #include <malloc.h>
   #include "yystype.h" /* Redefinition du type yylval */
   
   /* Action de fin d analyse */
   void fin_analyse(){
        printf("Syntaxe correcte\n");
   }
   
   void cmp_ens(char lettre_h, char val_nomEns) {
        if (lettre_h == val_nomEns) {
            yyerror("Error : Un ensemble ne peut pas être défini par lui-même.\n");
        }
    }
   

# line 21 "yygrammar.c"
#include "yygrammar.h"

YYSTART ()
{
   switch(yyselect()) {
   case 19: {
      D();
      get_lexval();
      } break;
   }
}

D ()
{
   switch(yyselect()) {
   case 1: {
      listeAffExp();
      get_lexval();
#line 26 "expEns.acc"
 fin_analyse(); 
# line 42 "yygrammar.c"
      } break;
   }
}

listeAffExp ()
{
   switch(yyselect()) {
   case 2: {
      listeAffExp();
      get_lexval();
      affExp();
      } break;
   case 3: {
      affExp();
      } break;
   }
}

affExp ()
{
   YYSTYPE val;
   char lettre_h;
   switch(yyselect()) {
   case 4: {
      get_lexval();
      val = yylval;
#line 33 "expEns.acc"
 printf("Un ensemble reconnu : %c\n", val.nomEns); 
# line 71 "yygrammar.c"
      get_lexval();
#line 33 "expEns.acc"
 lettre_h = val.nomEns ; 
# line 75 "yygrammar.c"
      ensemble(lettre_h);
      } break;
   }
}

ensemble (lettre_h)
   char lettre_h;
{
   YYSTYPE val;
   char lettre1_h;
   switch(yyselect()) {
   case 5: {
      get_lexval();
      listeEntiers();
      get_lexval();
      } break;
   case 6: {
      get_lexval();
      get_lexval();
      } break;
   case 7: {
      get_lexval();
      val = yylval;
#line 38 "expEns.acc"
 printf("Un ensemble reconnu : %c  ->  ", val.nomEns); printf("%c, %c\n", lettre_h, val.nomEns); cmp_ens(lettre_h, val.nomEns); 
# line 101 "yygrammar.c"
      } break;
   case 8: {
#line 39 "expEns.acc"
 lettre1_h = lettre_h ; 
# line 106 "yygrammar.c"
      expr(lettre1_h);
      } break;
   }
}

listeEntiers ()
{
   switch(yyselect()) {
   case 9: {
      listeEntiers();
      get_lexval();
      get_lexval();
      } break;
   case 10: {
      get_lexval();
      } break;
   }
}

expr (lettre_h)
   char lettre_h;
{
   char lettre1_h;
   char lettre2_h;
   char lettre3_h;
   char lettre4_h;
   char lettre5_h;
   switch(yyselect()) {
   case 11: {
      get_lexval();
      opNaire();
#line 46 "expEns.acc"
lettre1_h = lettre_h ; 
# line 140 "yygrammar.c"
      ensemble(lettre1_h);
#line 46 "expEns.acc"
lettre2_h = lettre_h ; 
# line 144 "yygrammar.c"
      ensemble(lettre2_h);
#line 46 "expEns.acc"
lettre3_h = lettre_h ; 
# line 148 "yygrammar.c"
      listeEnsemble(lettre3_h);
      get_lexval();
      } break;
   case 12: {
      get_lexval();
      opBinaire();
#line 47 "expEns.acc"
lettre4_h = lettre_h ; 
# line 157 "yygrammar.c"
      ensemble(lettre4_h);
#line 47 "expEns.acc"
lettre5_h = lettre_h ; 
# line 161 "yygrammar.c"
      ensemble(lettre5_h);
      get_lexval();
      } break;
   }
}

listeEnsemble (lettre_h)
   char lettre_h;
{
   char lettre1_h;
   char lettre2_h;
   switch(yyselect()) {
   case 13: {
#line 50 "expEns.acc"
 lettre1_h = lettre_h ; 
# line 177 "yygrammar.c"
      listeEnsemble(lettre1_h);
#line 50 "expEns.acc"
lettre2_h = lettre_h ; 
# line 181 "yygrammar.c"
      ensemble(lettre2_h);
      } break;
   case 14: {
      } break;
   }
}

opNaire ()
{
   switch(yyselect()) {
   case 15: {
      get_lexval();
      } break;
   case 16: {
      get_lexval();
      } break;
   }
}

opBinaire ()
{
   switch(yyselect()) {
   case 17: {
      get_lexval();
      } break;
   case 18: {
      get_lexval();
      } break;
   }
}

extern YYSTYPE yylval;
YYSTYPE yylval;
extern long yypos;
long yypos = 1;
/* GentleFlag = no */

typedef struct LEXELEMSTRUCT {
   YYSTYPE val;
   long pos;
   long sym;
   char * text;
   struct LEXELEMSTRUCT *next;
} LEXELEM;
   
LEXELEM *first_lexelem, *cur_lexelem;

init_lexelem()
{
   cur_lexelem = first_lexelem;
}

first_lexval () {
   LEXELEM *p;
   p = (LEXELEM *)malloc(sizeof(LEXELEM));
   if (! p) yymallocerror();
   p->val = yylval;
   p->pos = yypos;
   p->next = 0;
   cur_lexelem = p;
   first_lexelem = p;
}

next_lexval() {
   LEXELEM *p;
   p = (LEXELEM *)malloc(sizeof(LEXELEM));
   if (! p) yymallocerror();
   cur_lexelem-> next = p;
   p->val = yylval;
   p->pos = yypos;
   p->next = 0;
   cur_lexelem = p;
}

get_lexval() {
   extern int FREE_LEXELEMS;
   LEXELEM *p;
   yylval = cur_lexelem->val;
   yypos = cur_lexelem->pos;
   p = cur_lexelem;
   cur_lexelem = cur_lexelem->next;
   free(p);
}

extern int c_length;
int c_length = 96;
extern int yygrammar[];
int yygrammar[] = {
0,
/* 1 */ 0,
/* 2 */ 6,
/* 3 */ 50000,
/* 4 */ -1,
/* 5 */ 19,
/* 6 */ 0,
/* 7 */ 11,
/* 8 */ 50256,
/* 9 */ -6,
/* 10 */ 1,
/* 11 */ 17,
/* 12 */ 11,
/* 13 */ 50256,
/* 14 */ 21,
/* 15 */ -11,
/* 16 */ 2,
/* 17 */ 0,
/* 18 */ 21,
/* 19 */ -11,
/* 20 */ 3,
/* 21 */ 0,
/* 22 */ 50257,
/* 23 */ 50263,
/* 24 */ 27,
/* 25 */ -21,
/* 26 */ 4,
/* 27 */ 33,
/* 28 */ 50264,
/* 29 */ 46,
/* 30 */ 50265,
/* 31 */ -27,
/* 32 */ 5,
/* 33 */ 38,
/* 34 */ 50264,
/* 35 */ 50265,
/* 36 */ -27,
/* 37 */ 6,
/* 38 */ 42,
/* 39 */ 50257,
/* 40 */ -27,
/* 41 */ 7,
/* 42 */ 0,
/* 43 */ 56,
/* 44 */ -27,
/* 45 */ 8,
/* 46 */ 52,
/* 47 */ 46,
/* 48 */ 50268,
/* 49 */ 50258,
/* 50 */ -46,
/* 51 */ 9,
/* 52 */ 0,
/* 53 */ 50258,
/* 54 */ -46,
/* 55 */ 10,
/* 56 */ 65,
/* 57 */ 50266,
/* 58 */ 81,
/* 59 */ 27,
/* 60 */ 27,
/* 61 */ 73,
/* 62 */ 50267,
/* 63 */ -56,
/* 64 */ 11,
/* 65 */ 0,
/* 66 */ 50266,
/* 67 */ 89,
/* 68 */ 27,
/* 69 */ 27,
/* 70 */ 50267,
/* 71 */ -56,
/* 72 */ 12,
/* 73 */ 78,
/* 74 */ 73,
/* 75 */ 27,
/* 76 */ -73,
/* 77 */ 13,
/* 78 */ 0,
/* 79 */ -73,
/* 80 */ 14,
/* 81 */ 85,
/* 82 */ 50259,
/* 83 */ -81,
/* 84 */ 15,
/* 85 */ 0,
/* 86 */ 50260,
/* 87 */ -81,
/* 88 */ 16,
/* 89 */ 93,
/* 90 */ 50261,
/* 91 */ -89,
/* 92 */ 17,
/* 93 */ 0,
/* 94 */ 50262,
/* 95 */ -89,
/* 96 */ 18,
0
};
extern int yyannotation[];
int yyannotation[] = {
0,
/* 1 */ 0,
/* 2 */ 0,
/* 3 */ 50000,
/* 4 */ -1,
/* 5 */ 0,
/* 6 */ 0,
/* 7 */ 1,
/* 8 */ 50256,
/* 9 */ -6,
/* 10 */ 1,
/* 11 */ 17,
/* 12 */ 1,
/* 13 */ 50256,
/* 14 */ 1,
/* 15 */ -11,
/* 16 */ 1,
/* 17 */ 0,
/* 18 */ 1,
/* 19 */ -11,
/* 20 */ 2,
/* 21 */ 0,
/* 22 */ 50257,
/* 23 */ 50263,
/* 24 */ 1,
/* 25 */ -21,
/* 26 */ 1,
/* 27 */ 33,
/* 28 */ 50264,
/* 29 */ 1,
/* 30 */ 50265,
/* 31 */ -27,
/* 32 */ 1,
/* 33 */ 38,
/* 34 */ 50264,
/* 35 */ 50265,
/* 36 */ -27,
/* 37 */ 2,
/* 38 */ 42,
/* 39 */ 50257,
/* 40 */ -27,
/* 41 */ 3,
/* 42 */ 0,
/* 43 */ 1,
/* 44 */ -27,
/* 45 */ 4,
/* 46 */ 52,
/* 47 */ 1,
/* 48 */ 50268,
/* 49 */ 50258,
/* 50 */ -46,
/* 51 */ 1,
/* 52 */ 0,
/* 53 */ 50258,
/* 54 */ -46,
/* 55 */ 2,
/* 56 */ 65,
/* 57 */ 50266,
/* 58 */ 1,
/* 59 */ 1,
/* 60 */ 1,
/* 61 */ 1,
/* 62 */ 50267,
/* 63 */ -56,
/* 64 */ 1,
/* 65 */ 0,
/* 66 */ 50266,
/* 67 */ 1,
/* 68 */ 1,
/* 69 */ 1,
/* 70 */ 50267,
/* 71 */ -56,
/* 72 */ 2,
/* 73 */ 78,
/* 74 */ 1,
/* 75 */ 1,
/* 76 */ -73,
/* 77 */ 1,
/* 78 */ 0,
/* 79 */ -73,
/* 80 */ 2,
/* 81 */ 85,
/* 82 */ 50259,
/* 83 */ -81,
/* 84 */ 1,
/* 85 */ 0,
/* 86 */ 50260,
/* 87 */ -81,
/* 88 */ 2,
/* 89 */ 93,
/* 90 */ 50261,
/* 91 */ -89,
/* 92 */ 1,
/* 93 */ 0,
/* 94 */ 50262,
/* 95 */ -89,
/* 96 */ 2,
0
};
extern int yycoordinate[];
int yycoordinate[] = {
0,
/* 1 */ 9999,
/* 2 */ 26003,
/* 3 */ 9999,
/* 4 */ 9999,
/* 5 */ 26003,
/* 6 */ 9999,
/* 7 */ 26005,
/* 8 */ 9999,
/* 9 */ 9999,
/* 10 */ 26015,
/* 11 */ 9999,
/* 12 */ 29015,
/* 13 */ 9999,
/* 14 */ 29030,
/* 15 */ 9999,
/* 16 */ 29025,
/* 17 */ 9999,
/* 18 */ 30015,
/* 19 */ 9999,
/* 20 */ 30020,
/* 21 */ 9999,
/* 22 */ 9999,
/* 23 */ 9999,
/* 24 */ 33109,
/* 25 */ 9999,
/* 26 */ 33015,
/* 27 */ 9999,
/* 28 */ 9999,
/* 29 */ 36039,
/* 30 */ 9999,
/* 31 */ 9999,
/* 32 */ 36037,
/* 33 */ 9999,
/* 34 */ 9999,
/* 35 */ 9999,
/* 36 */ 9999,
/* 37 */ 37039,
/* 38 */ 9999,
/* 39 */ 9999,
/* 40 */ 9999,
/* 41 */ 38039,
/* 42 */ 9999,
/* 43 */ 39061,
/* 44 */ 9999,
/* 45 */ 39034,
/* 46 */ 9999,
/* 47 */ 42016,
/* 48 */ 9999,
/* 49 */ 9999,
/* 50 */ 9999,
/* 51 */ 42027,
/* 52 */ 9999,
/* 53 */ 9999,
/* 54 */ 9999,
/* 55 */ 43021,
/* 56 */ 9999,
/* 57 */ 9999,
/* 58 */ 46035,
/* 59 */ 46069,
/* 60 */ 46116,
/* 61 */ 46163,
/* 62 */ 9999,
/* 63 */ 9999,
/* 64 */ 46033,
/* 65 */ 9999,
/* 66 */ 9999,
/* 67 */ 47015,
/* 68 */ 47051,
/* 69 */ 47098,
/* 70 */ 9999,
/* 71 */ 9999,
/* 72 */ 47013,
/* 73 */ 9999,
/* 74 */ 50064,
/* 75 */ 50116,
/* 76 */ 9999,
/* 77 */ 50037,
/* 78 */ 9999,
/* 79 */ 9999,
/* 80 */ 52001,
/* 81 */ 9999,
/* 82 */ 9999,
/* 83 */ 9999,
/* 84 */ 54013,
/* 85 */ 9999,
/* 86 */ 9999,
/* 87 */ 9999,
/* 88 */ 55013,
/* 89 */ 9999,
/* 90 */ 9999,
/* 91 */ 9999,
/* 92 */ 58015,
/* 93 */ 9999,
/* 94 */ 9999,
/* 95 */ 9999,
/* 96 */ 59015,
0
};
/* only for BIGHASH (see art.c)
extern int DHITS[];
int DHITS[98];
*/
int TABLE[20][269];
init_dirsets() {
TABLE[19][257] = 1;
TABLE[1][257] = 1;
TABLE[2][257] = 1;
TABLE[3][257] = 1;
TABLE[4][257] = 1;
TABLE[5][264] = 1;
TABLE[6][264] = 1;
TABLE[7][257] = 1;
TABLE[8][266] = 1;
TABLE[9][258] = 1;
TABLE[10][258] = 1;
TABLE[11][266] = 1;
TABLE[12][266] = 1;
TABLE[13][257] = 1;
TABLE[13][264] = 1;
TABLE[13][266] = 1;
TABLE[14][267] = 1;
TABLE[14][264] = 1;
TABLE[14][257] = 1;
TABLE[14][266] = 1;
TABLE[15][259] = 1;
TABLE[16][260] = 1;
TABLE[17][261] = 1;
TABLE[18][262] = 1;
}

extern int yydirset();
int yydirset(i,j)
   int i,j;
{
   return TABLE[i][j];
}
int yytransparent(n)
   int n;
{
   switch(n) {
      case 1: return 0; break;
      case 6: return 0; break;
      case 11: return 0; break;
      case 21: return 0; break;
      case 27: return 0; break;
      case 46: return 0; break;
      case 56: return 0; break;
      case 73: return 1; break;
      case 81: return 0; break;
      case 89: return 0; break;
   }
}
char * yyprintname(n)
   int n;
{
   if (n <= 50000)
      switch(n) {
         case 1: return "YYSTART"; break;
         case 6: return "D"; break;
         case 11: return "listeAffExp"; break;
         case 21: return "affExp"; break;
         case 27: return "ensemble"; break;
         case 46: return "listeEntiers"; break;
         case 56: return "expr"; break;
         case 73: return "listeEnsemble"; break;
         case 81: return "opNaire"; break;
         case 89: return "opBinaire"; break;
   }
   else 
      switch(n-50000) {
         case 268: return "VIR"; break;
         case 267: return "PARFER"; break;
         case 266: return "PAROUV"; break;
         case 265: return "ACCFER"; break;
         case 264: return "ACCOUV"; break;
         case 263: return "AFF"; break;
         case 262: return "DIF"; break;
         case 261: return "COM"; break;
         case 260: return "INT"; break;
         case 259: return "UNI"; break;
         case 258: return "ENTIER"; break;
         case 257: return "LETTRE"; break;
         case 256: return "RC"; break;
      }
   return "special_character";
}
