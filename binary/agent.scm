#lang racket

(provide process-input
         select-action
         record-action
         actions
         reset-actions!
         memory
         reset-memory!
         plan
         reset-plan!
         generate-plan)

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

(define goal 1) ;;goal should be set in process-tasks in the construct

(define plan '())
(define (reset-plan! new-plan) (set! plan '()))

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
          (next-step)) 
        (next-step))))


(define (predicted-input plan) 'todoA)

;;reverse the evaluation in the interpreter
;;only considering a single step for this problem
(define (generate-plan input goal)
  (list (reverse-evaluate input goal)))

;;return the next step in the plan and "pop" it from the list
(define (next-step)
  (display plan)
  (if (null? plan)
      '()
      (let ((next (car plan)))
        (set! plan (cdr plan))
        next)))

