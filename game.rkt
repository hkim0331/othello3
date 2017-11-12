#lang racket/gui

(require "board.rkt")
(require "display.rkt")
(require "turn.rkt")
(require "players.rkt")
(require "man.rkt")

(define init
  (lambda (n)
    (board-init n)
    (display-init n)
    (turn-init)))

(define finish?
  (lambda ()
    (< 1 (pass))))

;; if call message-box, should lang racket/gui.
(define judge
  (lambda ()
    (message-box "othello3" "thanks")
    (exit)))

(define game
  (lambda (p1 p2 n)
    (let ((players (players-init p1 p2)))
      (init n)
      (turn-init)
      ;; first move black
      ;; (turn-next)
      (display)
      (let loop ()
        (players (turn))
        ;; (printf "next ~a~%" (turn))
        (display)
        (unless (finish?)
          (loop)))
      (judge))))

(game man man 8)
