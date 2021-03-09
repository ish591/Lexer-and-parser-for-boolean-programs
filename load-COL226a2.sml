structure COL226a2LrVals = COL226a2LrValsFun(structure Token = LrParser.Token)
structure COL226a2Lex = COL226a2LexFun(structure Tokens = COL226a2LrVals.Tokens);
structure COL226a2Parser =
	  Join(structure LrParser = LrParser
     	       structure ParserData = COL226a2LrVals.ParserData
     	       structure Lex = COL226a2Lex)
     
fun invoke lexstream =
    	     	let fun print_error (s,pos:int,columnNum:int) =
		    	TextIO.output(TextIO.stdOut, "Syntax Error:" ^ (Int.toString pos) ^ ":" ^ (Int.toString columnNum)^ ":" ^ s ^ "\n")
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





