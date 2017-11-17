#lang racket/gui

(require "board.rkt")
(require "display.rkt")
(require "turn.rkt")
(require "record.rkt")

(require "man.rkt")
(require "ai-0.rkt")
(require "ai-1.rkt")

;; if call message-box, should choose #lang racket/gui
(define judge
  (lambda ()
    (message-box
     "othello3"
     (string-append "o-x = " (number->string (o-x))))))

(define init
  (lambda (n)
    (board-init n)
    (turn-init)
    (display-init n)))

;; ここ、もうちょっと理解を深めよう。
;; 「こうしたら動いた」にすぎない。(p1) と () で囲むあたり。
(define players
  (lambda (p1 p2)
    (lambda (turn)
      (if (even? turn) (p1) (p2)))))

(define game
  (lambda (p1 p2 . n)
    (let ((player (players p1 p2)))
      (record-start)
      (if (null? n)
          (init 8)
          (init (car n)))
      (let loop ()
        (display)
        (record (player (turn)))
        (unless (finish?)
          (loop)))
      (judge)
      (record (o-x))
      (record-end))))

;; under construction,
;; (println (current-command-line-arguments))
;; (define main
;;   (lambda ()
;;     (let ((argv (current-command-line-arguments)))
;;       )))

;;(game man man)
;;(game man ai-0)
;;(game ai-0 ai-1)
(game ai-1 ai-1)
;;(game ai-1 man)

