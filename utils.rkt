#lang racket

(provide
 flat1
 not-null?
 now
 nth
 )

(require racket/date)

(define flat1
  (lambda (lst)
    (if (null? lst)
        '()
        (append (car lst)
                (flat1 (cdr lst))))))

;; in Clojure, (def not-nil? (comp not nil?))
(define not-null?
  (lambda (x)
    (not (null? x))))

;; returns current-time in iso format.
(define now
  (λ ()
    (let ((date (seconds->date (current-seconds))))
      (date-display-format 'iso-8601)
      (date->string (current-date) #t))))

;; follow commonlisp way.
(define nth
  (lambda (n xs)
    (if (= 0 n) (first xs)
        (nth (- n 1) (rest xs)))))

