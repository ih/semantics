#lang racket

(provide process-inputs)

(require "basic-agent.scm"
         "classifier.scm")


;;(interaction-loop 1)

;;; classify a number of random generated examples
;; (define (interaction-loop iterations)
;;   (if (= iterations 0)
;;       'done
;;       (let*
;;           ;;store latest input created by the environment into the agent's "memory"
;;           (process-input (present-input))
;;         ;;select the next action according to an internal plan the agent has and have the environment determine the feedback
;;         (classify (select-action))
;;         ;;TODO determine how feedback goes back into the agent
;;         (feedback #f))))

;TODO test import have agent be passed into process-inputs for testing purposes
;;first argument is a list of input-goal pairs i.e. a list of tasks the agent should complete
(define (process-tasks input-goal-pairs)
  (if (null? input-goal-pairs)
      actions
      (let* ((current-input-goal-pair (car input-goal-pairs))
             (input (car current-input-goal-pair))
             (goal (cdr current-input-goal-pair)))
        (process-input input)
        (record-action (select-action))
        (feedback #f)
        (process-inputs (cdr input-goal-pairs)))))
