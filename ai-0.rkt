#lang racket
;; 可能な手のうち、最初に見つかるものを打つ。
;; ただし、パスができないといけない。

(require "board.rkt")
(require "check.rkt")
(require "turn.rkt")
(require "hand.rkt")

(provide ai-0)

(define flat1
  (lambda (lst)
    (if (null? lst)
        '()
        (append (car lst)
                (flat1 (cdr lst))))))


(define not-null?
  (lambda (x)
    (not (null? x))))

;;
(define ai-0
  (lambda ()
    (let* ((m (mark (turn)))
           (all (flat1 (for/list ([x (range (n))])
                        (for/list ([y (range (n))])
                          (list x y)))))
           (ok (first
                (filter
                 (lambda (xy) (not-null? (check (first xy) (second xy) m)))
                 all))))
      ;;debug
      (printf "~a~%" ok)
      (hand! (first ok) (second ok) m))))

;;test
;;(board-init 8)
;;(ai-0)
