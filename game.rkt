#lang racket

(require 'board.rkt)
(require 'display.rkt)
;;(require 'turns.rkt)
;;(require 'players.rkt)

(board-init! 8)
(display-init!)
;; (define game
;;   (lambda (n p1 p2)
;;     (let ((players (players-init p1 p2)))
;;       (board-init! n)
;;       (display-init!)
;;       (let loop ((turn (turn-init!)))
;;         (players turn)
;;         (display)
;;         (unless (finish?)
;;           (loop (turn-next))))
;;       (judge))))

;(game n man man)

