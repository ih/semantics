#lang racket

(provide process-input
         select-action
         record-action
         actions
         reset-actions!
         memory
         reset-memory!)

(require "interpreter.scm"
         "generators.scm"
         "classifier.scm")

;;a history of inputs
(define memory '())
(define (reset-memory!) (set! memory '()))

;;a history of actions
(define actions '())
(define (reset-actions!) (set! actions '()))

(define (record-action action) (set! actions (cons action actions)))

(define goal 1)



(define plan '())
;(cons-programs (flip 1 0 5))
(define (cons-programs binary-string)
  (if (null? binary-string)
      ''()
      (list 'cons (car binary-string) (cons-programs (cdr binary-string))))) ;use pair instead of cons

;; (process-input (present-input))
;; memory
(define (process-input stimuli)
  (let ((input-program (cons-programs stimuli)))
    (begin
      (set! memory (cons input-program memory))
      input-program)))

;;
(define (select-action)
  (let ((input (first memory)))
    (if (or (null? plan) (not (equal? input (predicted-input plan))))
        (begin
          (generate-plan input goal)
          (next-step plan))
        (next-step plan))))


(define (predicted-input plan) 'todoA)

;;reverse the evaluation in the interpreter
(define (generate-plan input goal) 'todoB)

(define (next-step) 'todoC)

