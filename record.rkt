#lang racket

(require racket/runtime-path)
(define-runtime-path records "./records/")

(provide
 record-start
 record-end
 record)

(require "utils.rkt")

(define *port* #f)
(define *msec* 0)

(define record-start
  (lambda ()
    (set! *port* (open-output-file
                  (string-append
                   (path->string records) (now) ".txt")))
    (record (string-append "; " (now)))
    (set! *msec* (current-milliseconds))))

(define record
  (lambda (s)
    (fprintf *port* "~a~%" s)))

(define record-end
  (lambda ()
    (record (string-append
             "; real time: "
             (number->string (- (current-milliseconds)
                                *msec*))))
    (record (string-append "; " (now)))
    (close-output-port *port*)))

