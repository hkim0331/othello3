#lang racket/gui
;; リプレーする棋譜をコマンドラインから取れるように。
;; FIXME: 結果を表示するか？

(require "display.rkt")
(require "hand.rkt")
(require "board.rkt")
(require "turn.rkt")

(define init
  (lambda (n)
    (board-init n)
    (turn-init)
    (display-init n)))

(define replay
  (lambda (name)
    (init 8)
    (call-with-input-file name
      (lambda (in)
        (let loop ((hand (read in)))
          (unless (eof-object? hand)
            (when (pair? hand)
              (let ((m (symbol->string (first hand)))
                    (x (second hand))
                    (y (third hand)))
                (hand! x y m)
                (display)))
            (loop (read in))))))))


;;引数をベクタで返す。
;;(current-command-line-arguments)

(map replay
     (vector->list (current-command-line-arguments)))
