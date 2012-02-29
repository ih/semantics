;; unique readable symbols. this is used to enumerate lists and to
;; generate readable variable names.

#lang racket

(provide sym! reset-symbol-indizes! set-symbol-index!)

(require srfi/1
         srfi/69)

(define symbol-counts (make-hash-table)) ;EFFICIENCY change equality test to eq?


;;(sym! 'F)
;;(sym! 'g)
(define (sym! tag)
  (inc-symbol-count! tag)
  (string->symbol (string-append (symbol->string tag)
                                 (number->string (get-count symbol-counts tag)))))

;;(inc-symbol-count! 'F)
;;(get-count symbol-counts 'F)
(define (inc-symbol-count! tag)
  (let ([old-count (get-count symbol-counts tag)])
   (set-count! symbol-counts tag (+ old-count 1))))


(define (set-count! symbol-counts tag new-count) ;consider removing this layer of abstraction until needed
  (hash-table-set! symbol-counts tag new-count)) 

;;this layer of abstraction is used so that get-count can retrieve an entry or create a new one if it doesn't exist
(define (get-count symbol-counts tag)
  (if (hash-table-exists? symbol-counts tag)
      (hash-table-ref symbol-counts tag)
      (hash-table-set! symbol-counts tag 0)))
