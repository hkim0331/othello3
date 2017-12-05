#lang racket

(require "utils.rkt")

(provide board-init
         o-x
         n
         mark
         mark?
         _?
         opposite
         get
         get-w
         put!
         turn!
         blanks)

(define *m* #f)
(define *n* #f)

;; shadow racket's error. or use other name?
(define error
  (lambda (s)
    (printf s)))

(define range?
  (lambda (x y)
   (and (<= 0 x) (< x (n)) (<= 0 y) (< y (n)))))

(define get-aux
  (λ (f x y default)
    (if (range? x y)
        (f
         (first
          (filter
           (λ (el)
             (and (= x (first el)) (= y (second el)))) *m*)))
        "_")))

(define get
  (λ (x y)
    (get-aux third x y "_")))

(define get-w
  (λ (x y)
    (get-aux fourth x y 1)))

(define mark
  (lambda (n)
    (if (even? n) "o" "x")))

(define mark?
  (lambda (m1 m2)
    (equal? m1 m2)))

(define _?
  (lambda (m) (mark? m "_")))

(define find-marks
  (lambda (m)
    (filter (lambda (xy) (mark? m (third xy))) *m*)))

(define o-x
  (lambda ()
    (- (length (find-marks "o")) (length (find-marks "x")))))

(define opposite
  (lambda (m)
    (cond
      ((mark? m "o") "x")
      ((mark? m "x") "o")
      (else (error "opossite: mark is not 'o' neigher 'x'.")))))

(define remove-first
  (lambda (x y m)
        (cond
          ((null? m) '())
          ((and (= x (first (car m))) (= y (second (car m)))) (cdr m))
          (else (cons (first m) (remove-first x y (rest m)))))))

(define put!
  (λ (x y mark)
    (if (range? x y)
        (begin
          (set! *m* (cons (list x y mark (get-w x y))
                          (remove-first x y *m*)))
          (set! *blanks* (remove-first x y *blanks*)))
        (error "put!: you can't put there."))))

(define turn!
  (λ (x y)
    (let ((m (get x y)))
      (if (mark? m "_")
          (error "turn!: you can't do that.")
          (put! x y (opposite m))))))

(define n (lambda () *n*))

;; initialize othello board *m*.
;; ((x y mark weight) ...)
(define init
  (λ (n)
    (set! *n* n)
    (set! *m* '())
    (set! *blanks* (init-blanks n))
    (for ([y (range *n*)])
         (for ([x (range *n*)])
              (set! *m* (cons (list x y "_" 1) *m*))))))

(define board-init
  (λ (n)
    (let ((m (/ n 2)))
      (init n)
      (put! (- m 1) (- m 1) "o")
      (put! m (- m 1) "x")
      (put! (- m 1) m "x")
      (put! m m "o"))))

(define *blanks* #f)

(define init-blanks
  (lambda (n)
    (flat1 (for/list ([x (range n)])
             (for/list ([y (range n)])
               (list x y))))))

(define blanks (lambda () *blanks*))
