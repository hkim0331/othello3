#lang racket

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
  (lambda () #f))

(define judge
  (lambda () "thanks"))

(define game
  (lambda (p1 p2 n)
    (let ((players (players-init p1 p2)))
      (init n)
      (turn-init)
      (display (string-append "first: " (mark (turn))))
      (let loop ()
        (players (turn))
        (turn-next)
        (display (string-append "next: " (mark (turn))))
        (unless (finish?)
          (loop)))
      (judge))))

(game man man 8)
