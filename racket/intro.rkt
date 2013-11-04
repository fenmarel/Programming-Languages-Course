#lang racket
(provide (all-defined-out))

(define s "hello")
(define x 3)
(define y (+ x 2)) ; y = x + 2

(define cube1
  (lambda (x)
    (* x (* x x)))) ; fn x => x*x*x

(define (cube2 x)
  (* x x x))

(define (pow1 x y)
  (if (= y 0)
      1
      (* x (pow1 x (- y 1)))))

(define pow2
  (lambda (x)
    (lambda (y)
      (pow1 x y))))
      
(define three-to-the (pow2 3))  ; curried

; sum all numbers in list
(define (sum xs)
  (if (null? xs)
      0
      (+ (car xs) (sum (cdr xs)))))

; append
(define (my-append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (my-append (cdr xs) ys))))

; map
(define (my-map f xs)
  (if (null? xs)
      null
      (cons (f (car xs)) (my-map f (cdr xs)))))
      
