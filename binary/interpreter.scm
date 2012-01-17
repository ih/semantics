(use-modules (srfi srfi-1))

(define (evaluate expression) 
  (cond ((self-evaluating? expression) expression)
        ((variable? expression) (lookup-variable-value expression))
        ((application? expression) (semantic-apply (evaluate (operator expression)) (operands expression)))
        (else 'error)))

(define (self-evaluating? expression)
  (or (equal? expression 0) (equal? expression 1)))

(define variable? symbol?)


(define (lookup-variable-value expression) 'TODO)

(define (semantic-apply procedure arguments)
  (cond ((primitive-procedure? procedure) (apply-primitive-procedure procedure arguments))
        ((semantics-known? procedure) (apply-semantics procedure arguments))
        ((compound-procedure? procedure) (learn-semantics-and-apply procedure arguments))))

(define (primitive-procedure? procedure) (equal? procedure 'cons))

(define (apply-primitive-procedure procedure arguments) 'applying-primitive) ;;TODO implement

(define (semantics-known? procedure) 'TODOa)

(define (apply-semantics procedure arguments) 'TODOb)

(define (compound-procedure? procedure) (tagged-list? procedure 'procedure)) ;;TODO add lambda to language in order to test this

(define (tagged-list? object tag)
  (if (pair? object)
      (eq? (car object) tag)
      #f))



(define (learn-semantics-and-apply procedure arguments) 'TODOd)

(define application? pair?)

(define operator first)

(define operands rest)

;;move to library
(define rest cdr)




