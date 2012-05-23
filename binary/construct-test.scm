(require rackunit "construct.scm")
(require "classifier.scm"
         "generators.scm"
         "basic-agent.scm")




(define test-inputs (list (present-input)))
(test-case
 "basic agent process-inputs"
 (begin
   (reset-actions!)
   (check-equal? (process-inputs test-inputs) (list flip))))

;;test for process-input is to see if eval of first thing in memory is the input
test-inputs
actions