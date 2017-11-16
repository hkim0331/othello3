#lang racket
;; 可能な手のうち、最初に見つかるものを打つ。
;; こんなの人工知能か？いいんです。

(require "utils.rkt")
(require "board.rkt")
(require "check.rkt")
(require "turn.rkt")
(require "hand.rkt")

(provide ai-0)

(define ai-0
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
          (let ((hand (first ok)))
            (hand! (first hand) (second hand) m))))))
