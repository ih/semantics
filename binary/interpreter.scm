#lang racket

(provide evaluate least-general-generalization)

(require srfi/1
         srfi/69
         srfi/34
         "sym.scm"
         racket/trace)



(define PRE 'pre)
(define POST 'post)
(define INITIAL-CONDITION 'initial)

(define global-environment
  (let* ((start-frame (make-hash-table)))
    (begin
      (hash-table-set! start-frame 'cons cons)
      (list start-frame))))

(define all-semantics (make-hash-table))

;;; TODO is empty list the right thing for empty semantics
(define initial-semantics (list INITIAL-CONDITION INITIAL-CONDITION))

(define (clear-semantics!)
   (set! all-semantics (make-hash-table)))


;; (evaluate '(cons 1 '()) global-environment)
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
  (begin (learn-semantics! procedure arguments)
         (apply-semantics procedure arguments)))
  ;; (cond ((primitive-procedure? procedure) (apply-primitive-procedure procedure arguments))
  ;;       ((semantics-known? procedure) (apply-semantics procedure arguments))
  ;;       ((compound-procedure? procedure) (learn-semantics-and-apply procedure arguments))))

;;TODO should this take an environment?
;; (clear-semantics!)
;; (learn-semantics! + '(2 3))

;; (semantics-lookup +)
;; (learn-semantics! + '(2 5))
;; (semantics-lookup +)
(define (learn-semantics! procedure arguments)
  (let* ((output (apply procedure arguments))
         (current-semantics (semantics-lookup procedure))
         (pre-condition (get-pre-condition current-semantics))
         (pre-condition-abstraction (abstract pre-condition arguments))
         (post-condition (get-post-condition current-semantics))
         (post-condition-abstraction (abstract post-condition output)))
    (begin
      (set-pre-condition! procedure pre-condition-abstraction)
      (set-post-condition! procedure post-condition-abstraction)
      (unify-conditions! procedure))))

;;; for now keep semantics for all procedures in a global hash-table; in future this datastructure might change to address the compositional nature of semantics
(define (semantics-lookup procedure)
  (define (add-procedure-to-semantics!)
    (begin)
    (hash-table-set! all-semantics procedure initial-semantics)
    (hash-table-ref all-semantics procedure))
  (hash-table-ref all-semantics procedure add-procedure-to-semantics!))

(define (semantics-update! procedure new-semantics)
  (hash-table-set! all-semantics procedure new-semantics))


(define get-pre-condition first)

(define get-post-condition second)

(define create-semantics list)



;;;test for semantics-lookup
;; (define test-lookup (semantics-lookup 'cons))
;; (get-pre-condition test-lookup)

;; (abstract '(+ 2 2) '(+ 2 3))
;; (abstract 2 2)
;; (abstract INITIAL-CONDITION '(+ 2 3))
(define (abstract expression-1 expression-2)
  (cond ((initial-condition? expression-1) expression-2)
        ((initial-condition? expression-2) expression-1)
        (else (least-general-generalization expression-1 expression-2)))) ;;defining this level of abstraction will be useful for swapping out different methods for generalizing between two expressions


;;TODO put various implementations of abstract into their own module
;; (trace least-general-generalization)
;; (least-general-generalization '3 '(+ 4 5))
;; (least-general-generalization '(+ 4 5) '3)

;; (least-general-generalization '(+ 2 2) '(+ 2 3))
;; (least-general-generalization 2 2)
(define (least-general-generalization expression-1 expression-2)
  (cond ((not (list? expression-1)) (if (eq? expression-1 expression-2) expression-1 (new-variable!))) ;;TODO have new-variable! also save instances of the variable or create a layer over new-variable! that does it
        ((not (list? expression-2)) (new-variable!))
        ((null? expression-1) '())
        ((not (= (length expression-1) (length expression-2))) (new-variable!)) ;;TODO is this condition necessary? how would relaxing it help?
        ((eq? (root expression-1) (root expression-2)) (cons (root expression-1) (map least-general-generalization (cdr expression-1) (cdr expression-2)))))) ;;TODO cache root if costly



(define (initial-condition? expression)
  (eq? expression INITIAL-CONDITION))

(define root car)


;;(new-variable!)
(define (new-variable!)
  (sym! 'V))



;;TODO put all semantics related functionality into it's own module
;;(set-pre-condition! 'add '(+ 2 3))
;;(semantics-lookup 'add)

;;TODO abstract commonality between set-pre-condition and set-post-condition
(define (set-pre-condition! procedure pre-condition-abstraction)
  (let* ([old-semantics (semantics-lookup procedure)]
        [new-semantics (create-semantics pre-condition-abstraction (get-post-condition old-semantics))])
    (semantics-update! procedure new-semantics)))

(define (set-post-condition! procedure post-condition-abstraction) 
  (let* ([old-semantics (semantics-lookup procedure)]
        [new-semantics (create-semantics (get-pre-condition old-semantics) post-condition-abstraction)])
    (semantics-update! procedure new-semantics)))

(define (unify-conditions! procedure) 'TODOi)

(define (primitive-procedure? procedure) (equal? procedure cons))

(define (apply-primitive-procedure procedure arguments) 'applying-primitive) 

(define (semantics-known? procedure) 'TODOa)

(define (apply-semantics procedure arguments) 'TODOb)

(define (compound-procedure? procedure) (tagged-list? procedure 'procedure)) ;;TODO add lambda to language in order to test this

(define (tagged-list? object tag)
  (if (pair? object)
      (eq? (car object) tag)
      #f))

(define (learn-semantics-and-apply procedure arguments) 'TODOd)


(define application? pair?)

;;move to library
(define rest cdr)

(define operator first)

(define operands rest)

;;;back track from output to input
;;;return a list of possible action sequences
;;'(a) r1: c->a r2: b->a r3: b->c

(define (reverse-evaluate input hypotheses environment)
  (let* ((matches (find-matches all-semantics hypotheses))
         (extended-plans (extend-plans input matches hypotheses)))
    (if (equal? extended-plans hypotheses)
        hypotheses
        (reverse-evaluate input extended-plans environment))))


