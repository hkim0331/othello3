#lang racket

(provide
 record-start
 record-end
 record)

(require "utils.rkt")

(define *port* #f)

(define record-start
  (lambda ()
    (set! *port* (open-output-file
                  (string-append "records/" (now) ".txt")))
        (record (string-append ";" (now)))))

(define record
  (lambda (s)
    (fprintf *port* "~a~%" s)))

(define record-end
  (lambda ()
    (record (string-append ";" (now)))
    (close-output-port *port*)))

