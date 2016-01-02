
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below
(define (sequence low high stride)
    (if (= low high)
        (cons high null)
        (cons low (sequence (+ low stride) high stride))))

(define (string-append-map xs s)
    (map (lambda (x) (string-append x s)) xs))

(define (list-nth-mod xs n)
    (cond [(< n 0) (error "list-nth-mod: negative number")]
          [(null? xs) (error "list-nth-mod: empty list")]
          [#t (letrec ([f (lambda (x xs) (if (= x 0) (car xs) (f (- x 1) (cdr xs))))])
                (f (remainder n (length xs)) xs))]))

(define (stream-for-n-steps s n)
    (if (= n 1)
        (cons (car (s)) null)
        (letrec ([pr (s)])
            (cons (car pr) (stream-for-n-steps (cdr pr) (- n 1))))))

(define (funny-number-stream)
    (letrec ([f (lambda (x) (if (= 0 (remainder x 5))
                            (cons (- 0 x) (lambda () (f (+ x 1))))
                            (cons x (lambda () (f (+ x 1))))))])
        (f 1)))

(define (dan-then-dog)
    (letrec ([f (lambda (x) (if x 
                            (cons "dan.jpg" (lambda () (f #f)))
                            (cons "dog.jpg" (lambda () (f #t)))))])
        (f #t)))

(define (stream-add-zero s)
    (letrec ([f (lambda (s) 
                    (letrec ([pr (s)])
                        (cons (cons 0 (car pr)) (lambda () (f (cdr pr))))))])
        (lambda () (f s))))

(define (cycle-lists xs ys)
    (letrec ([f (lambda (n) 
                    (cons (cons (list-nth-mod xs n) (list-nth-mod ys n)) 
                          (lambda () (f (+ n 1)))))])
        (lambda () (f 0))))

(define (vector-assoc v vec)
    (letrec ([len (vector-length vec)]
             [f (lambda (n) 
                    (if (= len n)
                        #f
                        (letrec ([pr (vector-ref vec n)])
                            (if (pair? pr)
                                (if (equal? (car pr) v)
                                    pr
                                    (f (+ n 1)))
                                (f (+ n 1))))))])
        (f 0)))

(define (cached-assoc xs n)
    (letrec ([index 0]
            [memo (make-vector n #f)]
            [f (lambda (v) (letrec ([result (vector-assoc v memo)])
                                (if result
                                    result
                                    (letrec ([new-result (assoc v xs)])
                                        (begin (vector-set! memo index new-result)
                                                (set! index (remainder (+ index 1) n))
                                                new-result
                                                )))))])
                f))

(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (letrec ([f1 (lambda ()
        (letrec ([f2 (lambda () e2)])
            (if (< (f2) e1)
                (f1)
                #t)))])
        (f1))]))



