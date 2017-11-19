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
           (ok (filter
                (lambda (xy) (not-null? (check (first xy) (second xy) m)))
                (blanks))))
      (if (null? ok)
          (let ()
            (pass!)
            "pass") ;; return value.
          (let ((hand (first ok)))
            (hand! (first hand) (second hand) m)
            (cons m hand)))))) ;; yes, this is return value, too.
