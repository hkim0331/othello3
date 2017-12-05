#lang racket/gui

(require racket/runtime-path
         "board.rkt"
         "check.rkt"
         "hand.rkt"
         "turn.rkt")

(define-runtime-path sorry-dave "./resources/sorry-dave.mp3")
(define-runtime-path i-m-afraid "./resources/i-m-afraid.m4a")

;;FIXME: display shadows racket function, 'display'.
(provide display-init
         display)

(define *frame* #f)
(define *btns* #f)
(define *n* #f)

;; private error function, shadows racket's error function.
(define error
  (lambda (msg)
    (play-sound i-m-afraid #t)
    (message-box "error" msg)))

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
                      (hand! x y (mark (turn))))])))
            (set! *btns* (cons (list x y btn) *btns*))))))
    (new button% [parent (new horizontal-pane% [parent *frame*])]
         [label "pass"]
         [callback
          (lambda (btn evt)
            (pass!))])
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
  (lambda (m)
    (cond
      ((mark? m "o") "○")
      ((mark? m "x") "●")
      (else " "))))

;; FIXME: scheme has display function.
(define display
  (lambda ()
    (let ((title
           (string-append "next: "
                          (mark (turn))
                          ", pass: "
                          (number->string (pass)))))
      (send *frame* set-label title)
      (for ([y (range (n))])
        (for ([x (range (n))])
          (send (button x y) set-label (C (get x y))))))))
