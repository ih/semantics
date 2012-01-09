(define (evaluate expression)
  (cond ((self-evaluating? expression) expression)
        ((application? ))
        (else 'error)))

(define (self-evaluating? expression)
  (or (equal? expression 0) (equal? expression 1)))