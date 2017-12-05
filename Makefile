all: othello othello.app

othello:
	raco exe game.rkt
	mv game $@

othello.app:
	raco exe --gui othello-gui.rkt
	mv othello-gui.app $@

clean:
	${RM} *~ othello
	${RM} -r othello.app
