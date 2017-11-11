#lang racket

(provide turn-init turn turn-next)

(define *turn* 0)

(define turn-init
  (lambda ()
    (set! *turn* 0)
    *turn*))

(define turn-next
  (lambda ()
    (set! *turn* (add1 *turn*))
    *turn*))

(define turn
  (lambda () *turn*))


