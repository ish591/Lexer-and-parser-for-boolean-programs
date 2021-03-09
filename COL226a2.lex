structure Tokens= Tokens
  
  type pos = int
  type columnNum =int
  type TokenString = string
  type svalue = Tokens.svalue
  type ('a,'b) token = ('a,'b) Tokens.token  
  type lexresult = (svalue, pos ) token

  val pos = ref 1
  val tokenNum =ref 0
  val columnNum =ref 0
  val TokenString =ref "["
  val eof = fn () => (print(!TokenString^"]\n");Tokens.EOF(!pos, !columnNum))
  val error = fn (e,l:int, col:int,tok) => TextIO.output(TextIO.stdOut,e^
  Int.toString(l)^":"^Int.toString(col)^":"^tok^"\n")

  fun revfold _ nil b = b
  | revfold f (hd::tl) b = revfold f tl (f(hd,b))
  
%%
%header (functor COL226a2LexFun(structure Tokens:COL226a2_TOKENS));

alpha=[A-Za-z];
ws = [\ \t];
%%
\n         => (pos := (!pos) + 1; lex());

{ws}+      => (columnNum := (!columnNum)+size(yytext);lex());

";"        => (columnNum := (!columnNum)+1;
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"TERM "^"\""^yytext^"\"";
              Tokens.TERM(!pos,!columnNum));

"TRUE"     => (columnNum := (!columnNum)+4;
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"CONST "^"\""^yytext^"\"";
              tokenNum := (!tokenNum)+1;
              Tokens.CONST(yytext,!pos,!columnNum));

"FALSE"    => (columnNum := (!columnNum)+5;
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"CONST "^"\""^yytext^"\"";
              tokenNum := (!tokenNum)+1;
              Tokens.CONST(yytext,!pos,!columnNum));

"("        => (columnNum := (!columnNum)+1;
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"LPAREN "^"\""^yytext^"\"";
              tokenNum := (!tokenNum)+1;
              Tokens.LPAREN(!pos,!columnNum));

")"        => (columnNum := (!columnNum)+1;
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"RPAREN "^"\""^yytext^"\"";
              tokenNum := (!tokenNum)+1;
              Tokens.RPAREN(!pos,!columnNum));

"IMPLIES"  => (columnNum := (!columnNum)+7;
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"IMPLIES "^"\""^yytext^"\"";
              tokenNum := (!tokenNum)+1;
              Tokens.IMPLIES(!pos,!columnNum));

"NOT"      => (columnNum := (!columnNum)+3;
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"NOT "^"\""^yytext^"\"";
              tokenNum := (!tokenNum)+1;
              Tokens.NOT(!pos,!columnNum));

"AND"      => (columnNum := (!columnNum)+3;
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"AND "^"\""^yytext^"\"";
              tokenNum := (!tokenNum)+1;
              Tokens.AND(!pos,!columnNum));

"OR"       => (columnNum := (!columnNum)+2;
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"OR "^"\""^yytext^"\"";
              tokenNum := (!tokenNum)+1;
              Tokens.OR(!pos,!columnNum));

"XOR"      => (columnNum := (!columnNum)+3;
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"XOR "^"\""^yytext^"\"";
              tokenNum := (!tokenNum)+1;
              Tokens.XOR(!pos,!columnNum));

"EQUALS"   => (columnNum := (!columnNum)+6;
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"EQUALS "^"\""^yytext^"\"";
              tokenNum := (!tokenNum)+1;
              Tokens.EQUALS(!pos,!columnNum));

"IF"       => (columnNum := (!columnNum)+2;
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"IF "^"\""^yytext^"\"";
              tokenNum := (!tokenNum)+1;
              Tokens.IF(!pos,!columnNum));

"THEN"     => (columnNum := (!columnNum)+4;
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"THEN "^"\""^yytext^"\"";
              tokenNum := (!tokenNum)+1;
              Tokens.THEN(!pos,!columnNum));

"ELSE"     => (columnNum := (!columnNum)+4;
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"ELSE "^"\""^yytext^"\"";
              tokenNum := (!tokenNum)+1;
              Tokens.ELSE(!pos,!columnNum));

{alpha}+   => (columnNum := (!columnNum)+size(yytext);
              if (!tokenNum <> 0) then TokenString := (!TokenString)^", " else 
              TokenString := (!TokenString)^"";
              TokenString := (!TokenString)^"ID "^"\""^yytext^"\"";
              tokenNum := (!tokenNum)+1;
              Tokens.ID(yytext,!pos,!columnNum));

.          => (columnNum := (!columnNum)+1;
              error ("Unknown token:",!pos,!columnNum,yytext);lex());

