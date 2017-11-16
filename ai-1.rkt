#lang racket
;; 可能な手のうち、どれかを選んで打つ。
;; こんなんでいいんか？いいんです。

(require "utils.rkt")
(require "board.rkt")
(require "check.rkt")
(require "turn.rkt")
(require "hand.rkt")

(provide ai-1)

(define select-random
  (lambda (xs)
    (nth (random (length xs)) xs)))

(define ai-1
  (lambda ()
    (let* ((m (mark (turn)))
           (all (flat1 (for/list ([x (range (n))])
                        (for/list ([y (range (n))])
                          (list x y)))))
           (ok (filter
                (lambda (xy) (not-null? (check (first xy) (second xy) m)))
                all)))
      (if (null? ok)
          (pass!)
          (let ((hand (select-random ok)))
            (hand! (first hand) (second hand) m))))))
