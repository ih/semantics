#lang racket

(provide flip alternate)

;;different 1 0 patterns with varying amounts of abstraction in their generation
(define (flip x y repetitions)
  (if (= repetitions 0)
      '()
      (append (list x y) (flip y x (- repetitions 1)))))

(define (alternate x y repetitions)
  (if (= repetitions 0)
      '()
      (append (list x y) (alternate x y (- repetitions 1)))))

(define (flatten x)
  (if (null? x)
      x
      (if (not (list? x))
          (list x)
          (append (flatten (car x)) (flatten (cdr x))))))