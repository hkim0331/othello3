#lang racket

(require "board.rkt")

(provide check)

(define _?
  (lambda (m) (equal? m "_")))

;;; find の下請け。
;;; 相手石が見つかってから呼ばれる。
;;; (x y) は調べようとする座標
;;; nx ny は次方向への関数
;;; mark は自石。
(define find-aux
  (lambda (x y nx ny mark)
    (let ((m (get x y)))
      (cond
        ((_? m) #f)
        ((mark? m mark) (list x y))
        (else (find-aux (nx x) (ny y) nx ny mark))))))

;; (x y) が "_" で、
;; 次の場所に相手のコマがあり、
;; そのあと相手コマが続いた後に自石があればその座標、ないときは '()。
;; 調査方向を表す関数 nx, ny を引数で渡す。
(define find
  (lambda (x y nx ny mark)
    (and
     (_? (get x y))
     (mark? (get (nx x) (ny y)) (opposite mark))
     (find-aux (nx x) (ny y) nx ny mark))))

;; (x y) に m は置けるか？ == (x y) の縦横斜めに m があるか？
;; 戻り値はリスト。((x1 y1) (x2 y2) ... )
(define check
  (lambda (x y m)
    (filter
     identity
     (list (find x y sub1 identity m) ;; left
           (find x y add1 identity m) ;; rigt
           (find x y identity add1 m) ;; up
           (find x y identity sub1 m) ;; down
           (find x y sub1 sub1 m) ;; left up
           (find x y sub1 add1 m) ;; left down
           (find x y add1 sub1 m) ;; right up
           (find x y add1 add1 m) ;; right down
           ))))