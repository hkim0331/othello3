#lang racket/gui

(provide man
         man-restart)

(define *stop* true)

(define man-restart
  (lambda ()
    (set! *stop* false)))

(define man
  (lambda ()
    (set! *stop* true)
    (let loop ()
      (when *stop*
        (sleep/yield 1)
        (loop)))))

