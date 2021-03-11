sstructure COL226a2LrVals = COL226a2LrValsFun(structure Token = LrParser.Token)
structure COL226a2Lex = COL226a2LexFun(structure Tokens = COL226a2LrVals.Tokens);
structure COL226a2Parser =
      Join(structure LrParser = LrParser
               structure ParserData = COL226a2LrVals.ParserData
               structure Lex = COL226a2Lex)

fun space_seperator(s)=
(*gives the last word from s*)
    let
       fun strr (nil, curString,encSpace)= curString |
        strr(hd::tl, curString, encSpace)=
            if hd = #" " then
                strr(tl, curString, true)
            else
                if encSpace then
                    strr(tl,str(hd),false)
                else
                    strr(tl,curString^str(hd),false)
    in
    strr(explode(s),"",false)
end

fun productionRule(s)=
    if s = "ID" then " formula => ID"
    else if s = "CONST" then " formula => CONST"
    else if s = "LPAREN" then " formula => LPAREN formula RPAREN"
    else if s = "RPAREN" then " formula => LPAREN formula RPAREN"
    else if s= "IF" then " formula => IF formula THEN formula ELSE formula"
    else if s= "THEN" then " formula => IF formula THEN formula ELSE formula"
    else if s= "ELSE" then " formula => IF formula THEN formula ELSE formula"
    else if s="NOT" then " formula => NOT formula"
    else if s="AND" then " formula => formula AND formula"
    else if s="OR" then " formula => formula OR formula"
    else if s="XOR" then " formula => formula XOR formula"
    else if s="EQUALS" then " formula => formula EQUALS formula"
    else if s="IMPLIES" then " formula => formula IMPLIES formula"
    else if s="TERM" then " statement => formula TERM"
    else s

fun invoke lexstream =
                let fun print_error (s,pos:int,columnNum:int) =
                TextIO.output(TextIO.stdOut, "Syntax Error:" ^ (Int.toString pos) ^ ":" ^ (Int.toString columnNum)^ ":" ^ productionRule(space_seperator(s)) ^ "\n")
        in
            COL226a2Parser.parse(0,lexstream,print_error,())
        end

fun stringToLexer str =
    let val done = ref false
        val lexer=  COL226a2Parser.makeLexer (fn _ => if (!done) then "" else (done:=true;str))
    in
    lexer
    end 
        
fun parse (lexer) =
    let val dummyEOF = COL226a2LrVals.Tokens.EOF(0,0)
        val (result, lexer) = invoke lexer
    val (nextToken, lexer) = COL226a2Parser.Stream.get lexer
    in
        if COL226a2Parser.sameToken(nextToken, dummyEOF) then result
    else (TextIO.output(TextIO.stdOut, "Warning: Unconsumed input \n"); result)
    end


val parseString = parse o stringToLexer;
val args = CommandLine.arguments();
fun giveFile (nil:string list) = "" | giveFile (hd::tl :string list)= hd;
val file =giveFile args;
parseString(TextIO.inputAll(TextIO.openIn (file)));





