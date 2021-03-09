all:
	mlyacc COL226a2.yacc 
	mllex COL226a2.lex
	mlton a2.mlb
	
clean:
	rm -rf COL226a2.yacc.sig
	rm -rf COL226a2.yacc.desc
	rm -rf COL226a2.lex.sml
	rm -rf COL226a2.yacc.sml
	rm -rf a2

.SILENT: all clean