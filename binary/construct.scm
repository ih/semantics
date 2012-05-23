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
(define (process-inputs inputs)
  (if (null? inputs)
      actions
      (begin
        (process-input (car inputs))
        (record-action (select-action))
        (feedback #f)
        (process-inputs (cdr inputs)))))
