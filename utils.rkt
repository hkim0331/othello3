#lang racket

(provide
 flat1
 not-null?
 nth)

(define flat1
  (lambda (lst)
    (if (null? lst)
        '()
        (append (car lst)
                (flat1 (cdr lst))))))

(define not-null?
  (lambda (x)
    (not (null? x))))

;; follow commonlisp way.
(define nth
  (lambda (n xs)
    (if (= 0 n) (first xs)
        (nth (- n 1) (rest xs)))))

