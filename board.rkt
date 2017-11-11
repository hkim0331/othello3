#lang racket

(provide
 board-init
 n
 mark?
 _?
 opposite
 get
 get-w
 put!
 turn!)

(define *m* #f)
(define *n* #f)

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

(define mark?
  (lambda (m1 m2)
    (equal? m1 m2)))

(define _?
  (lambda (m) (mark? m "_")))

(define opposite
  (lambda (m)
    (cond
      ((mark? m "o") "x")
      ((mark? m "x") "o")
      (else (error "mark is not 'o' neigher 'x'.")))))

(define put!
  (λ (x y mark)
    (define RM
      (λ (m)
        (cond
          ((null? m) '())
          ((and (= x (first (car m))) (= y (second (car m)))) (cdr m))
          (else (cons (first m) (RM (rest m)))))))
    (if (range? x y)
        (set! *m* (cons (list x y mark (get-w x y)) (RM *m*)))
        (error "you can't put there."))))

(define turn!
  (λ (x y)
    (let ((m (get x y)))
      (if (mark? m "_")
          (error "turn!: you can't do that.")
          (put! x y (opposite m))))))

;; initialize othello board *m*.
;; ((x y mark weight) ...)
(define init
  (λ (n)
    (set! *n* n)
    (set! *m* '())
    (for ([y (range *n*)])
         (for ([x (range *n*)])
              (set! *m* (cons (list x y "_" 1) *m*))))))

(define n (lambda () *n*))

(define board-init
  (λ (n)
    (let ((m (/ n 2)))
      (init n)
      (put! (- m 1) (- m 1) "o")
      (put! m (- m 1) "x")
      (put! (- m 1) m "x")
      (put! m m "o"))))
