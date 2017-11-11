#lang racket/gui

(provide man restart)

(define *stop* true)

(define restart
  (lambda ()
    (set! *stop* false)))

(define man
  (lambda ()
    (set! *stop* true)
    (let loop ()
      (when *stop*
        (printf "man waits click~%")
        (sleep/yield 1)
        (loop)))))

