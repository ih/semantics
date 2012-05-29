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

(test-case
 "basic test for select-action, checks that the correct action is selected"
 (let ([test-input '(1 0 1 0)])
   (reset-memory!)
   (process-input test-input)
   (check-equal? (select-action) alternate)
   (check-equal? plan '())))

(test-case
 "basic test for generate-plan, generate-plan should produce a single action of either flip or alternate for this binary classification problem"
 (let ([test-input '(1 0 1 0)])
   (process-input test-input)
   (check-equal? (generate-plan (first memory) 1)  (list alternate))))