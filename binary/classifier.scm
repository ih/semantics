#lang racket

(provide present-input)

(require "generators.scm")
;;; classification interface
(define INPUT-LENGTH 10)
(define GENERATORS (list flip alternate))
(define generator-choices '())
(define decisions '())

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

;; (classify flip)
;; (classify alternate)
;; decisions
(define (classify decision)
  (set! decisions (cons decision decisions)))

;; (feedback #t)
;; (feedback #f)
;; decisions
(define (feedback include-correct)
  (let ((output (equal? (first decisions) (first generator-choices))))
    (if include-correct
        (list (first generator-choices) output)
        (list output))))