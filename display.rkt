#lang racket/gui

(require "board.rkt")
(require "check.rkt")
(require "hand.rkt")
(require "turn.rkt")

(provide display-init display)

(define *frame* #f)
(define *btns* #f)
(define *n* #f)

(define error
  (lambda (msg)
    (message-box "error" msg)))

(define mark
  (lambda (n)
    (if (even? n) "o" "x")))

(define init!
  (lambda (n)
    (set! *frame* (new frame% [label "othello3"]))
    (set! *btns* '())
    (for ([y (range n)])
      (let ((p (new horizontal-pane% [parent *frame*])))
        (for ([x (range n)])
          (let ((btn
                 (new button% [parent p]
                   [label " "]
                   [callback
                    (lambda (b e)
                      (let* ((m (mark (turn)))
                             (ords (check x y m)))
                        (if (empty? ords)
                            (error "you can't do that")
                            (hand! x y m ords))))])))
            (set! *btns* (cons (list x y btn) *btns*))))))
    ;;FIXME: PASS BUTTON
    (send *frame* show #t)))

(define button
  (lambda (x y)
    (third
     (first
      (filter
       (lambda (btn) (and (= (first btn) x) (= (second btn) y)))
       *btns*)))))

(define display-init
  (λ (n)
    (let ((m (/ n 2)))
      (init! n)
      (put! (- m 1) (- m 1) "o")
      (put! m (- m 1) "x")
      (put! (- m 1) m "x")
      (put! m m "o"))))

(define C
  (lambda (m) (if (_? m) " " m)))

(define display
  (lambda (title)
    (send *frame* set-label title)
    (for ([y (range (n))])
      (for ([x (range (n))])
        (send (button x y) set-label (C (get x y)))))))
