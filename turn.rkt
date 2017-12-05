#lang racket

;; FIXME: if man 'passed', should clear *stop* flag.
(require "man.rkt")

(provide finish?
         turn-init
         turn
         turn-next
         pass
         pass!
         pass-reset)

(define finish?
  (lambda ()
    (< 1 (pass))))

;; turn
(define *turn* 0)

(define turn-init
  (lambda ()
    (set! *turn* 0)
    *turn*))

;; turn! is used in board.
(define turn-next
  (lambda ()
    (set! *turn* (add1 *turn*))
    *turn*))

(define turn
  (lambda () *turn*))

;; pass
(define *pass* 0)

(define pass
  (lambda ()
    *pass*))

(define pass-reset
  (lambda ()
    (set! *pass* 0)))

(define pass!
  (lambda ()
    (set! *pass* (add1 *pass*))
    (turn-next)
    (man-restart)))
