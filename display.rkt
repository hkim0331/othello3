#lang racket/gui
(require "board.rkt")
(require "hand.rkt")
(require "turn.rkt")

(provide display-init! display)

(define *frame* #f)
(define *btns* #f)

(define display-init!
  (lambda (n)
    (set! *frame* (new frame% [label "othello3"]))
    (set! *btuns* '())
    (for ([y (range (n))])
      (let (p (new horizontal-pane% [parent *frame*]))
        (for ([x (range (n))])
          (let btn
              (new button% [parent p]
                   [label " "]
                   [callback
                    (lambda (b e)
                      (let ((m (mark (turn))))
                        (if (can-put? x y m)
                            (hand!  x y m)
                            (error "you can't do that"))))])
            (cons btn *btns*)))))
    ;;FIXME: PASS BUTTON
    ))

(define display
  (lambda ()
    ))
