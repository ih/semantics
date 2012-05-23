(require rackunit "interpreter.scm")

(check)

;;;single-step plan

;;;multi-step plan


;; (use-modules (srfi srfi-1)
;;              (srfi sr                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       fi-69)
;;              (srfi srfi-34))
;; ;;;scan tests


;; (define test-frame (make-hash-table))
;; (hash-table-set! test-frame 'x 5)
;; (hash-table-ref test-frame 'x)

;; (define variable 'y)

;; (define (scan frame)
;;     (guard (exception ((eq? exception 'key-error) (cons #f 'error)))
;;            (cons #t (hash-table-ref frame variable (lambda () (raise 'key-error))))))

;; (scan test-frame2)

;; ;;;lookup-variable-value test
;; (define test-frame2 (make-hash-table))
;; (hash-table-set! test-frame2 'y 3)

;; (define test-environment (list test-frame test-frame2))

;; (lookup-variable-value 'y test-environment)