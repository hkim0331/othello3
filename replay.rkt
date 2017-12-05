#!/usr/bin/env racket
#lang racket/gui
;; リプレーする棋譜をコマンドラインから取れるように。
;; FIXME: 結果を表示するか？
;; sleep を引数で渡す。

(require "display.rkt"
         "hand.rkt"
         "board.rkt"
         "turn.rkt")

(define *sleep* 0)

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
                (display)
                (sleep *sleep*)))
            (loop (read in))))))))

;;; $ ./replay -s 0.5 records/*.txt

(define (args xs)
  (define (A args ret)
    (cond
      ((null? args) (reverse ret))
      ((string=? (car args) "-s")
       (set! *sleep* (string->number (cadr args)))
       (A (cddr args) ret))
      (else
       (A (cdr args) (cons (car args) ret)))))
  (A xs '()))

(map replay
     (args (vector->list (current-command-line-arguments))))
