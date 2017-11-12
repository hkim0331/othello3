#lang racket/gui

(require "board.rkt")
(require "display.rkt")
(require "turn.rkt")

(require "man.rkt")
(require "ai-0.rkt")
(require "ai-1.rkt")

(define init
  (lambda (n)
    (board-init n)
    (turn-init)
    (display-init n)))

(define players
  (lambda (p1 p2)
    (lambda (turn)
      (if (even? turn) (p1) (p2)))))

;; if call message-box, should lang racket/gui.
(define judge
  (lambda ()
    (message-box
     "othello3"
     (string-append "o-x = " (number->string (o-x))))
    (exit)))

(define game
  (lambda (p1 p2 . n)
    (let ((player (players p1 p2)))
      (if (null? n) (init 8) (init (car n)))
      (let loop ()
        (display)
        (player (turn))
        (unless (finish?)
          (loop)))
      (judge))))

;;(game man man)
;;(game man ai-0)
;;(game ai-0 ai-1)
;;(game ai-1 ai-1 16)
