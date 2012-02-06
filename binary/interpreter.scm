(use-modules (srfi srfi-1)
             (srfi srfi-69)
             (srfi srfi-34))

(define global-environment
  (let* ((start-frame (make-hash-table)))
    (begin
      (hash-table-set! start-frame 'cons cons)
      (list start-frame))))

(define (evaluate expression environment) 
  (cond ((self-evaluating? expression) expression)
        ((variable? expression) (lookup-variable-value expression environment))
        ((application? expression) (semantic-apply (evaluate (operator expression) environment) (operands expression)))
        (else 'error)))

(define (self-evaluating? expression)
  (or (equal? expression 0) (equal? expression 1)))

(define variable? symbol?)

;;TODO move environment-related code into a separate file
;;;goes through each frame of the environment looking for the target variable and returns the corresponding value if found
(define (lookup-variable-value variable environment)
  (define variable-found? car)
  (define first-frame car)
  (define variable-value cdr)
  (define enclosing-environment cdr)
  (define empty? null?)
;;;checks whether variable is in the frame
  (define (scan frame)
    (guard (exception ((eq? exception 'key-error) (cons #f 'error)))
           (cons #t (hash-table-ref frame variable (lambda () (raise 'key-error))))))
  
  (if (empty? environment)
      'error
      (let* ((scan-result (scan (first-frame environment))) ;;TODO change this to catching an exception rather than using an error code
             (found (variable-found? scan-result))
             (value (variable-value scan-result)))
        (if found
            value
            (lookup-variable-value variable (enclosing-environment environment))))))

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




