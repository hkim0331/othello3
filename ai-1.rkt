#lang racket
;; 可能な手のうち、どれかを選んで打つ。
;; こんなんでいいんか？いいんです。

(require "utils.rkt"
         "board.rkt"
         "check.rkt"
         "turn.rkt"
         "hand.rkt")

(provide ai-1)

(define select-random
  (lambda (xs)
    (nth (random (length xs)) xs)))

(define ai-1
  (lambda ()
    (let* ((m (mark (turn)))
           (ok (filter
                (lambda (xy) (not-null? (check (first xy) (second xy) m)))
                (blanks))))
      (if (null? ok)
          (let ()
            (pass!)
            "pass")
          (let ((hand (select-random ok)))
            (hand! (first hand) (second hand) m)
            (cons m hand))))))
