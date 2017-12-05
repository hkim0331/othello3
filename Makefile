all: othello othello.app

othello:
	raco exe game.rkt
	mv game othello

othello.app:
	raco exe --gui othello-gui.rkt
	mv othello-gui.app othello.app

clean:
	${RM} *~ othello
	${RM} -r othello.app
