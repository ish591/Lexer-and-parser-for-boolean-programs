(* User  declarations *)


%%
(* required declarations *)
%name COL226a2

%term
 ID of string | CONST of string | TERM | NOT | AND | OR | XOR | EQUALS | IMPLIES | IF | THEN | ELSE 
 | LPAREN | RPAREN | EOF

%nonterm program of string | statement of string | formula of string | START of unit

%pos int

(*optional declarations *)
%eop EOF
%noshift EOF


(* %header  *)
%right IF THEN ELSE
%right IMPLIES
%left AND OR XOR EQUALS
%right NOT
%nonassoc ID CONST TERM LPAREN RPAREN
%start START

%verbose

%%
  START : program (print("\n["^program^"]\n"))
  program: program statement(program1^", "^statement1^", "^"program => program statement")
  | statement (statement1^", "^"program => statement")
  statement : formula TERM (formula1^", "^"TERM ;, "^"statement => formula TERM")
  formula : CONST   ("CONST "^CONST^", formula => CONST")
          | NOT formula ("NOT NOT, "^formula1^", formula => NOT formula")
          | formula AND formula (formula1^", "^"AND AND, "^formula2^", "
                                  ^"formula => formula AND formula")
          | formula OR formula (formula1^", "^"OR OR, "^formula2^", "^"formula => formula OR formula")
          | formula XOR formula (formula1^", "^"XOR XOR, "^formula2^", "^"formula => formula XOR formula")
          | formula EQUALS formula (formula1^", "^"EQUALS EQUALS, "^formula2^", "^"formula => formula EQUALS formula")
          | formula IMPLIES formula (formula1^", "^"IMPLIES IMPLIES, "^formula2^", "^"formula => formula IMPLIES formula")
          | IF formula THEN formula ELSE formula ("IF IF, "^formula1^", "^"THEN THEN, "^formula2^", "^"ELSE ELSE, "^formula3^", "^"formula => IF formula THEN formula ELSE formula")
          | LPAREN formula RPAREN ("LPAREN (, "^formula1^", "^"RPAREN ), "^"formula => LPAREN formula RPAREN")
          | ID ("ID "^ID^", "^"formula => ID")

