(require "interpreter.scm"
         "generators.scm"
         "classifier.scm")


(define plan '())
;;(cons-programs (flip 1 0 5))
(define (cons-programs binary-string)
  (if (null? binary-string)
      ''()
      (list 'cons (car binary-string) (cons-programs (cdr binary-string))))) ;use pair instead of cons

;;(process-input (present-input))
(define (process-input stimuli)
  (let ((input-program (cons-programs stimuli)))
    input-program))

;;
(define (select-action input)
  (if (or (null? plan) (not (equal? input (predicted-input plan))))
      (generate-plan input goal)
      (next-step plan)))

