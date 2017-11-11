#lang racket/gui

(provide man start)

(define *stop* true)

(define start
  (lambda ()
    (set! *stop* false)))

(define man
  (lambda ()
    (set! *stop* true)
    (let loop ()
      (when *stop*
        (sleep/yield 1)
        (loop)))))

