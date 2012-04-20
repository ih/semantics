(require "agent.scm"
         "classifier.scm")
(interaction-loop 1)

;;; classify a number of random generated examples
(define (interaction-loop iterations)
  (if (= iterations 0)
      'done
      (let*
          ;;store latest input created by the environment into the agent's "memory"
          (process-input (present-input))
        ;;select the next action according to an internal plan the agent has and have the environment determine the feedback
        (classify (select-action))
        ;;TODO determine how feedback goes back into the agent
        (feedback #f))))