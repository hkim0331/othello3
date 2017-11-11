#lang racket

(require "board.rkt")
(require "check.rkt")
(require "man.rkt")

(provide hand!)

;; 両端を含まない range
;; (ex-range 1 10) ;=> (2 3 4 5 6 7 8 9)
;; (ex-range 10 1) ;=> (9 8 7 6 5 4 3 2)
(define ex-range
  (lambda (from to)
    (if (> from to)
        (reverse (rest (range to from)))
        (rest (range from to)))))

;; p1 と p2 とで挟まれるコマの座標を返す。
(define betweens-aux
  (lambda (p1 p2)
    (let ((x1 (first p1))
          (y1 (second p1))
          (x2 (first p2))
          (y2 (second p2)))
      (cond
        ((= x1 x2) (map (lambda (y) (list x1 y)) (ex-range y1 y2)))
        ((= y1 y2) (map (lambda (x) (list x y1)) (ex-range x1 x2)))
        (else (map list (ex-range x1 x2) (ex-range y1 y2)))))))

;; 引数は下の pairs が返す ((x1 y1) (x2 y2))。
(define betweens
  (lambda (xy)
    (betweens-aux (first xy) (second xy))))

;; 着手 o と挟める座標のリスト (xy1 xy2 xy3 ...) を引数にとり、
;; ((o xy1) (o xy2) (o xy3) ...) のリストにする。
(define pairs
  (lambda (o xys)
    (map (lambda (xy) (list o xy)) xys)))

(define flat1
  (lambda (lst)
    (if (null? lst) '()
        (append (car lst) (flat1 (cdr lst))))))

;; ひっくり返すべき石の座標のリスト。
(define must-be-turned
  (lambda (o ords)
    (flat1 (map betweens (pairs o ords)))))

(define hand!
  (lambda (x y m ords)
    (put! x y m)
    (map (lambda (xy) (apply turn! xy)) (must-be-turned (list x y) ords))
    (restart)))
