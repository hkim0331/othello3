#lang racket

(provide players-init)

(define (players-init p1 p2)
  (lambda (turn)
    (if (even? turn) p1 p2)))

