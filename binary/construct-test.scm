(require rackunit "construct.scm")
(require "classifier.scm"
         "generators.scm"
         "agent.scm")




(define test-inputs (list (cons (present-input) 'REWARD)))
(test-case
 "basic agent process-tasks"
 (begin
   (reset-actions!)
   (check-equal? (process-tasks test-inputs) (list flip))))

;;test for process-input is to see if eval of first thing in memory is the input
test-inputs
actions