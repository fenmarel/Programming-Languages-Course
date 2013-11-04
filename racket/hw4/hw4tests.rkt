#lang racket

(require "hw4.rkt") 

; hw4 test file
; test functions
(define (ones) (cons 1 ones))

(define nats
  (letrec ([f (lambda (x) (cons x (lambda () (f (+ x 1)))))])        ; CLEANUP TESTS
    (lambda () (f 1))))

(define pow-twos
  (letrec ([f (lambda (x) (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 1))))

(define p10tester
  (cached-assoc (list (cons 1 2) (cons 3 4) (cons 5 6) (cons 7 8)) 3))


; begin testing
(display "Problem 1: \n")  
(if (equal? (sequence 3 11 2) (list 3 5 7 9 11)) (display "pass\n") (display "fail\n"))
(if (equal? (sequence 3 8 3) (list 3 6)) (display "pass\n") (display "fail\n"))
(if (equal? (sequence 3 2 1) null) (display "pass\n\n") (display "fail\n\n"))

(display "Problem 2: \n")
(if (equal? (string-append-map (list "foo" "bar" "baz" "qux") "woo!") (list "foowoo!" "barwoo!" "bazwoo!" "quxwoo!" )) (display "pass\n") (display "fail\n"))
(if (equal? (string-append-map (list "foo") "woo!") (list "foowoo!")) (display "pass\n") (display "fail\n"))
(if (equal? (string-append-map null "woo!") null) (display "pass\n\n") (display "fail\n\n"))

(display "Problem 3: \n")
;(if (equal? (list-nth-mod (list 1 2 3 4 5) (- 8)) 4) (display "pass\n") (display "fail\n"))     -> error: list-nth-mod: negative number
;(if (equal? (list-nth-mod null 8) 4) (display "pass\n") (display "fail\n"))                     -> error: list-nth-mod: empty list
(if (equal? (list-nth-mod (list 1 2 3 4 5) 8) 4) (display "pass\n") (display "fail\n"))
(if (equal? (list-nth-mod (list 1) 8) 1) (display "pass\n") (display "fail\n"))
(if (equal? (list-nth-mod (list 1 2 3 4 5) 0) 1) (display "pass\n\n") (display "fail\n\n"))

(display "Problem 4: \n")
(if (equal? (stream-for-n-steps nats 3) (list 1 2 3)) (display "pass\n") (display "fail\n"))
(if (equal? (stream-for-n-steps ones 5) (list 1 1 1 1 1)) (display "pass\n") (display "fail\n"))
(if (equal? (stream-for-n-steps ones 0) null) (display "pass\n") (display "fail\n"))
(if (equal? (stream-for-n-steps pow-twos 7) (list 1 2 4 8 16 32 64)) (display "pass\n\n") (display "fail\n\n"))

(display "Problem 5: \n")
(if (equal? (stream-for-n-steps funny-number-stream 5) (list 1 2 3 4 (- 5))) (display "pass\n") (display "fail\n"))
(if (equal? (stream-for-n-steps funny-number-stream 10) (list 1 2 3 4 (- 5) 6 7 8 9 (- 10))) (display "pass\n") (display "fail\n"))
(if (equal? (stream-for-n-steps funny-number-stream 15) (list 1 2 3 4 (- 5) 6 7 8 9 (- 10) 11 12 13 14 (- 15))) (display "pass\n\n") (display "fail\n\n"))

(display "Problem 6: \n")
(if (equal? (stream-for-n-steps dan-then-dog 1) (list "dan.jpg")) (display "pass\n") (display "fail\n"))
(if (equal? (stream-for-n-steps dan-then-dog 3) (list "dan.jpg" "dog.jpg" "dan.jpg")) (display "pass\n") (display "fail\n"))
(if (equal? (stream-for-n-steps dan-then-dog 5) (list "dan.jpg" "dog.jpg" "dan.jpg" "dog.jpg" "dan.jpg")) (display "pass\n\n") (display "fail\n\n"))

(display "Problem 7: \n")
(if (equal? (stream-for-n-steps (stream-add-zero nats) 3) (list (cons 0 1) (cons 0 2) (cons 0 3))) (display "pass\n") (display "fail\n"))
(if (equal? (stream-for-n-steps (stream-add-zero ones) 5) (list (cons 0 1) (cons 0 1) (cons 0 1) (cons 0 1) (cons 0 1))) (display "pass\n") (display "fail\n"))
(if (equal? (stream-for-n-steps (stream-add-zero ones) 0) null) (display "pass\n") (display "fail\n"))
(if (equal? (stream-for-n-steps (stream-add-zero pow-twos) 7) (list (cons 0 1) (cons 0 2) (cons 0 4) (cons 0 8) (cons 0 16) (cons 0 32) (cons 0 64))) (display "pass\n\n") (display "fail\n\n"))

(display "Problem 8: \n")
(if (equal? (stream-for-n-steps (cycle-lists (list 1 2 3) (list "a" "b" "c")) 5) (list (cons 1 "a") (cons 2 "b") (cons 3 "c") (cons 1 "a") (cons 2 "b"))) (display "pass\n") (display "fail\n"))
(if (equal? (stream-for-n-steps (cycle-lists (list 1 2 3) (list "a" "b" "c" "d")) 7) (list (cons 1 "a") (cons 2 "b") (cons 3 "c") (cons 1 "d") (cons 2 "a") (cons 3 "b") (cons 1 "c"))) (display "pass\n\n") (display "fail\n\n"))

(display "Problem 9: \n")
(if (equal? (vector-assoc "foo" #(("foo" . 0) ("bar" . 1) ("baz" . 3))) (cons "foo" 0)) (display "pass\n") (display "fail\n"))
(if (equal? (vector-assoc "foo" #(1 8 "hi" "foo" ("foo" . 0) ("bar" . 1) ("baz" . 3))) (cons "foo" 0)) (display "pass\n") (display "fail\n"))
(if (equal? (vector-assoc "baz" #(("foo" . 0) ("bar" . 1) ("baz" . 3))) (cons "baz" 3)) (display "pass\n") (display "fail\n"))
(if (equal? (vector-assoc "baz" #(("foo" . 0) "hello" ("bar" . 1) "world" ("baz" . 3))) (cons "baz" 3)) (display "pass\n") (display "fail\n"))
(if (equal? (vector-assoc "qux" #(("foo" . 0) ("bar" . 1) ("baz" . 3))) #f) (display "pass\n\n") (display "fail\n\n"))

(display "Problem 10: \n")
(if (equal? (p10tester 1) (cons 1 2)) (display "pass\n") (display "fail\n"))
(if (equal? (p10tester 3) (cons 3 4)) (display "pass\n") (display "fail\n"))
(if (equal? (p10tester 2) #f) (display "pass\n\n") (display "fail\n\n"))
(display "p10 cached: \n")
(if (equal? (p10tester 1) (cons 1 2)) (display "pass\n") (display "fail\n"))
(if (equal? (p10tester 3) (cons 3 4)) (display "pass\n") (display "fail\n"))
(if (equal? (p10tester 2) #f) (display "pass\n\n\n") (display "fail\n\n\n"))

(display "Problem 11: \n")
(define a 2)
(display "compare: \n")
(display "\"x\"\"x\"\"x\"\"x\"\"x\"#t\n")
(while-less 7 do (begin (set! a (+ a 1)) (print "x") a))
(if (= a 7) (display "pass\n\n") (display "fail\n\n"))
(display "compare: \n")
(display "\"x\"#t\n")
(while-less 7 do (begin (set! a (+ a 1)) (print "x") a))
(if (= a 8) (display "pass\n\n") (display "fail\n\n"))

