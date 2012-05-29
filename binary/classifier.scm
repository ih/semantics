#lang racket

(provide present-input feedback generator-choices)

(require "generators.scm"
         "basic-agent.scm")
;;; classification interface
(define INPUT-LENGTH 10)
(define GENERATORS (list flip alternate))
(define generator-choices '())



;; (present-input)
;; generator-choices
(define (present-input)
  (let ((generator (select-generator)))
    (set! generator-choices (cons generator generator-choices))
    (generator 1 0 INPUT-LENGTH)))

;;TODO move to library file
(define (random-element list)
  (list-ref list (random (length list))))

;;(select-generator)
(define (select-generator)
  (random-element GENERATORS))


;; (feedback #t)
;; (feedback #f)
;; actions
(define (feedback include-correct)
  (let ((output (equal? (first actions) (first generator-choices))))
    (if include-correct
        (list (first generator-choices) output)
        (list output))))