all: othello othello.app

othello:
	raco exe othello.rkt

othello.app:
	raco exe --gui othello-gui.rkt
	mv othello-gui.app othello.app

clean:
	${RM} *~ othello
	${RM} -r othello.app
