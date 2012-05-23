(require rackunit "agent.scm")
(require "classifier.scm"
         "generators.scm"
         "agent.scm")

(test-case
 "process-input sanity test, check if the evaluated first memory is the same as the last input"
 (let ([test-input '(1 0 1 0)])
   (reset-memory!)
   (process-input test-input)
   (check-equal? test-input (eval (first memory)))))
