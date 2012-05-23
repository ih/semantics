#lang racket

(provide process-input
         select-action
         record-action
         actions
         reset-actions!)

(require "generators.scm")

(define (process-input input) '())
(define (select-action) flip)

(define actions '())

(define (reset-actions!)
  (set! actions '()))

;; (classify flip)
;; (classify alternate)
;; actions
(define (record-action decision)
  (set! actions (cons decision actions)))
