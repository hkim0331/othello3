#lang racket/gui

(require "board.rkt")
(require "display.rkt")
(require "turn.rkt")
(require "man.rkt")
;;(require "ai-0.rkt")

(define init
  (lambda (n)
    (board-init n)
    (display-init n)
    (turn-init)))

(define players
  (lambda (p1 p2)
    (lambda (turn)
      (if (even? turn) (p1) (p2)))))

;; if call message-box, should lang racket/gui.
(define judge
  (lambda ()
    (message-box "othello3" "thanks")
    (exit)))

(define game
  (lambda (p1 p2 n)
    (let ((player (players p1 p2)))
      (init n)
      (let loop ()
        (display)
        (player (turn))
        (unless (finish?)
          (loop)))
      (judge))))

(game man man 8)
;;(game man ai-0 8)

