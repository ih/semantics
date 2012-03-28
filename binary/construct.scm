(require "agent.scm"
         "classifier.scm")

(define (interaction-loop iterations)
  (if (= iterations 0)
      'done
      (begin
        (process-input (present-input))
        (classify (select-action))
        (feedback #f))))