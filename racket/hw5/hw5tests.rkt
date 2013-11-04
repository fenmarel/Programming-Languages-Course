#lang racket

(require "hw5.rkt")

; tester pass/fail function
(define (test arg ans)
  (if (equal? arg ans)
      (display "pass\n")
      (display "fail\n")))

(define (test-eval arg ans)
  (if (equal? (eval-under-env arg testenv) ans)
      (display "pass\n")
      (display "fail\n")))

; tester vars
(define simplst (list (int 1) (int 2) (int 3)))
(define simpmlst (apair (int 1) (apair (int 2) (apair (int 3) (aunit)))))
(define simpmlst5 (apair (int 6) (apair (int 7) (apair (int 8) (aunit)))))
(define doubmlst (apair (int 2) (apair (int 4) (apair (int 6) (aunit)))))
(define testenv (list (cons "a" (int 1)) (cons "b" (int 2)) (cons "c" (int 3)) (cons "d" (aunit)))) 
(define testfun (fun "check" "c" (add (var "c") (var "c"))))
(define testmap (call mupl-map testfun))
(define testaddfive (call mupl-mapAddN (int 5)))

; a test case that uses problems 1, 2, and 4
; should produce (list (int 10) (int 11) (int 16))
(define test1
  (mupllist->racketlist
   (eval-exp (call (call mupl-mapAddN (int 7))
                   (racketlist->mupllist 
                    (list (int 3) (int 4) (int 9)))))))

(display "test for q1, q2, and q4:\n")
(test test1 (list (int 10) (int 11) (int 16)))

(display "\nq1 test\n")
(test (racketlist->mupllist simplst) simpmlst)
(test (racketlist->mupllist null) (aunit))
(test (mupllist->racketlist simpmlst) simplst)
(test (mupllist->racketlist (aunit)) null)

(display "\nq2 test\n")
(test-eval (var "b") (int 2))                                    ; var
(test-eval (add (int 2) (int 3)) (int 5))                        ; add
(test-eval (add (var "b") (var "c")) (int 5))                    ; add
(test-eval (int 3) (int 3))                                      ; int
(test-eval (ifgreater (int 1) (int 2) (int 3) (int 4)) (int 4))  ; ifgreater
(test-eval (ifgreater (int 3) (int 2) (int 3) (int 4)) (int 3))  ; ifgreater
(test-eval testfun (closure testenv testfun))                    ; fun
(test-eval (call testfun (int 5)) (int 10))                      ; call
(test-eval (mlet "x" (int 5) (add (var "x") (var "x"))) (int 10)); mlet
(test-eval (apair (var "a") (var "b")) (apair (int 1) (int 2)))  ; apair
(test-eval (fst (apair (var "a") (var "b"))) (int 1))            ; fst
(test-eval (snd (apair (var "a") (var "b"))) (int 2))            ; snd
(test-eval (aunit) (aunit))                                      ; aunit
(test-eval (isaunit (var "d")) (int 1))                          ; isaunit
(test-eval (isaunit (int 5)) (int 0))                            ; isaunit
(test-eval (closure testenv testfun) (closure testenv testfun))  ; closure

(display "\nq3 test\n")
(test-eval (eval-under-env (ifaunit (var "d") (var "a") (var "b")) testenv) (int 1))
(test-eval (eval-under-env (ifaunit (var "a") (var "a") (var "b")) testenv) (int 2))
(test-eval (mlet* (cons (cons "x" (int 1)) null) (var "x")) (int 1))
(test-eval (ifeq (var "a") (var "a") (var "b") (var "c")) (int 2)) 
(test-eval (ifeq (var "a") (var "b") (var "b") (var "c")) (int 3)) 

(display "\nq4 test\n")
(test-eval (call testmap simpmlst) doubmlst)
(test-eval (call testaddfive simpmlst) simpmlst5)

           
